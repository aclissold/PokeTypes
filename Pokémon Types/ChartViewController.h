//
//  SecondViewController.h
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartViewController : UIViewController <UIScrollViewDelegate> {
    BOOL *zoomedIn;
}

@property (nonatomic, retain) IBOutlet UIScrollView *imageScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
