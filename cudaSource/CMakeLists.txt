

enable_language(CUDA)
add_library(flock_kernels
flock_better.cu
flock_better.cuh
#flock.cu
)
target_compile_features(flock_kernels PUBLIC cxx_std_11)
set_target_properties(flock_kernels
                       PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(flock_kernels)