//
//  CVWrapper.mm
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 Washe / Foundry. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "CVWrapper.h"
#import "CVCircles.h"
#import "UIImage+OpenCV.h"

    //remove 'magic numbers' from original C++ source so we can manipulate them from obj-C
#define TOLERANCE 0.3
#define THRESHOLD 50
#define LEVELS 9
#define ACCURACY 0

@implementation CVWrapper

+ (UIImage*) detectedCirclesInImage:(UIImage*) image
{
    double dp = 1;
    double minDist = 10;
    double param1 = 100;
    double param2 = 30;
    int min_radius = 1;
    int max_radius = 30;

    return [[self class] detectedCirclesInImage:image
                                             dp:dp
                                        minDist:minDist
                                         param1:param1
                                         param2:param2
                                     min_radius:min_radius
                                     max_radius:max_radius];
}


+ (UIImage*) detectedCirclesInImage:(UIImage*)image
                                 dp:(CGFloat)dp
                            minDist:(CGFloat)minDist
                             param2:(CGFloat)param2

{
    double param1 = 100;
    int min_radius = 1;
    int max_radius = 30;
    
    return [[self class] detectedCirclesInImage:image
                                             dp:dp
                                        minDist:minDist
                                         param1:param1
                                         param2:param2
                                     min_radius:min_radius
                                     max_radius:max_radius];
}

+ (UIImage*) detectedCirclesInImage:(UIImage*)image
                                 dp:(CGFloat)dp
                            minDist:(CGFloat)minDist
                             param2:(CGFloat)param2
                         min_radius:(int)min_radius
                         max_radius:(int)max_radius
{
    double param1 = 100;

return [[self class] detectedCirclesInImage:image
                                         dp:dp
                                    minDist:minDist
                                     param1:param1
                                     param2:param2
                                 min_radius:min_radius
                                 max_radius:max_radius];
}



+ (UIImage*) detectedCirclesInImage:(UIImage*)image
                                 dp:(CGFloat)dp
                            minDist:(CGFloat)minDist
                             param1:(CGFloat)param1
                             param2:(CGFloat)param2
                         min_radius:(int)min_radius
                         max_radius:(int)max_radius
{
    
    UIImage* result = nil;
    cv::Mat matImage = [image CVMat];
    matImage = CVCircles::detectedCirclesInImage
    (matImage,  dp,  minDist, param1, param2, min_radius, max_radius);
    result = [UIImage imageWithCVMat:matImage];
    return result;
}


@end
