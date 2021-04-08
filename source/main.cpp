
#include <stdio.h>
#include <iostream>
#include "flock.h"

//#include "Visualization.h"

using namespace std;

int main(int argc, char* argv[]) 
{
   
   Visualization * win = new Visualization;
   win->test();
   delete win;
   cout << "fuuuuuck" << endl;
   

   //Aiden -- 2d flocking main function. feel free to delete
   /*
   Flock* flock = new Flock(10);

   int iterations = 10;
       
   for (int i = 0; i < iterations; i++) {

      flock->update();

        for (Boid* boid : flock->Boids) {
            boid->move();
        }

   }

   delete flock;
    */
   return 0;
}