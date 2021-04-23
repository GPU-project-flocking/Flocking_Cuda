#pragma once
#ifndef FLOCK_WIN_H_
#define FLOCK_WIN_H_

#include <osg/Referenced>
#include <osg/Geometry>
#include <osg/Geode>
#include <osg/Array>
#include <osgViewer/Viewer>
#include <osgDB/ReadFile>
#include <osgDB/PluginQuery>
#include <osg/MatrixTransform>
#include <osgGA/TrackballManipulator>

#include "boid.h"
#include "flock.h"
#include <vector>

class flock_win
{

private:
osgViewer::Viewer* win;
osg::ref_ptr<osg::Node> main_boid;
osg::ref_ptr<osg::Group> root;

std::vector<osg::ref_ptr<osg::MatrixTransform>> positions;
public:
    flock_win(Flock* flock);
    void update_cuda(Flock* flock);
    void update(std::vector<Boid*> boids);
    
};

#endif