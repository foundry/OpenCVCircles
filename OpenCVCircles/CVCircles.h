//
//  CVSquares.h
//  OpenCVClient
//
//  Created by Washe on 30/12/2012.
//  Copyright (c) Washe / Foundry. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#ifndef __OpenCVClient__JMSquares__
#define __OpenCVClient__JMSquares__

    //#include <iostream>

    //class definition
    //in this example we do not need a class
    //as we have no instance variables and just one static function.
    //We could instead just declare the function but this form seems clearer

class CVCircles
{
public:
        //static cv::Mat detectedSquaresInImage (cv::Mat image, float tol, int threshold, int levels, int accuracy);
        //static cv::Mat detectedCirclesInImage (const cv::Mat image, double dp, double minDist, double param2);
    
    static cv::Mat detectedCirclesInImage
    (cv::Mat img, double dp, double minDist, double param1, double param2, int min_radius, int max_radius);

};

#endif /* defined(__OpenCVClient__JMSquares__) */
