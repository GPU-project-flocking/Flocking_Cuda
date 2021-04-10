#pragma once
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <assimp/BaseImporter.h>
#include <string>
#include <glm.hpp>
#include "shader.h"

class Visualization
{
	private:

    int screen_width = 600;
    int screen_height = 600;


    GLFWwindow* window;
    Shader* main_shader;
    public:

    Visualization();
    void create_win();
    void bind_shaders();
    bool update();
    void inline framebuffer_size_callback(GLFWwindow* window, int width, int height)
    {
        glViewport(0, 0, width, height);
    } 
    void add_triangle_test();



};

