//
//  CVViewController.m
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

#import "CVViewController.h"
#import "CVWrapper.h"

@interface CVViewController ()
@property (nonatomic, strong) UIImage* image;
@end

@implementation CVViewController

#define SLIDER_PADDING 12.0f


- (IBAction)toleranceChanged:(UISlider*)sender {
        //NSLog (@"sender %@",sender);
    [self setSpinnerLocation:(UISlider*)sender];
    [self modifyImage];
}


- (IBAction)toleranceTouchDragInside:(id)sender {
        //NSLog (@"sliderTouchDragInside");
        // NSLog (@"sender %@",sender);
    [self adjustTolerance];
    [self setSpinnerLocation:(UISlider*)sender];
    if (![self accuracy]) [self modifyImage];

}


- (IBAction)levelsChanged:(UISlider*)sender {
        //NSLog (@"levelsChanged %.1f", sender.value);
    [self setSpinnerLocation:(UISlider*)sender];
    [self modifyImage];
}

- (IBAction)levelsTouchDragInside:(id)sender {
        //NSLog (@"levelsTouchDragInside");
    [self adjustLevels];
    [self setSpinnerLocation:(UISlider*)sender];

    if (![self accuracy]) [self modifyImage];

    
}

- (IBAction)thresholdChanged:(UISlider*)sender {
        //NSLog (@"thresholdChanged %.1f", sender.value);
    [self setSpinnerLocation:(UISlider*)sender];
    [self modifyImage];
}

- (IBAction)thresholdTouchDragInside:(id)sender {
        //NSLog (@"thresholdTouchDragInside");
    [self adjustThreshold];
    [self setSpinnerLocation:(UISlider*)sender];

    if (![self accuracy]) [self modifyImage];

}

- (IBAction)minRadiusChanged:(UISlider*)sender {
        //NSLog (@"thresholdChanged %.1f", sender.value);
    [self setSpinnerLocation:(UISlider*)sender];
    [self modifyImage];
}

- (IBAction)minRadiusTouchDragInside:(id)sender {
        //NSLog (@"thresholdTouchDragInside");
    [self adjustMinRadius];
    [self setSpinnerLocation:(UISlider*)sender];
    
    if (![self accuracy]) [self modifyImage];
    
}

- (IBAction)maxRadiusChanged:(UISlider*)sender {
        //NSLog (@"thresholdChanged %.1f", sender.value);
    [self setSpinnerLocation:(UISlider*)sender];
    [self modifyImage];
}

- (IBAction)maxRadiusTouchDragInside:(id)sender {
        //NSLog (@"thresholdTouchDragInside");
    [self adjustMaxRadius];
    [self setSpinnerLocation:(UISlider*)sender];
    
    if (![self accuracy]) [self modifyImage];
    
}

- (void) adjustTolerance
{
    self.dp = self.toleranceSlider.value;
        //self.toleranceLabel.text = [NSString stringWithFormat:@"%.1f", self.tolerance];
    self.toleranceLabel.text = [NSString stringWithFormat:@"%.0f", self.toleranceSlider.value];
}

- (void) adjustLevels
{
    self.minDist = self.levelsSlider.value;
    self.levelsLabel.text = [NSString stringWithFormat:@"%.0f", self.minDist];
}

- (void) adjustThreshold
{
    self.param2 = self.thresholdSlider.value;
    self.thresholdLabel.text = [NSString stringWithFormat:@"%.0f", self.param2];

}

- (void) adjustMinRadius
{
    self.minRadius = floor(self.minRadiusSlider.value);
    self.minRadiusLabel.text = [NSString stringWithFormat:@"%d", self.minRadius];
    
}

- (void) adjustMaxRadius
{
    self.maxRadius = floor(self.maxRadiusSlider.value);
    self.maxRadiusLabel.text = [NSString stringWithFormat:@"%d", self.maxRadius];
    
}

- (void) setSpinnerLocation:(UISlider*)slider
{
    UILabel* label =
    ([slider isEqual:self.toleranceSlider])? self.toleranceLabel:
    ([slider isEqual:self.levelsSlider])?    self.levelsLabel:
    ([slider isEqual:self.thresholdSlider])? self.thresholdLabel:
    ([slider isEqual:self.minRadiusSlider])? self.minRadiusLabel:
    ([slider isEqual:self.maxRadiusSlider])? self.maxRadiusLabel:
    nil;
    
    CGFloat valueWidth = slider.maximumValue -  slider.minimumValue;
    CGFloat valueRatio = ([label.text intValue]- slider.minimumValue)/valueWidth;
    CGFloat originX = valueRatio*(slider.bounds.size.width-2*SLIDER_PADDING)
    
    + slider.frame.origin.x
    + SLIDER_PADDING;
        // CGFloat centerX = (originX - self.spinner.bounds.size.width/2);
    CGFloat centerX = originX;
    
    CGFloat centerY = slider.center.y;
    self.spinner.center = CGPointMake (centerX, centerY);
    
}


- (void) modifyImage
{
        //NSLog (@"modifyImage");
    [self.spinner startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage* image =
        [CVWrapper detectedCirclesInImage:self.image
                                       dp:self.dp
                                  minDist:self.minDist
                                   param2:self.param2
                               min_radius:self.minRadius
                               max_radius:self.maxRadius];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            [self.spinner stopAnimating];
            
        });
    });
}

- (IBAction)imageTapped:(UITapGestureRecognizer*)sender {
    CGPoint tapLocationInSelfView = [sender locationInView:self.view];
    
    if (!CGRectContainsPoint(self.controlsView.frame, tapLocationInSelfView)) {
        [self toggleControlsView];
           }
}

- (IBAction)accuracyChanged:(id)sender {
    [self modifyImage];
}

- (int)accuracy {
    return [self.accuracySelector selectedSegmentIndex];
}

- (void) toggleControlsView
{
    CGRect viewFrame = self.controlsView.frame;
    if (viewFrame.origin.y == self.view.frame.size.height) {
        viewFrame.origin.y = self.view.frame.size.height - viewFrame.size.height;
    } else {
        viewFrame.origin.y = self.view.frame.size.height;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.controlsView.frame = viewFrame;
    [UIView commitAnimations];

}

- (void) toggleControlsView:(NSTimer*)theTimer
{
    [self toggleControlsView];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.image = [UIImage imageNamed:@"circles2.jpg"];
    self.imageView.image = self.image;
    [super viewWillAppear:animated];
    [self adjustThreshold];
    [self adjustTolerance];
    [self adjustLevels];
    [self adjustMinRadius];
    [self adjustMaxRadius];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self forOpenCV];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(toggleControlsView:)
                                           userInfo:nil
                                            repeats:NO];
        //[self toggleControlsView];
}


- (void) forOpenCV
{
    if( self.image != nil ) {
        UIImage* image =
        
        [CVWrapper detectedCirclesInImage:self.image
                                       dp:self.dp
                                  minDist:self.minDist
                                   param2:self.param2
                               min_radius:self.minRadius
                               max_radius:self.maxRadius];

        self.imageView.image = image;
    }
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setAccuracySelector:nil];
    [super viewDidUnload];
}

- (void) imagePickerImage:(UIImage*)image;
{
    self.image = image;
    self.imageView.image = self.image;
}
@end
