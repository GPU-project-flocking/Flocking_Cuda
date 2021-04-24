
#include <stdio.h>
#include <iostream>
#include "flock.h"
#include "flock_win.h"


#include "../cudaSource/flock_better.cuh"
#include <vector_types.h>


//------------------------------
//This main file is for testing purposes
//--------------------------------

using namespace std;

int main(int argc, char* argv[]) 
{
    //testing_cuda();
   int num_flock = 40;

   //float* final_sum = new float();
   //*final_sum = 0;
   //float* summ_arr;
   //summ_arr = (float*)malloc(num_flock * sizeof(float));
   //for (int i = 0; i < num_flock; i++)
   //{
   //    summ_arr[i] = i + 1;
   //}

   //testing_cuda(num_flock,summ_arr,final_sum);

   //delete summ_arr;

   Flock* flock = new Flock(num_flock);

   flock_win* win = new flock_win(flock);
   delete flock;
   delete win;

   
   cout << "fuuuuuck" << endl;
   


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