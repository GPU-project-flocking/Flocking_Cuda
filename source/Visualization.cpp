#include "Visualization.h"
#include <iostream>
#include <string>

using namespace std;

Visualization::Visualization()
{
    std::cout<<"fuck" << std::endl;
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    this->window = glfwCreateWindow(800, 600, "Flocking_win", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
    }
    glfwMakeContextCurrent(window);
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        
    }

    glViewport(0, 0, 800, 600);
    //glfwSetFramebufferSizeCallback(window, *framebuffer_size_callback); 
    while(!glfwWindowShouldClose(window))
    {
        glfwSwapBuffers(window);
        glfwPollEvents();    
    }
    
    glfwTerminate();




}

void Visualization::test()
{
    std::cout<<"testfuck" << std::endl;
    


}

