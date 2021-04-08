#pragma once
#ifndef BOID_H_
#define BOID_H_
#include <vector>
#include "vec2d.h"
class Boid {
public:
    Boid(double x, double y);
    ~Boid();

    vec2d position;
    vec2d velocity;
    double speed;
    double maxSpeed;
    double safeRadius;

    void move();
};
#endif