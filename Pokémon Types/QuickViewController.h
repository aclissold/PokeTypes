//
//  FirstViewController.h
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import <UIKit/UIKit.h>

// TODO: Considering using properties instead (nonatomic, retain)

@interface QuickViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *firstPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *secondPickerView;
@property (weak, nonatomic) IBOutlet UILabel *effectivenessLabel;
@property (weak, nonatomic) IBOutlet UILabel *attackTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *opposingTypeLabel;
@end
