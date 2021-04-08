#include "boid.h"

Boid::Boid(double x, double y) {
    this->velocity = glm::vec2(rand(), rand());
    this->position = glm::vec2(x, y);
    this->speed = 1;
    this->maxSpeed = 5;
    this->safeRadius = 20;
}

Boid::~Boid() {
    
}

void Boid::move() {
    this->position.operator+=(this->velocity);
}