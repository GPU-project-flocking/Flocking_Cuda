
#include "flock_win.h"

#include <math.h> 
#include<windows.h>


flock_win::flock_win(Flock* flock)
{
    root = new osg::Group;

   

    osg::ref_ptr<osg::Geometry> myTriangleGeometry = new osg::Geometry;

    // Define the triangle's 3 vertices
    osg::ref_ptr<osg::Vec3Array> vertices = new osg::Vec3Array;

    vertices->push_back(osg::Vec3(0, 0, 0));
    vertices->push_back(osg::Vec3(60, 0, 0));
    vertices->push_back(osg::Vec3(30, 30, 100));
    myTriangleGeometry->setVertexArray(vertices);

    vertices->push_back(osg::Vec3(0, 0, 0));
    vertices->push_back(osg::Vec3(0, 60, 0));
    vertices->push_back(osg::Vec3(30, 30, 100));
    myTriangleGeometry->setVertexArray(vertices);

    vertices->push_back(osg::Vec3(60, 60, 0));
    vertices->push_back(osg::Vec3(60, 0, 0));
    vertices->push_back(osg::Vec3(30, 30, 100));
    myTriangleGeometry->setVertexArray(vertices);

    vertices->push_back(osg::Vec3(60, 60, 0));
    vertices->push_back(osg::Vec3(60, 0, 0));
    vertices->push_back(osg::Vec3(30, 30, 100));
    myTriangleGeometry->setVertexArray(vertices);

    vertices->push_back(osg::Vec3(60, 0, 0));
    vertices->push_back(osg::Vec3(0, 60, 0));
    vertices->push_back(osg::Vec3(0, 0, 0));
    myTriangleGeometry->setVertexArray(vertices);

    vertices->push_back(osg::Vec3(60, 60, 0));
    vertices->push_back(osg::Vec3(60, 0, 0));
    vertices->push_back(osg::Vec3(0, 60, 0));
    myTriangleGeometry->setVertexArray(vertices);

    // You can give each vertex its own color, but let's just make it green for now
    osg::ref_ptr<osg::Vec4Array> colors = new osg::Vec4Array;
    colors->push_back(osg::Vec4(0, 1.0, 0, 1.0)); // RGBA for green
    myTriangleGeometry->setColorArray(colors);
    myTriangleGeometry->setColorBinding(osg::Geometry::BIND_OVERALL);

    // Turn off lighting
    myTriangleGeometry->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);

    // Turn on blending
    myTriangleGeometry->getOrCreateStateSet()->setMode(GL_BLEND, osg::StateAttribute::ON);

    // Define the geometry type as 'triangles'
    myTriangleGeometry->addPrimitiveSet(new osg::DrawArrays(osg::PrimitiveSet::TRIANGLES, 0, vertices->size()));

    // Finally, let's add our triangle to a geode
    osg::ref_ptr<osg::Geode> geode = new osg::Geode;
    geode->addDrawable(myTriangleGeometry);

    osg::ref_ptr<osg::MatrixTransform> positioned = new osg::MatrixTransform;
    positioned.get()->addChild(geode);
    

    for (int i = 0; i < 10; i++)
    {
        osg::ref_ptr<osg::MatrixTransform> positioned = new osg::MatrixTransform;
        positions.push_back(positioned);

        osg::ref_ptr<osg::Geode> geode = new osg::Geode;
        geode->addDrawable(myTriangleGeometry);

        positioned.get()->addChild(geode);

        root.get()->addChild(positioned);

        osg::Matrix mTrans = osg::Matrix::scale(osg::Vec3(10, 10, 10));
        positioned.get()->setMatrix(mTrans);


    }
    
    
    //root.get()->addChild(positioned);


    //root.get()->addChild(positioned);


    win = new osgViewer::Viewer;
    win->setSceneData(root);
    win->setUpViewInWindow(10,35,1000,800,0);
        
    win->realize();
    osg::ref_ptr<osgGA::TrackballManipulator> tm = new osgGA::TrackballManipulator;
    
    win->setCameraManipulator(tm);
    int counter = 0;
    while(!win->done())
    {
        counter++;
        osg::Matrix mRot  = osg::Matrix::rotate(osg::DegreesToRadians(double(counter)), osg::Z_AXIS);
        int temp = counter%2 == 1 ? 0 : 30;
        osg::Matrix mTrans = osg::Matrix::translate(0, temp, temp);
        positioned.get()->setMatrix(mTrans);
        

        flock->update();

        for (Boid* boid : flock->Boids) {
            boid->move();
        }

        update(flock->Boids);
        
        win->frame();

        Sleep(1000);
        std::cout << "next cylce" << counter << std::endl;
    }
}

void flock_win::update(std::vector<Boid*> boids)
{
    for (int i = 0; i < boids.size(); i++)
    {
        Boid* temp = boids[i];

        

        osg::Matrix mTrans = osg::Matrix::translate(temp->position.x, 100 , temp->position.y);

        osg::Vec2 tempy(temp->velocity.x, temp->velocity.y);
        tempy.normalize();
        
        double angle = std::acos(tempy * osg::Vec2(0, 1))  * 180 / 3.14159265359;

        osg::Matrix mRot = osg::Matrix::rotate(osg::DegreesToRadians(double(angle)), osg::Y_AXIS);

        osg::Matrix m = mRot * mTrans;
        std::cout << "position.x"<<temp->position.x << " and the rotation is " << angle << std::endl;
        positions[i].get()->setMatrix(m);
        

        


    }
    
}

