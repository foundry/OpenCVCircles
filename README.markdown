__OpenCV computer vision with iOS__  
__Hough Circles Demo__

Requirements: OSX10.7+ XCode4.4+ iOS5.0+


__integrating openCV and C++ with objective-C__
           

This is a sample application using openCV in iOS. It adapts the "houghcircles.cpp" sample code included with the openCV distribution.
<https://github.com/Itseez/opencv/blob/master/samples/cpp/houghcircles.cpp>

Prompted from some questions on stack overflow:  
<http://stackoverflow.com/questions/14416089/opencv-errors-for-ios>  
<http://stackoverflow.com/questions/13958321/iosretrieve-rectangle-shaped-image-from-the-background-image?lq=1>

=======================

The aim is to keep the original c++ code as pristine as possible, and to keep the bulk of the work with openCV in pure c++ files for (im)portability.

__CVViewController.h / CVViewController.m__

- pure Objective-C

- communicates with openCV c++ code via a WRAPPER... it neither knows nor cares that c++ is processing these method calls behind the wrapper.

__CVWrapper.h / CVWrapper.mm__

- objective-C++

does as little as possible, really only two things...

- calls to UIImage objC++ categories to convert to and from UIImage <> cv::Mat
- mediates between CVViewController's obj-C methods and CVSquares c++ (class) function calls
  
 
__CVCircles.h /  CVCircles.cpp__  

- pure C++
- `CVCircles.cpp` declares public functions inside a class definition (in this case, one static function).   
This replaces the work of  `main{}` in the original file.
-  We try to keep `CVCircles.cpp` as close as possible to the C++ original for portability.

	
__UIImage+OpenCV__
    
This UIImage category is an objC++  file containing the code to convert between UIImage and cv::Mat image formats. 

