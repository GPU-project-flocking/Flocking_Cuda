#include <iostream>
#include <cstdlib>

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
#define NBOIDS 10
#define FLOCKING_RAD 50.0f;
#define COHESION_STRENGTH 5.0f;

/*****************************************************************
*
*	Vector Functions -- will update
*
****************************************************************/

__device__
float distanceFormula(float2 myPos, float2 theirPos) {
	float dx = myPos.x - theirPos.x;
	float dy = myPos.y - theirPos.y;

	float dist = sqrt(dx*dx + dy*dy);
	return dist;
}


__device__
float2 add2Vectors(float2 v1, float2 v2) {
	float2 temp = make_float2(v1.x, v1.y);
	temp.x += v2.x;
	temp.y += v2.y;
	return temp;
}

__device__
float2 sub2Vectors(float2 v1, float2 v2) {
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
float magnitudeOfVector(float2 vector) {
	return sqrt(
		vector.x * vector.x +
		vector.y * vector.y
	);
}

__device__
float2 normalizeVector(float2 vector) {
	float2 temp = make_float2(vector.x, vector.y);
	float magnitude = magnitudeOfVector(temp);
	if (magnitude > 0) {
		temp.x /= magnitude;
		temp.y /= magnitude;
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

__device__ void updatePos(int numBoids, float2* vel_dev, float2* pos_dev) {
	int i = (blockIdx.x * blockDim.x) + threadIdx.x;

	if (i < numBoids) {
		float2 newPos = add2Vectors(pos_dev[i], vel_dev[i]);
		pos_dev[i] = newPos;
	}
}

__device__ float2 calc_cohesion_accel(int numBoids, float2 averagePos, float2* pos_dev) {
	float flockRad = FLOCKING_RAD;
	float cohesionStr = COHESION_STRENGTH;

	int i = (blockIdx.x * blockDim.x) + threadIdx.x;
	if (i < numBoids) {
		float2 accel = sub2Vectors(averagePos, pos_dev[i]);
		float dist = magnitudeOfVector(pos_dev[i]);

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
	printf("\nDefining cuda variables\n");
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
	printf("\nGenerating initial position\n");
	generateInitialPosition<<<fullBlocksPerGrid, BlockSize>>>(numBoids, pos_dev, vel_dev, acc_dev, sep_dev, align_dev, cohesion_dev);

	cudaMemcpy(vel_dev, vel_host, numBoids * sizeof(float2), cudaMemcpyHostToDevice);

	cudaMemcpy(pos_host, pos_dev, numBoids * sizeof(float2), cudaMemcpyDeviceToHost);
	cudaMemcpy(vel_host, vel_dev, numBoids * sizeof(float2), cudaMemcpyDeviceToHost);

	printf("after\n");
	for (int i = 0; i < numBoids; i++) {
		printf("x = %f, y = %f\n", vel_host[i].x, vel_host[i].y);
	}
}

__global__
void update(int numBoids, float2 averagePos, float2 averageForward, float2* pos_dev, float2* vel_dev, float2* acc_dev, float2* sep_dev, float2* align_dev, float2* cohesion_dev) {
	dim3 fullBlocksPerGrid((int)ceil(float(numBoids) / float(BlockSize)));
	int i = (blockIdx.x * blockDim.x) + threadIdx.x;

	if (i < numBoids) {
		//cohesion
		float2 cohesion = calc_cohesion_accel(numBoids, averagePos, pos_dev);
		//separation
		//alignment
		
		vel_dev[i] = add2Vectors(vel_dev[i], cohesion);
		updatePos(numBoids, vel_dev, pos_dev);
	}
		
}

__host__
int main(int argc, char* argv[]) 
{
	dim3 fullBlocksPerGrid((int)ceil(float(NBOIDS) / float(BlockSize)));
	
	int iterations = 10;

  	startCuda(NBOIDS);
	for (int i = 0; i < iterations; i++) {
		calc_average_pos();
		calc_average_forward();
		update<<<fullBlocksPerGrid, BlockSize>>>(NBOIDS, averagePos, averageForward, pos_dev, vel_dev, acc_dev, sep_dev, align_dev, cohesion_dev);

		//for debugging will remove
		cudaMemcpy(vel_host, vel_dev, NBOIDS * sizeof(float2), cudaMemcpyDeviceToHost);
		printf("\n---\nx: %f, y: %f", vel_host[0].x, vel_host[0].y);
	}

    
   cudaFree(pos_dev);
   cudaFree(vel_dev);
   cudaFree(acc_dev);
   cudaFree(sep_dev);
   cudaFree(align_dev);
   cudaFree(cohesion_dev);
	
   free(pos_host);
   return 0;
}
