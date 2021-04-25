# Flocking_Cuda

 flocking project using cuda


This is our cuda code for our flocking algorithm project. 

To run the shellscript tests see the shellscript heading.

To compile and run the code youreself see the compiling heading.

## compiling cuda code by itself
Run
'cd cudaSource'
'nvcc -std=c++11 flock.cu -o flock'
for the naive cuda version
or run
'cd cudaSource'
'nvcc -std=c++11 flock_better.cu -o flock'
'./flock'
for the version using reduction summation

## shellscript
run
'cd cudaSource'
'./testNaiveCuda.sh'
for the naive version
or 
'cd cudaSource'
'./testSmartCuda.sh'
for the smart version

## compiling visual c++/cuda flocking
This requires vcpkg and visual studio

vcpkg install glm:x64-windows
vcpkg install osg:x64-windows

Then from Flocking_Cuda/build enter,
cmake ..
into the terminal to build the project.
Then from inside the build folder click on the .sln.

then just compile with visual studio.


