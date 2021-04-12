#pragma once
#ifndef BOID_H_
#define BOID_H_
#include <vector>
//#include "../libraries/glm/glm.hpp"
//#include <glad/glad.h>

#include <glm/glm.hpp>


//#include "../libraries/glm/vec2.hpp"

class Boid {
public:
    Boid(double x, double y);
    ~Boid();

    glm::vec2 position;
    glm::vec2 velocity;
    double speed;
    double maxSpeed;
    double safeRadius;

    void move();
};
#endif