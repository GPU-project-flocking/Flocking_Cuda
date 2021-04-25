#pragma once
#ifndef BOID_H_
#define BOID_H_
#include <vector>

#include <glm/glm.hpp>







class Boid {
public:
    Boid();
    ~Boid();

    

    glm::vec2 position;
    glm::vec2 velocity;
    double speed;
    double maxSpeed;
    double safeRadius;

    int max = 6000;
    int min = -1000;
	
    void set_start_pos();
    void move(double delta_time);
};
#endif