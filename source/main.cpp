
#include <stdio.h>
#include <iostream>
#include "flock.h"
#include "flock_win.h"
#include "../cudaSource/flock_better.cuh"

using namespace std;

int main(int argc, char* argv[]) 
{
    //testing_cuda();
   int num_flock = 40;
   Flock* flock = new Flock(num_flock);

   flock_win* win = new flock_win(flock);
   
   cout << "fuuuuuck" << endl;
    delete flock;


   //Aiden -- 2d flocking main function. feel free to delete
   
   //
   // int iterations = 100;
   //     
   // for (int i = 0; i < iterations; i++) {
   //
   //    flock->update();
   //
   //      for (Boid* boid : flock->Boids) {
   //          boid->move();
   //      }
   //
   // }

   
    
   return 0;
}