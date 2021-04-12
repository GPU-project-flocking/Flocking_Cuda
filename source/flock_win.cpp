
#include "flock_win.h"
#include <osgDB/ReadFile>
flock_win::flock_win()
{
    root = new osg::Group;


    main_boid = osgDB::readNodeFile("./../models/round_boi.obj");
    if (!main_boid)
    {
        printf("Node not loaded, model not found\n");
    }

    root.get()->addChild(main_boid);


    win = new osgViewer::Viewer;
    win->setSceneData(root);
    win->setUpViewInWindow(10,35,1000,800,0);
    win->run();
}

