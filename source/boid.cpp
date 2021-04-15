#include "boid.h"

Boid::Boid() {
   
   set_start_pos();
   
   this->speed = 10000000*1.5;
   this->maxSpeed = 10000000*1.8;
   this->safeRadius = 20;
}

Boid::~Boid() {
   
}

void Boid::set_start_pos()
{
	
	this->position = glm::vec2(min + ((double)rand() / (RAND_MAX)) -1200, rand() % (max - min + 1) + min + 700);
	this->velocity = glm::vec2(500, -this->position.x);
}

void Boid::move(double delta_time) {

	auto temp = this->velocity;
	temp *= delta_time;
	
   this->position.operator+=(temp);
}
