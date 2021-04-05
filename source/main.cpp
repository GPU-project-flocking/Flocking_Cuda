
#include <stdio.h>
#include <iostream>

#include "Visualization.h"

using namespace std;

int main(int argc, char* argv[]) 
{
   Visualization * win = new Visualization;
   win->test();
   delete win;
   cout << "fuuuuuck" << endl;

   return 0;
}