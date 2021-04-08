#pragma once
#include <vector>
#include "boid.h"
class Flock
{
public:
    Flock(int numBoids);
    ~Flock();

    glm::float32 AlignmentStrength;
    glm::float32 CohesionStrength;
    glm::float32 SeparationStrength;
    std::vector<Boid*> Boids;
    glm::vec2 averagePos;
    glm::vec2 averageForward;
    glm::float32 flockRadius;

    void calc_average_pos();
    void calc_average_forward();
    glm::vec2 calc_alignment_accel(Boid* boid);
    glm::vec2 calc_cohesion_accel(Boid* boid);
    glm::vec2 calc_separation_accel(Boid* boid);

    void update();
};

