# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /apps/cmake/3.19.1/bin/cmake

# The command to remove a file.
RM = /apps/cmake/3.19.1/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /blue/cis4936/jacobroberge/share/Flocking_Cuda

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /blue/cis4936/jacobroberge/share/Flocking_Cuda/build

# Include any dependencies generated for this target.
include CMakeFiles/kernel.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/kernel.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/kernel.dir/flags.make

CMakeFiles/kernel.dir/kernel.cu.o: CMakeFiles/kernel.dir/flags.make
CMakeFiles/kernel.dir/kernel.cu.o: ../kernel.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/blue/cis4936/jacobroberge/share/Flocking_Cuda/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object CMakeFiles/kernel.dir/kernel.cu.o"
	/apps/compilers/cuda/10.0.130/bin/nvcc  $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -c /blue/cis4936/jacobroberge/share/Flocking_Cuda/kernel.cu -o CMakeFiles/kernel.dir/kernel.cu.o

CMakeFiles/kernel.dir/kernel.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/kernel.dir/kernel.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/kernel.dir/kernel.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/kernel.dir/kernel.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

# Object files for target kernel
kernel_OBJECTS = \
"CMakeFiles/kernel.dir/kernel.cu.o"

# External object files for target kernel
kernel_EXTERNAL_OBJECTS =

kernel: CMakeFiles/kernel.dir/kernel.cu.o
kernel: CMakeFiles/kernel.dir/build.make
kernel: CMakeFiles/kernel.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/blue/cis4936/jacobroberge/share/Flocking_Cuda/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CUDA executable kernel"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/kernel.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/kernel.dir/build: kernel

.PHONY : CMakeFiles/kernel.dir/build

CMakeFiles/kernel.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/kernel.dir/cmake_clean.cmake
.PHONY : CMakeFiles/kernel.dir/clean

CMakeFiles/kernel.dir/depend:
	cd /blue/cis4936/jacobroberge/share/Flocking_Cuda/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /blue/cis4936/jacobroberge/share/Flocking_Cuda /blue/cis4936/jacobroberge/share/Flocking_Cuda /blue/cis4936/jacobroberge/share/Flocking_Cuda/build /blue/cis4936/jacobroberge/share/Flocking_Cuda/build /blue/cis4936/jacobroberge/share/Flocking_Cuda/build/CMakeFiles/kernel.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/kernel.dir/depend
