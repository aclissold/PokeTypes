//
//  FirstViewController.h
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import <UIKit/UIKit.h>

// TODO: Considering using properties instead (nonatomic, retain)

@interface QuickViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *firstPickerView;
    IBOutlet UIPickerView *secondPickerView;
    IBOutlet UILabel *label;
    int typeMatchups[18][18]; // A 2D array of type matchups; the rows are attack types and the columns are opposing Pokémon
    CGFloat reds[18], greens[18], blues[18]; // holds the RGB values of type colors for the background
    CAGradientLayer *gradient, *newGradientCopy, *clearGradient;
    NSInteger firstSelectedRow, secondSelectedRow;
    CALayer *tempLayer;
    NSDictionary *typesDict;
    IBOutlet UILabel *attackTypeLabel;
    IBOutlet UILabel *opposingTypeLabel;
}

@end
