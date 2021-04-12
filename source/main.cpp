
#include <stdio.h>
#include <iostream>
#include "flock.h"

#include "flock_win.h"
//#include "Visualization.h"

using namespace std;

int main(int argc, char* argv[]) 
{
   int num_flock = 10;
   Flock* flock = new Flock(num_flock);

   flock_win* win = new flock_win(flock);
   
   cout << "fuuuuuck" << endl;
   

   //Aiden -- 2d flocking main function. feel free to delete
   

   int iterations = 100;
       
   for (int i = 0; i < iterations; i++) {

      flock->update();

        for (Boid* boid : flock->Boids) {
            boid->move();
        }

   }

   delete flock;
    
   return 0;
}