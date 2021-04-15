#include "flock.h"

#include <iostream>
#include <random>


Flock::Flock(int numBoids) {
	for (int i = 0; i < numBoids; i++) {
		spawn_boid();
	}

	this->AlignmentStrength = 2;
	this->CohesionStrength = 20;
	this->SeparationStrength = 6;
	this->flockRadius = .5;

	
	

}

Flock::~Flock() {
	for(int i = 0; i < Boids.size(); i++) {
		delete Boids[i];
	}
}

void Flock::spawn_boid()
{
	this->Boids.push_back(new Boid());
}

void Flock::calc_average_pos() {
	int counter = 0;
	glm::vec2 sum(0, 0);
	for (Boid* boid : Boids) {
		sum.operator+=(boid->position);
		counter++;
	}
	
	this->averagePos = sum /= counter;
}


void Flock::calc_average_forward() {
	int counter = 0;
	glm::vec2 sum(0, 0);

	for (Boid* boid : Boids) {
		sum.operator+=(boid->velocity);
		counter++;
	}
	averageForward = sum /= counter;
}


glm::vec2 Flock::calc_alignment_accel(Boid* boid) {
	glm::vec2 avgForwardTmp = this->averageForward;
	avgForwardTmp /= boid->maxSpeed;
	glm::vec2 accel = avgForwardTmp;
   
	if (accel.length() > 1) {
		accel = glm::normalize(accel);
	}
	return accel *  AlignmentStrength;
}

glm::vec2 Flock::calc_cohesion_accel(Boid* boid) {
	glm::vec2 avgPosTmp = this->averagePos;
	glm::vec2 accel = avgPosTmp -= boid->position;

	float dist = accel.length();

	accel = glm::normalize(accel);

	if (dist < flockRadius) {
		accel = (accel * dist) / flockRadius;
	}
	
	return accel * CohesionStrength;
}

glm::vec2 Flock::calc_separation_accel(Boid* boid) {
	glm::vec2 sum(0, 0);
	for (Boid* sibling : Boids) {
		if (sibling == boid) {
			continue;
		}

		
		glm::vec2 accel = boid->position - sibling->position;
		float dist = accel.length();
	
		
		float safeDist = boid->safeRadius + sibling->safeRadius;
		
		if (dist < safeDist) {
			accel = glm::normalize(accel);
			accel = accel * (safeDist - dist) / safeDist;
			sum.operator+=(accel);
		}
	}
	
	if (sum.length() > 1) {
		sum = glm::normalize(sum);
	}

	return sum * this->SeparationStrength;
}

void Flock::update(double delta_time) {
	calc_average_forward();
	calc_average_pos();

	for (Boid* boid : Boids) {

		if(boid->position.x > 6000 *1.3 || boid->position.x < -2400 || boid->position.y > 7000 || boid->position.y < -1700)
		{
			boid->set_start_pos();
		}
		
		glm::vec2 accel = calc_alignment_accel(boid);

		glm::vec2 cohesionF = calc_cohesion_accel(boid);
		accel += cohesionF;

		glm::vec2 separationF = calc_separation_accel(boid);
		accel += separationF;

		accel *= boid->maxSpeed * delta_time;

		boid->velocity = boid->velocity + accel;

		if (boid->velocity.length() > boid->maxSpeed) {
			boid->velocity = glm::normalize(boid->velocity);
			boid->velocity *= boid->maxSpeed;
		}
		//boid->velocity = glm::vec2(0, 0);

		

	}

}