//
//  SecondViewController.m
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import "ChartViewController.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5

@interface ChartViewController ()

@end

@implementation ChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Begin zoomed out
    zoomedIn = NO;

    // Set the tag for the image view
    [self.imageView setTag:ZOOM_VIEW_TAG];
    
    // Add gesture recognizers to the image view
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.imageView addGestureRecognizer:doubleTap];
    
    // Calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = self.imageScrollView.frame.size.width / self.imageView.frame.size.width;
    [self.imageScrollView setMinimumZoomScale:minimumScale];
    [self.imageScrollView setZoomScale:minimumScale];
}

#pragma mark UIScrollViewDelegate methods

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self.imageScrollView viewWithTag:ZOOM_VIEW_TAG];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"Received double tap");
    // Zoom in
    if (zoomedIn) {
        float newScale = [self.imageScrollView zoomScale] / ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [self.imageScrollView zoomToRect:zoomRect animated:YES];
        *zoomedIn = NO;
    }
    // Zoom out
    else if (!zoomedIn) {
        float newScale = [self.imageScrollView zoomScale] * ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [self.imageScrollView zoomToRect:zoomRect animated:YES];
        *zoomedIn = YES;
    }
    else {
        NSLog(@"Neither zoomed in nor zoomed out");
    }
}

#pragma mark Utility methods

- (CGRect) zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoomRect is in the content view's coordinates.
    // At a zoom scale of 1.0, this would be the the size of the imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = self.imageScrollView.frame.size.height / scale;
    zoomRect.size.width = self.imageScrollView.frame.size.width / scale;
    
    // Choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.height / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.width / 2.0);
    
    return zoomRect;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
