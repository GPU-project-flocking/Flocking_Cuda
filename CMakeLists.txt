cmake_minimum_required (VERSION 3.18)
project (Flocking_Cuda CXX)


# Source files
set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/source")
set(LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libraries")
set(SOURCES "${SRC_DIR}/main.cpp"
                ${SRC_DIR}/Visualization.h
                ${SRC_DIR}/Visualization.cpp)






add_executable (${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE "${SRC_DIR}")
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)


#GLM
set(GLM_DIR libraries/glm)
add_subdirectory(${GLM_DIR})
target_link_libraries(${PROJECT_NAME} glm )
target_include_directories(${PROJECT_NAME} PRIVATE "${GLM_DIR}/glm")

#assimp
set(assimp_DIR libraries/assimp)
add_subdirectory(${assimp_DIR})
target_link_libraries(${PROJECT_NAME} assimp )
target_include_directories(${PROJECT_NAME} PRIVATE "${assimp_DIR}/include")

# GLFW
set(GLFW_DIR "${LIB_DIR}/glfw")
set(GLFW_BUILD_EXAMPLES OFF CACHE INTERNAL "Build the GLFW example programs")
set(GLFW_BUILD_TESTS OFF CACHE INTERNAL "Build the GLFW test programs")
set(GLFW_BUILD_DOCS OFF CACHE INTERNAL "Build the GLFW documentation")
set(GLFW_INSTALL OFF CACHE INTERNAL "Generate installation target")
add_subdirectory("${GLFW_DIR}")
target_link_libraries(${PROJECT_NAME} "glfw" "${GLFW_LIBRARIES}")
target_include_directories(${PROJECT_NAME} PRIVATE "${GLFW_DIR}/include")
target_compile_definitions(${PROJECT_NAME} PRIVATE "GLFW_INCLUDE_NONE")

# glad
set(GLAD_DIR "${LIB_DIR}/glad")
add_library("glad" "${GLAD_DIR}/src/glad.c")
target_include_directories("glad" PRIVATE "${GLAD_DIR}/include")
target_include_directories(${PROJECT_NAME} PRIVATE "${GLAD_DIR}/include")
target_link_libraries(${PROJECT_NAME} "glad" "${CMAKE_DL_LIBS}")


