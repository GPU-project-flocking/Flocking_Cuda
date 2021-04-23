cmake_minimum_required (VERSION 3.18)

set(VCPKG_TARGET_TRIPLET x64-windows)
set(DCMAKE_TOOLCHAIN_FILE C:/programs/vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake)

project (Flocking_Cuda LANGUAGES CXX  CUDA)

set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_STANDARD 11)

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
                #${SRC_DIR}/Visualization.h
                #${SRC_DIR}/Visualization.cpp
                ${SRC_DIR}/flock_win.cpp
                ${SRC_DIR}/flock_win.h
                ${SRC_DIR}/flock.cpp
                ${SRC_DIR}/flock.h
                ${SRC_DIR}/boid.h
                ${SRC_DIR}/boid.cpp
                ${SRC_DIR}/shader.h
                )







add_executable(flocking_better cudaSource/flock_better.cu cudaSource/flock_better.cuh)
add_executable(flocking cudaSource/flock.cu)








add_executable (${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE "${SRC_DIR}")
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)

add_library(cuda_kernels STATIC cudaSource/flock_better.cu cudaSource/flock_better.cuh)
set_property(TARGET cuda_kernels 
             PROPERTY CUDA_SEPARABLE_COMPILATION ON)

set_target_properties(cuda_kernels PROPERTIES CUDA_RESOLVE_DEVICE_SYMBOLS ON)


target_link_libraries(${PROJECT_NAME} PRIVATE cuda_kernels)






# find_package(glm CONFIG REQUIRED)
# target_link_libraries(${PROJECT_NAME} glm)

# FIND_PACKAGE(OpenSceneGraph REQUIRED COMPONENTS osgViewer osgDB osgGA osgText)
# TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${OPENSCENEGRAPH_LIBRARIES})

# find_package(Magnum CONFIG REQUIRED)
# target_link_libraries(${PROJECT_NAME} private Magnum::Magnum Magnum::GLContext Magnum::Application Magnum::WindowlessApplication)

# find_package(SFML CONFIG REQUIRED)
#     # Note: 7 target(s) were omitted.
# target_link_libraries(main PRIVATE FLAC OpenAL OpenGL Vorbis)

# #GLM
# set(GLM_DIR libraries/glm)
# add_subdirectory(${GLM_DIR})
# target_link_libraries(${PROJECT_NAME} glm )
# target_include_directories(${PROJECT_NAME} PRIVATE "${GLM_DIR}/glm")

# #assimp
# set(assimp_DIR libraries/assimp)
# add_subdirectory(${assimp_DIR})
# target_link_libraries(${PROJECT_NAME} assimp )
# target_include_directories(${PROJECT_NAME} PRIVATE "${assimp_DIR}/include")

# # GLFW
# set(GLFW_DIR "${LIB_DIR}/glfw")
# set(GLFW_BUILD_EXAMPLES OFF CACHE INTERNAL "Build the GLFW example programs")
# set(GLFW_BUILD_TESTS OFF CACHE INTERNAL "Build the GLFW test programs")
# set(GLFW_BUILD_DOCS OFF CACHE INTERNAL "Build the GLFW documentation")
# set(GLFW_INSTALL OFF CACHE INTERNAL "Generate installation target")
# add_subdirectory("${GLFW_DIR}")
# target_link_libraries(${PROJECT_NAME} "glfw" "${GLFW_LIBRARIES}")
# target_include_directories(${PROJECT_NAME} PRIVATE "${GLFW_DIR}/include")
# target_compile_definitions(${PROJECT_NAME} PRIVATE "GLFW_INCLUDE_NONE")

# #glad
# set(GLAD_DIR "${LIB_DIR}/glad")
# add_library("glad" "${GLAD_DIR}/src/glad.c")
# target_include_directories("glad" PRIVATE "${GLAD_DIR}/include")
# target_include_directories(${PROJECT_NAME} PRIVATE "${GLAD_DIR}/include")
# target_link_libraries(${PROJECT_NAME} "glad" "${CMAKE_DL_LIBS}")

# #OpenSceneGraph
# set(OSG_DIR libraries/OpenSceneGraph-3.6.5)
# #add_subdirectory(${OSG_DIR})
# #target_link_libraries(${PROJECT_NAME} ${OPENSCENEGRAPH_LIBRARIES} )
# #target_include_directories(${PROJECT_NAME} PRIVATE "${OSG_DIR}/include")


# # list(APPEND CMAKE_PREFIX_PATH " ${OSG_DIR}/lib")
# # find_library(OSG_LIB {OSG_DIR}/lib)

# # target_include_directories(${PROJECT_NAME} PRIVATE ${OSG_DIR}/include)
# # target_link_libraries( ${PROJECT_NAME}  "${OSG_LIB}")
# set(OSG_DIR libraries/OpenSceneGraph-3.6.5)


# # add_library(osg SHARED IMPORTED)
# # set_target_properties(osg PROPERTIES
# #   IMPORTED_LOCATION "${OSG_DIR}/lib/osg"
# #   INTERFACE_INCLUDE_DIRECTORIES "${OSG_DIR}/include/osg"
# # )
# # target_link_libraries(${PROJECT_NAME} osg) 

# #LINK_DIRECTORIES(${OSG_DIR}/lib)

# #INCLUDE_DIRECTORIES( ${PROJECT_NAME}   ${OPENSCENEGRAPH_INCLUDE_DIRS})



# # add_subdirectory(${OSG_DIR}/lib)
# # target_link_libraries(${PROJECT_NAME} osg)
# # install(TARGETS ${PROJECT_NAME} DESTINATION ${OSG_DIR}/bin)

# #add_subdirectory(${OSG_DIR})
# # set(OSG_DIR libraries/OpenSceneGraph-3.6.5)


# # add_library(GL STATIC ${OSG_DIR}/lib/glut32.lib)
# # target_include_directories(${PROJECT_NAME} PRIVATE ${OSG_DIR}/include)
# # set_target_properties(GL PROPERTIES LINKER_LANGUAGE Cxx) 

# # add_library(osg STATIC ${OSG_DIR}/lib/osg.lib)
# # target_include_directories(${PROJECT_NAME} PRIVATE ${OSG_DIR}/include)
# # set_target_properties(osg PROPERTIES LINKER_LANGUAGE Cxx)
# # target_include_directories(osg PRIVATE ${OSG_DIR}/include)
# # target_link_libraries(osg GL)
# # target_link_libraries(${PROJECT_NAME} osg)

# # add_library(osgViewer STATIC ${OSG_DIR}/lib/osgViewer.lib)
# # target_include_directories(${PROJECT_NAME} PRIVATE ${OSG_DIR}/include)
# # set_target_properties(osgViewer PROPERTIES LINKER_LANGUAGE Cxx) 
# # target_link_libraries(${PROJECT_NAME} osgViewer)

# # add_library(osgDB STATIC ${OSG_DIR}/lib/osgDB.lib)
# # target_include_directories(${PROJECT_NAME} PRIVATE ${OSG_DIR}/include)
# # set_target_properties(osgDB PROPERTIES LINKER_LANGUAGE Cxx) 
# # target_link_libraries(${PROJECT_NAME} osgDB)

