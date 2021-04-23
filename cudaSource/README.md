This is our cuda code for our flocking algorithm project. 

To run the shellscript tests see the shellscript heading.

To compile and run the code youreself see the compiling heading.

## compiling
Run
'nvcc -std=c++11 flock.cu -o flock'
for the naive cuda version
or run
'nvcc -std=c++11 flock_better.cu -o flock'
'./flock'
for the version using reduction summation

## shellscript
run
'./testNaiveCuda.sh'
for the naive version
or 
'./testSmartCuda.sh'
for the smart version
