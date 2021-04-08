#include "boid.h"

Boid::Boid(double x, double y) {
    this->velocity = vec2d(rand(), rand());
    this->position = vec2d(x, y);
    this->speed = 1;
    this->maxSpeed = 5;
    this->safeRadius = 20;
}

Boid::~Boid() {
    
}

void Boid::move() {
    this->position.operator+=(this->velocity);
}