cmake_minimum_required (VERSION 3.18)

set(VCPKG_TARGET_TRIPLET x64-windows)
set(DCMAKE_TOOLCHAIN_FILE C:/programs/vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake)

project (Flocking_Cuda LANGUAGES CXX  CUDA)

set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_STANDARD 17)

# default CUDA architecture
set(CMAKE_CUDA_ARCHITECTURES 75 CACHE STRING "CUDA architectures" FORCE)
set(CUDA_NVCC_FLAGS "-arch=sm_75" CACHE STRING "nvcc flags" FORCE)

# default build type is Debug
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING
      "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel."
      FORCE)
endif(NOT CMAKE_BUILD_TYPE)

# Source files
set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/source")
set(LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libraries")
set(SOURCES "${SRC_DIR}/main.cpp"
                ${SRC_DIR}/flock_win.cpp
                ${SRC_DIR}/flock_win.h
                ${SRC_DIR}/flock.cpp
                ${SRC_DIR}/flock.h
                ${SRC_DIR}/boid.h
                ${SRC_DIR}/boid.cpp
                ${SRC_DIR}/shader.h
                )






# add exe for better flocking cuda code
add_executable(flocking_better cudaSource/flock_better.cu cudaSource/flock_better.cuh)

# add exe for naive flocking cuda code
add_executable(flocking cudaSource/flock.cu)







# add exe for debugging/visual flocking cuda code
add_executable (${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE "${SRC_DIR}")
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)

add_library(cuda_kernels STATIC cudaSource/flock_better.cu cudaSource/flock_better.cuh)
set_property(TARGET cuda_kernels 
             PROPERTY CUDA_SEPARABLE_COMPILATION ON)

set_target_properties(cuda_kernels PROPERTIES CUDA_RESOLVE_DEVICE_SYMBOLS ON)


target_link_libraries(${PROJECT_NAME} PRIVATE cuda_kernels)


