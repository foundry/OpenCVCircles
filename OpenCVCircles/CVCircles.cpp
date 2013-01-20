//
//  CVSquares.cpp
//  OpenCVClient
//
//  Original code from sample distributed with openCV source.
//  Modifications (c) Washe / Foundry. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#include "CVCircles.h"

    //#include <iostream>

using namespace cv;
using namespace std;

cv::Mat CVCircles::detectedCirclesInImage
    (cv::Mat img, double dp, double minDist, double param1, double param2, int min_radius, int max_radius)

{
    if(img.empty())
        {
        cout << "can not open image " << endl;
        return img;
        }
    Mat cimg;
    medianBlur(img, img, 5);

    cvtColor(img, cimg, CV_GRAY2RGB);
    
    vector<Vec3f> circles;
    HoughCircles(  img      //InputArray 
                 , circles  //OutputArray
                 , CV_HOUGH_GRADIENT  //int method
                 , dp              //double       dp=1   1 ... 20
                 , minDist         //double minDist=10 log 1...1000
                 , param1          //double  param1=100
                 , param2          //double  param2=30  10 ... 50
                 , min_radius      //int  minRadius=1   1 ... 500
                 , max_radius      //int  maxRadius=30  1 ... 500
                 );
    
    /*
     http://docs.opencv.org/trunk/modules/imgproc/doc/feature_detection.html?highlight=houghcircles#void 
     
     C++: void HoughCircles(InputArray image, OutputArray circles, int method, double dp, double minDist, double param1=100, double param2=100, int minRadius=0, int maxRadius=0 )
     
     Parameters:
     image – 8-bit, single-channel, grayscale input image.
     circles – Output vector of found circles. Each vector is encoded as a 3-element floating-point vector   .
     circle_storage – In C function this is a memory storage that will contain the output sequence of found circles.
     method – Detection method to use. Currently, the only implemented method is CV_HOUGH_GRADIENT , which is basically 21HT , described in [Yuen90].
     dp – Inverse ratio of the accumulator resolution to the image resolution. For example, if dp=1 , the accumulator has the same resolution as the input image. If dp=2 , the accumulator has half as big width and height.
     minDist – Minimum distance between the centers of the detected circles. If the parameter is too small, multiple neighbor circles may be falsely detected in addition to a true one. If it is too large, some circles may be missed.
     param1 – First method-specific parameter. In case of CV_HOUGH_GRADIENT , it is the higher threshold of the two passed to the Canny() edge detector (the lower one is twice smaller).
     param2 – Second method-specific parameter. In case of CV_HOUGH_GRADIENT , it is the accumulator threshold for the circle centers at the detection stage. The smaller it is, the more false circles may be detected. Circles, corresponding to the larger accumulator values, will be returned first.
     minRadius – Minimum circle radius.
     maxRadius – Maximum circle radius.
     The function finds circles in a grayscale image using a modification of the Hough transform.
     */
    
    for( size_t i = 0; i < circles.size(); i++ )
        {
        Vec3i c = circles[i];
        circle( cimg, Point(c[0], c[1]), c[2], Scalar(255,0,0), 3, CV_AA);
        circle( cimg, Point(c[0], c[1]), 2, Scalar(0,255,0), 3, CV_AA);
        }
    
    
    return cimg;
}

/*  the original code from the openCV samples
int main(int argc, char** argv)
{
    const char* filename = argc >= 2 ? argv[1] : "board.jpg";
    
    Mat img = imread(filename, 0);
    if(img.empty())
        {
            //help();
        cout << "can not open " << filename << endl;
        return -1;
        }
    
    Mat cimg;
    medianBlur(img, img, 5);
    cvtColor(img, cimg, CV_GRAY2BGR);
    
    vector<Vec3f> circles;
    HoughCircles(img, circles, CV_HOUGH_GRADIENT, 1, 10,
                 100, 30, 1, 30 // change the last two parameters
                 // (min_radius & max_radius) to detect larger circles
                 );
    for( size_t i = 0; i < circles.size(); i++ )
        {
        Vec3i c = circles[i];
        circle( cimg, Point(c[0], c[1]), c[2], Scalar(0,0,255), 3, CV_AA);
        circle( cimg, Point(c[0], c[1]), 2, Scalar(0,255,0), 3, CV_AA);
        }
    
    imshow("detected circles", cimg);
    waitKey();
    
    return 0;
}

*/