
#include <osg/Referenced>
#include <osg/Geometry>
#include <osg/Geode>
#include <osg/Array>
#include <osgViewer/Viewer>
#include "boid.h"
#include <vector>

class flock_win
{
private:
osgViewer::Viewer* win;
osg::ref_ptr<osg::Node> main_boid;
osg::ref_ptr<osg::Group> root;
public:
    flock_win();
    void update(std::vector<Boid*> boids);
    
};