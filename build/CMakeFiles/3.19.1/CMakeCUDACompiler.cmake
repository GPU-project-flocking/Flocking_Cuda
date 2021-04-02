set(CMAKE_CUDA_COMPILER "/apps/compilers/cuda/10.0.130/bin/nvcc")
set(CMAKE_CUDA_HOST_COMPILER "")
set(CMAKE_CUDA_HOST_LINK_LAUNCHER "/apps/compilers/gcc/5.2.0/bin/g++")
set(CMAKE_CUDA_COMPILER_ID "NVIDIA")
set(CMAKE_CUDA_COMPILER_VERSION "10.0.130")
set(CMAKE_CUDA_DEVICE_LINKER "/apps/compilers/cuda/10.0.130/bin/nvlink")
set(CMAKE_CUDA_FATBINARY "/apps/compilers/cuda/10.0.130/bin/fatbinary")
set(CMAKE_CUDA_STANDARD_COMPUTED_DEFAULT "03")
set(CMAKE_CUDA_COMPILE_FEATURES "cuda_std_03;cuda_std_11;cuda_std_14")
set(CMAKE_CUDA03_COMPILE_FEATURES "cuda_std_03")
set(CMAKE_CUDA11_COMPILE_FEATURES "cuda_std_11")
set(CMAKE_CUDA14_COMPILE_FEATURES "cuda_std_14")
set(CMAKE_CUDA17_COMPILE_FEATURES "")
set(CMAKE_CUDA20_COMPILE_FEATURES "")

set(CMAKE_CUDA_PLATFORM_ID "Linux")
set(CMAKE_CUDA_SIMULATE_ID "GNU")
set(CMAKE_CUDA_COMPILER_FRONTEND_VARIANT "")
set(CMAKE_CUDA_SIMULATE_VERSION "5.2")



set(CMAKE_CUDA_COMPILER_ENV_VAR "CUDACXX")
set(CMAKE_CUDA_HOST_COMPILER_ENV_VAR "CUDAHOSTCXX")

set(CMAKE_CUDA_COMPILER_LOADED 1)
set(CMAKE_CUDA_COMPILER_ID_RUN 1)
set(CMAKE_CUDA_SOURCE_FILE_EXTENSIONS cu)
set(CMAKE_CUDA_LINKER_PREFERENCE 15)
set(CMAKE_CUDA_LINKER_PREFERENCE_PROPAGATES 1)

set(CMAKE_CUDA_SIZEOF_DATA_PTR "8")
set(CMAKE_CUDA_COMPILER_ABI "ELF")
set(CMAKE_CUDA_LIBRARY_ARCHITECTURE "")

if(CMAKE_CUDA_SIZEOF_DATA_PTR)
  set(CMAKE_SIZEOF_VOID_P "${CMAKE_CUDA_SIZEOF_DATA_PTR}")
endif()

if(CMAKE_CUDA_COMPILER_ABI)
  set(CMAKE_INTERNAL_PLATFORM_ABI "${CMAKE_CUDA_COMPILER_ABI}")
endif()

if(CMAKE_CUDA_LIBRARY_ARCHITECTURE)
  set(CMAKE_LIBRARY_ARCHITECTURE "")
endif()

set(CMAKE_CUDA_COMPILER_TOOLKIT_ROOT "/apps/compilers/cuda/10.0.130")
set(CMAKE_CUDA_COMPILER_TOOLKIT_LIBRARY_ROOT "/apps/compilers/cuda/10.0.130")
set(CMAKE_CUDA_COMPILER_LIBRARY_ROOT "/apps/compilers/cuda/10.0.130")

set(CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES "/apps/compilers/cuda/10.0.130/targets/x86_64-linux/include")

set(CMAKE_CUDA_HOST_IMPLICIT_LINK_LIBRARIES "")
set(CMAKE_CUDA_HOST_IMPLICIT_LINK_DIRECTORIES "/apps/compilers/cuda/10.0.130/targets/x86_64-linux/lib/stubs;/apps/compilers/cuda/10.0.130/targets/x86_64-linux/lib")
set(CMAKE_CUDA_HOST_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

set(CMAKE_CUDA_IMPLICIT_INCLUDE_DIRECTORIES "/apps/compilers/intel/2018/1.163/mkl/include;/apps/compilers/intel/2018/1.163/tbb/include;/apps/compilers/gcc/5.2.0/include/c++/5.2.0;/apps/compilers/gcc/5.2.0/include/c++/5.2.0/x86_64-redhat-linux-gnu;/apps/compilers/gcc/5.2.0/include/c++/5.2.0/backward;/apps/compilers/gcc/5.2.0/lib/gcc/x86_64-redhat-linux-gnu/5.2.0/include;/usr/local/include;/apps/compilers/gcc/5.2.0/include;/apps/compilers/gcc/5.2.0/lib/gcc/x86_64-redhat-linux-gnu/5.2.0/include-fixed;/usr/include")
set(CMAKE_CUDA_IMPLICIT_LINK_LIBRARIES "stdc++;m;gcc_s;gcc;c;gcc_s;gcc")
set(CMAKE_CUDA_IMPLICIT_LINK_DIRECTORIES "/apps/compilers/cuda/10.0.130/targets/x86_64-linux/lib/stubs;/apps/compilers/cuda/10.0.130/targets/x86_64-linux/lib;/apps/compilers/gcc/5.2.0/lib/gcc/x86_64-redhat-linux-gnu/5.2.0;/apps/compilers/gcc/5.2.0/lib64;/lib64;/usr/lib64;/apps/compilers/intel/2018/1.163/compilers_and_libraries/linux/lib/intel64;/apps/compilers/intel/2018/1.163/mkl/lib/intel64;/apps/compilers/intel/2018/1.163/ipp/lib/intel64;/apps/compilers/intel/2018/1.163/tbb/lib/intel64/gcc4.4;/apps/compilers/gcc/5.2.0/lib")
set(CMAKE_CUDA_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

set(CMAKE_CUDA_RUNTIME_LIBRARY_DEFAULT "STATIC")

set(CMAKE_LINKER "/usr/bin/ld")
set(CMAKE_AR "/usr/bin/ar")
set(CMAKE_MT "")
