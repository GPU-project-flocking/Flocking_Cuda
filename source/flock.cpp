#include "flock.h"

Flock::Flock(int numBoids) {
	for (int i = 0; i < numBoids; i++) {
		this->Boids.push_back(new Boid(i, i));
	}

	this->AlignmentStrength = 1;
	this->CohesionStrength = 1;
	this->SeparationStrength = 1;
	this->flockRadius = 1;
}

Flock::~Flock() {
	for(int i = 0; i < Boids.size(); i++) {
		delete Boids[i];
	}
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
	glm::vec2 accel = avgForwardTmp /= boid->maxSpeed;
   
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
		accel = accel * dist / flockRadius;
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

void Flock::update() {
	calc_average_forward();
	calc_average_pos();

	for (Boid* boid : Boids) {
		glm::vec2 accel = calc_alignment_accel(boid);

		glm::vec2 cohesionF = calc_cohesion_accel(boid);
		accel += cohesionF;

		glm::vec2 separationF = calc_separation_accel(boid);
		accel += separationF;

		accel *= boid->maxSpeed;

		boid->velocity = boid->velocity + accel;

		if (boid->velocity.length() > boid->maxSpeed) {
			boid->velocity = glm::normalize(boid->velocity);
			boid->velocity *= boid->maxSpeed;
		}
	}

}