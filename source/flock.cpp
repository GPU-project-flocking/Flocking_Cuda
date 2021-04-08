#include "flock.h"

Flock::Flock(int numBoids) {
	for (int i = 0; i < numBoids; i++) {
		this->Boids.push_back(new Boid(0, 0));
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
	vec2d sum(0, 0);
	for (Boid* boid : Boids) {
		sum.operator+=(boid->position);
		counter++;
	}
	this->averagePos = sum / counter;
}


void Flock::calc_average_forward() {
	int counter = 0;
	vec2d sum(0, 0);

	for (Boid* boid : Boids) {
		sum.operator+=(boid->velocity);
		counter++;
	}
	averageForward = sum / counter;
}


vec2d Flock::calc_alignment_accel(Boid* boid) {
	vec2d accel = this->averageForward / boid->maxSpeed;

	if (accel.length() > 1) {
		accel.normalize();
	}
	return accel.operator*(AlignmentStrength);
}

vec2d Flock::calc_cohesion_accel(Boid* boid) {
	vec2d accel = averagePos.operator-(boid->position);

	float dist = accel.length();

	accel.normalize();

	if (dist < flockRadius) {
		accel = accel * dist / flockRadius;
	}
	
	return accel * CohesionStrength;
}

vec2d Flock::calc_separation_accel(Boid* boid) {
	vec2d sum(0, 0);
	for (Boid* sibling : Boids) {
		if (sibling == boid) {
			continue;
		}

		vec2d accel = boid->position.operator-(sibling->position);
		float dist = accel.length();
		float safeDist = boid->safeRadius + sibling->safeRadius;
		
		if (dist < safeDist) {
			accel.normalize();
			accel = accel * (safeDist - dist) / safeDist;
			sum.operator+=(accel);
		}
	}
	
	if (sum.length() > 1) {
		sum.normalize();
	}

	return sum.operator*(this->SeparationStrength);
}

void Flock::update() {
	calc_average_forward();
	calc_average_pos();

	for (Boid* boid : Boids) {
		vec2d accel = calc_alignment_accel(boid);

		vec2d cohesionF = calc_cohesion_accel(boid);
		accel.operator+=(cohesionF);

		vec2d separationF = calc_separation_accel(boid);
		accel.operator+=(separationF);

		accel = accel * boid->maxSpeed;

		boid->velocity = boid->velocity + accel;

		if (boid->velocity.length() > boid->maxSpeed) {
			boid->velocity.normalize();
			boid->velocity = boid->velocity * boid->maxSpeed;
		}
	}
}