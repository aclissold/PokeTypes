//
//  PickerRowView.h
//  Types
//
//  Created by Andrew Clissold on 11/24/13.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerRowView : UIView

- (id)initWithTitle:(NSString *)title image:(UIImage *)image;

+ (CGFloat)viewHeight;
+ (CGFloat)viewWidth;

@end
