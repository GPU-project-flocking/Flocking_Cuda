#ifndef FLOCK_BETTER_CUH__
#define FLOCK_BETTER_CUH__

#include <cstdio>
#include <cassert>




int setup_flock_cuda(int numB);

void update_flock_cuda(int numB, float2* vel_host, float2* pos_host);

void free_flock_cuda();

void testing_cuda(int numB, float* arr, float* final_sum);


#endif