//
//  FirstViewController.h
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *firstPickerView;
    IBOutlet UIPickerView *secondPickerView;
    IBOutlet UILabel *label;
}

@property (nonatomic) NSArray *typesArray;

@end
