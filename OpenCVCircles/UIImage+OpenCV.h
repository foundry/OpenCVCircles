    //
    //  UIImage+OpenCV.h
    //  OpenCVClient
    //
    //  Created by JWM on 01/12/2012.
    //  Copyright 2012 JWM / Foundry. All rights reserved.
    //
    //  Permission is given to use this source code file without charge in any
    //  project, commercial or otherwise, entirely at your risk, with the condition
    //  that any redistribution (in part or whole) of source code must retain
    //  this copyright and permission notice. Attribution in compiled projects is
    //  appreciated but not required.
    //

#import <UIKit/UIKit.h>

@interface UIImage (OpenCV)

    //cv::Mat to UIImage
+ (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat;
+ (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat
                orientation:(UIImageOrientation)orientation;

- (id)initWithCVMat:(const cv::Mat&)cvMat
        orientation:(UIImageOrientation)orientation;

    //UIImage to cv::Mat
- (cv::Mat)CVMat;
- (cv::Mat)CVMat3;  // no alpha channel
- (cv::Mat)CVGrayscaleMat;

@end
