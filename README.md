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
First in the root directory for the project insert these commands on your terminal:
'git submodule init'
'git submodule update'

Then in ./build insert this command:
'cmake ..'

^^^^^^^
ignore that
^^^^^^

do this instead ->>>
vcpkg install glm:x64-windows
vcpkg install osg:x64-windows

then just compile with visual studio because fuck vs code and especially fuck cmake 


## Sources

*tutorials*

1. https://github.com/aaronmjacobs/InitGL
2. https://stackoverflow.com/questions/60604249/how-to-make-a-header-only-library-with-cmake

*libraries*

1. https://github.com/go-gl/glfw
2. https://github.com/Dav1dde/glad
3. https://github.com/Bly7/OBJ-Loader
