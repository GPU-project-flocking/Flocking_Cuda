#pragma once
#include <random>
#include <vector>
#include "boid.h"
#include <vector_types.h>
#include "../cudaSource/flock_better.cuh"



class Flock
{
private:
public:
    Flock(int numBoids);
    ~Flock();

    int num_boids;
    float2* position_cuda;
    float2* velocity_cuda;
    void update_cuda(double delta_time);
    void setup_cuda(int num_boids);
    void free_cuda();


    glm::float32 AlignmentStrength;
    glm::float32 CohesionStrength;
    glm::float32 SeparationStrength;
    std::vector<Boid*> Boids;
    glm::vec2 averagePos;
    glm::vec2 averageForward;
    glm::float32 flockRadius;

	
	
    void spawn_boid();
    void calc_average_pos();
    void calc_average_forward();
    glm::vec2 calc_alignment_accel(Boid* boid);
    glm::vec2 calc_cohesion_accel(Boid* boid);
    glm::vec2 calc_separation_accel(Boid* boid);

    void update(double delta_time);

    
};

