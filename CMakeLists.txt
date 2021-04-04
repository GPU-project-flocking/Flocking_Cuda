cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

project(Flocking_Cuda LANGUAGES CXX )

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# default CUDA architecture
#set(CMAKE_CUDA_ARCHITECTURES 75 CACHE STRING "CUDA architectures" FORCE)

# default build type is Debug
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING
      "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel."
      FORCE)
endif(NOT CMAKE_BUILD_TYPE)

set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/source")
set(LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libraries")
set(SOURCES "${SRC_DIR}/main.cpp")


add_executable(${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE "${SRC_DIR}")

# GLFW files

set(GLFW_DIR "${LIB_DIR}/glfw")
set(GLFW_BUILD_EXAMPLES OFF CACHE INTERNAL "Build the GLFW example programs")
set(GLFW_BUILD_TESTS OFF CACHE INTERNAL "Build the GLFW test programs")
set(GLFW_BUILD_DOCS OFF CACHE INTERNAL "Build the GLFW documentation")
set(GLFW_INSTALL OFF CACHE INTERNAL "Generate installation target")
add_subdirectory("${GLFW_DIR}")
target_link_libraries(${PROJECT_NAME} PRIVATE "glfw" "${GLFW_LIBRARIES}")
target_include_directories(${PROJECT_NAME} PRIVATE "${GLFW_DIR}/include")
target_compile_definitions(${PROJECT_NAME} PRIVATE "GLFW_INCLUDE_NONE")

#Glad stuff
set(GLAD_DIR "${LIB_DIR}/glad")
add_library("glad" "${GLAD_DIR}/src/glad.c")
target_include_directories("glad" PRIVATE "${GLAD_DIR}/include")
target_include_directories(${PROJECT_NAME} PRIVATE "${GLAD_DIR}/include")
target_link_libraries(${PROJECT_NAME} PRIVATE "glad" "${CMAKE_DL_LIBS}")

#OBJ-Loader
set(OBJ-Loader_DIR "${LIB_DIR}/OBJ-Loader")
#add_library(OBJ-Loader INTERFACE)
#target_include_directories(OBJ-Loader INTERFACE "${OBJ-Loader_DIR}/Source")
#target_link_libraries(${PROJECT_NAME} INTERFACE OBJ-Loader)

#ASSIMP
set(ASSIMP_DIR "${LIB_DIR}/assimp")
add_subdirectory("${ASSIMP_DIR}")
target_link_libraries(${PROJECT_NAME} PRIVATE "assimp" "${GLFW_LIBRARIES}")
target_include_directories(${PROJECT_NAME} PRIVATE "${ASSIMP_DIR}/include")

#GLM
set(GLM_DIR "${LIB_DIR}/glm")
#add_subdirectory("${GLM_DIR}")
#target_link_libraries(${PROJECT_NAME} PRIVATE glm::glm)
#target_include_directories(${PROJECT_NAME} PRIVATE "${GLM_DIR}/include")

set(glm_DIR ${LIB_DIR}/lib/cmake/glm) # if necessary
find_package(glm REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE glm::glm)

message(STATUS "build type:  ${CMAKE_BUILD_TYPE}")
