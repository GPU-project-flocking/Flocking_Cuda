# Flocking_Cuda

 flocking project using cuda

## compiling
First in the root directory for the project insert these commands on your terminal:
'git submodule init'
'git submodule update'

Then in ./build insert this command:
'cmake ..'

^^^^^^^
ignore that
^^^^^^

do this instead ->>>
vcpkg install glm:x64-windows
vcpkg install osg:x64-windows

then just compile with visual studio because fuck vs code and especially fuck cmake 


## Sources

*tutorials*

1. https://github.com/aaronmjacobs/InitGL
2. https://stackoverflow.com/questions/60604249/how-to-make-a-header-only-library-with-cmake

*libraries*

1. https://github.com/go-gl/glfw
2. https://github.com/Dav1dde/glad
3. https://github.com/Bly7/OBJ-Loader
