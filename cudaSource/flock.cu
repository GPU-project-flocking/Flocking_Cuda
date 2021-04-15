#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda_runtime_api.h>
#include <stdio.h>
#include <device_functions.h>
#include <cuda.h>
#include <crt/host_defines.h>

#include <iostream>
#include <cstdlib>
#include <stdio.h>
#include <string>
#include <chrono>


//global variables
float2* pos_dev;
float2* vel_dev;
float2* acc_dev;

float2* sep_dev;
float2* align_dev;
float2* cohesion_dev;

float2* pos_host;
float2* vel_host;

float2  averagePos;
float2 averageForward;

#define BlockSize 256
#define NBOIDS 5
#define FLOCKING_RAD 50.0f;
#define COHESION_STRENGTH 1.0f;
#define ALIGNMENT_STRENGTH 1.0f;
#define SEPARATION_STRENGTH 1.0f;
#define SAFE_RADIUS 5.0f;
#define MAX_SPEED 5.0f;

//vector math -- may update functions

__device__
float2 negateVector(float2 a) {
	float2 negated;
	negated.x = -a.x;
	negated.y = -a.y;
	return negated;
}

__device__
bool vector2dEquals(float2 a, float2 b) {
	if (a.x == b.x && a.y == b.y) {
		return true;
	} else {
		return false;
	}
}

__device__
float distance(float2 myPos, float2 theirPos) {
	float dx = myPos.x - theirPos.x;
	float dy = myPos.y - theirPos.y;

	float dist = sqrt(dx*dx + dy*dy);
	return dist;
}


__device__
float2 add2dVectors(float2 v1, float2 v2) {
	float2 temp = make_float2(v1.x, v1.y);
	temp.x += v2.x;
	temp.y += v2.y;
	return temp;
}

__device__
float2 sub2dVectors(float2 v1, float2 v2) {
	float2 temp = make_float2(v1.x, v1.y);
	temp.x -= v2.x;
	temp.y -= v2.y;
	return temp;
}

__device__
float2 mulVectorByScalar(float scalar, float2 vector) {
	// Temp to not overwrite original vector
	float2 temp = make_float2(vector.x, vector.y);
	temp.x *= scalar;
	temp.y *= scalar;
	return temp;
}

__device__
float2 divVectorByScalar(float scalar, float2 vector) {
	float2 temp = make_float2(vector.x, vector.y);
	temp.x /= scalar;
	temp.y /= scalar;
	return temp;
}

__device__
float calcLength(float2 vec) {
	return sqrt(vec.x * vec.x + vec.y * vec.y
	);
}

__device__
float2 normalizeVector(float2 vector) {
	float2 temp = make_float2(vector.x, vector.y);
	float length = calcLength(temp);
	if (length > 0) {
		temp.x /= length;
		temp.y /= length;
	}
	return temp;
}

//-----------------end vec funcs------------------------

__host__ void calc_average_forward() {
	int counter = 0;
	float2 sum = make_float2(0.0, 0.0);
	for (int i = 0; i < NBOIDS; i++) {
		sum.x += vel_host[i].x;
		sum.y += vel_host[i].y;
		counter++;
	}
	averageForward.x = sum.x / counter;
	averageForward.y = sum.y / counter;
}

__host__ void calc_average_pos() {
	int counter = 0;
	float2 sum = make_float2(0.0, 0.0);
	for (int i = 0; i < NBOIDS; i++) {
		sum.x += pos_host[i].x;
		sum.y += pos_host[i].y;
		counter++;
	}
	averagePos.x = sum.x / counter;
	averagePos.y = sum.y / counter;
}

__global__ void updatePos(int numBoids, float2* vel_dev, float2* pos_dev) {
	int i = (blockIdx.x * blockDim.x) + threadIdx.x;

	if (i < numBoids) {
		if (pos_dev[i].x > 10000.0f || pos_dev[i].y > 10000.0f) {
			pos_dev[i].x = 0;
			pos_dev[i].y = 0;
		}
		

		pos_dev[i] = add2dVectors(pos_dev[i], vel_dev[i]);
		//pos_dev[i] = newPos;
	}
}

__device__ float2 calc_separation_accel(int numBoids, float2* pos_dev, float2* vel_dev) {
	int i = (blockIdx.x * blockDim.x) + threadIdx.x;
	float safeDist = SAFE_RADIUS;
	safeDist = safeDist + safeDist;
	float separationStrength = SEPARATION_STRENGTH;
	float2 totalVel = make_float2(0.0f, 0.0f);

	if (i < numBoids) { 
		float2 boidPos = make_float2(pos_dev[i].x, pos_dev[i].y);
		float2 boidVel = make_float2(vel_dev[i].x, vel_dev[i].y);

		for (int i = 0; i < numBoids; i++) {
			//printf("%s", vector2dEquals(boidPos, pos_dev[i]) && vector2dEquals(boidVel, vel_dev[i]) ? "true\n" : "");
			float2 siblingPos = pos_dev[i];
			float2 siblingVel = vel_dev[i];
			//check to see if current boid is self
			if (vector2dEquals(boidPos, siblingPos) && vector2dEquals(boidVel, siblingVel)) {
				continue;
			}

			float2 accel = sub2dVectors(boidPos, siblingPos);
			float dist = calcLength(accel);
			//printf("%d ", pos_dev[i].x);
			//toggle int
			if (dist > 8.0f) {
				continue;
			}
			if (dist < safeDist) {
				accel = normalizeVector(accel);
				accel = divVectorByScalar(safeDist, mulVectorByScalar((safeDist - dist), accel));
				totalVel = add2dVectors(totalVel, accel);
			}
		}

		if (calcLength(totalVel) > 1) {
			totalVel = normalizeVector(totalVel);
		}

		return mulVectorByScalar(separationStrength, totalVel);
	}

	return make_float2(0.0f, 0.0f);
}

__device__ float2 calc_alignment_accel(int numBoids, float2 averageForward) {
	float maxSpeed = MAX_SPEED;
	float alignStr = ALIGNMENT_STRENGTH;

	int i = (blockIdx.x * blockDim.x) + threadIdx.x;

	if (i < numBoids) {
		float2 accel = divVectorByScalar(maxSpeed, averageForward);
		if (calcLength(accel) > 1) {
			accel = normalizeVector(accel);
		}
		return mulVectorByScalar(alignStr, accel);
	}
	return make_float2(0.0f, 0.0f);
}

__device__ float2 calc_cohesion_accel(int numBoids, float2 averagePos, float2* pos_dev) {
	float flockRad = FLOCKING_RAD;
	float cohesionStr = COHESION_STRENGTH;

	int i = (blockIdx.x * blockDim.x) + threadIdx.x;
	if (i < numBoids) {
		float2 accel = sub2dVectors(averagePos, pos_dev[i]);
		float dist = calcLength(pos_dev[i]);

		accel = normalizeVector(accel);

		if(dist < flockRad) {
			accel = mulVectorByScalar(dist, accel);
			accel = divVectorByScalar(flockRad, accel);
		}

		return mulVectorByScalar(cohesionStr, accel);
	}
	return make_float2(0.0f, 0.0f);
}

__global__
void generateInitialPosition(int numBoids, float2* pos_dev, float2* vel_dev, float2* acc_dev, float2* sep_dev, float2* align_dev, float2* cohesion_dev) {
	int i = (blockIdx.x * blockDim.x) + threadIdx.x;
	if (i < numBoids) {
		pos_dev[i].x = 0.0f;
		pos_dev[i].y = 0.0f;
		vel_dev[i].x = 0.0f;
		vel_dev[i].y = 0.0f;
		acc_dev[i].x = 0.0f;
		acc_dev[i].y = 0.0f;
		sep_dev[i].x = 0.0f;
		sep_dev[i].y = 0.0f;
		align_dev[i].x = 0.0f;
		align_dev[i].y = 0.0f;
		cohesion_dev[i].x = 0.0f;
		cohesion_dev[i].y = 0.0f;
		
	}
	
}

__host__
void startCuda(int numBoids) {
	//printf("\nDefining cuda variables\n");
	dim3 fullBlocksPerGrid((int)ceil(float(numBoids) / float(BlockSize)));

	// Malloc for device
	cudaMalloc((void**)&pos_dev, numBoids * sizeof(float2));
	cudaMalloc((void**)&vel_dev, numBoids * sizeof(float2));
	cudaMalloc((void**)&acc_dev, numBoids * sizeof(float2));

	cudaMalloc((void**)&sep_dev, numBoids * sizeof(float2));
	cudaMalloc((void**)&align_dev, numBoids * sizeof(float2));
	cudaMalloc((void**)&cohesion_dev, numBoids * sizeof(float2));

	//malloc for host
	pos_host = (float2*)malloc(numBoids * sizeof(float2));
	vel_host = (float2*)malloc(numBoids * sizeof(float2));

	//set random velocity
	for (int i = 0; i < numBoids; i++) {
		vel_host[i].x = ((float) rand() / (RAND_MAX));
		vel_host[i].y = ((float) rand() / (RAND_MAX));
	}
	
	// Setup Kernels
	//printf("\nGenerating initial position\n");
	generateInitialPosition<<<fullBlocksPerGrid, BlockSize>>>(numBoids, pos_dev, vel_dev, acc_dev, sep_dev, align_dev, cohesion_dev);

	cudaMemcpy(vel_dev, vel_host, numBoids * sizeof(float2), cudaMemcpyHostToDevice);
	cudaMemcpy(pos_host, pos_dev, numBoids * sizeof(float2), cudaMemcpyDeviceToHost);
	cudaMemcpy(vel_host, vel_dev, numBoids * sizeof(float2), cudaMemcpyDeviceToHost);


	//for debugging
	/*printf("after\n");
	for (int i = 0; i < numBoids; i++) {
		printf("x = %f, y = %f\n", vel_host[i].x, vel_host[i].y);
	}*/
}

__global__
void update(int numBoids, float2 averagePos, float2 averageForward, float2* pos_dev, float2* vel_dev, float2* acc_dev, float2* sep_dev, float2* align_dev, float2* cohesion_dev) {
	dim3 fullBlocksPerGrid((int)ceil(float(numBoids) / float(BlockSize)));
	int i = (blockIdx.x * blockDim.x) + threadIdx.x;

	if (i < numBoids) {
		//cohesion
		float2 cohesion = calc_cohesion_accel(numBoids, averagePos, pos_dev);
		//separation
		float2 separation = calc_separation_accel(numBoids, pos_dev, vel_dev);
		//alignment
		float2 alignment = calc_alignment_accel(numBoids, averageForward);
		
		//printf("cohesion: %f\nseparation: %f\nalignment: %f\n", cohesion, separation, alignment);

		vel_dev[i] = add2dVectors(vel_dev[i], cohesion);
		vel_dev[i] = add2dVectors(vel_dev[i], separation);
		vel_dev[i] = add2dVectors(vel_dev[i], alignment);

		if (calcLength(vel_dev[i]) > 50.0f) {
			vel_dev[i] = normalizeVector(vel_dev[i]);
			vel_dev[i] = mulVectorByScalar(50.0f, vel_dev[i]);
			//printf("%d ", calcLength(vel_dev[i]));	
		}
		if (calcLength(vel_dev[i]) < 0.0f) {
			vel_dev[i] = normalizeVector(vel_dev[i]);
			vel_dev[i] = mulVectorByScalar(50.0f, vel_dev[i]);
			//printf("%d ", calcLength(vel_dev[i]));	
		}
		//printf("%d ", calcLength(vel_dev[i]));	
	}
		
}

__host__
int main(int argc, char* argv[]) 
{
	using std::chrono::high_resolution_clock;
    using std::chrono::duration_cast;
    using std::chrono::duration;
    using std::chrono::milliseconds;

    auto t1 = high_resolution_clock::now();

	int numB = std::stoi(argv[1]);
	int iterations = std::stoi(argv[2]);

	

	dim3 fullBlocksPerGrid((int)ceil(float(numB) / float(BlockSize)));
	
	//int iterations = 1000;
	

  	startCuda(numB);

	//printf("\nRunning Simulation with %d boids and %d iterations\n", numB, iterations);
	for (int i = 0; i < iterations; i++) {
		
		cudaMemcpy(vel_host, vel_dev, numB * sizeof(float2), cudaMemcpyDeviceToHost);
		cudaMemcpy(pos_host, pos_dev, numB * sizeof(float2), cudaMemcpyDeviceToHost);
		calc_average_pos();
		calc_average_forward();
		
		
		update<<<fullBlocksPerGrid, BlockSize>>>(numB, averagePos, averageForward, pos_dev, vel_dev, acc_dev, sep_dev, align_dev, cohesion_dev);
		updatePos<<<fullBlocksPerGrid, BlockSize>>>(numB, vel_dev, pos_dev);
		//for debugging will remove
		//cudaMemcpy(vel_host, vel_dev, numB * sizeof(float2), cudaMemcpyDeviceToHost);
		//cudaMemcpy(pos_host, pos_dev, numB * sizeof(float2), cudaMemcpyDeviceToHost);
		//printf("guy1-x: %f, guy1-y: %f | ", pos_host[0].x, pos_host[0].y);
		//printf("guy2-x: %f, guy2-y: %f\n", pos_host[1].x, pos_host[1].y);
	}

    
   cudaFree(pos_dev);
   cudaFree(vel_dev);
   cudaFree(acc_dev);
   cudaFree(sep_dev);
   cudaFree(align_dev);
   cudaFree(cohesion_dev);
	
   free(pos_host);

   auto t2 = high_resolution_clock::now();
   duration<double, std::milli> ms_double = t2 - t1;
   printf("%f", ms_double);

   return 0;
}
