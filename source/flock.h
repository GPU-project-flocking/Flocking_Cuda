#pragma once
#include <vector>
#include "boid.h"
class Flock
{
public:
    Flock(int numBoids);
    ~Flock();

    float AlignmentStrength;
    float CohesionStrength;
    float SeparationStrength;
    std::vector<Boid*> Boids;
    vec2d averagePos;
    vec2d averageForward;
    float flockRadius;

    void calc_average_pos();
    void calc_average_forward();
    vec2d calc_alignment_accel(Boid* boid);
    vec2d calc_cohesion_accel(Boid* boid);
    vec2d calc_separation_accel(Boid* boid);

    void update();
};

