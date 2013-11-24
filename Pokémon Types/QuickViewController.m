//
//  FirstViewController.m
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import "PokeBallFactory.h"
#import "QuickViewController.h"
#include <stdlib.h>

#define ALPHA 0.7

@interface QuickViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *opposingTypeLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondPickerViewBottomConstraint;

@end

@implementation QuickViewController

const CGFloat kPickerConstraintSize = -10.0;
const CGFloat kOpposingTypeLabelConstraintSize = 30.0;

// This method is a workaround for an iOS 7 bug that prevents subview positions from persisting in a tab bar controller.
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (self.bottomLayoutGuide.length == 0.0) {
        self.opposingTypeLabelBottomConstraint.constant = kOpposingTypeLabelConstraintSize + 49.0;
        self.secondPickerViewBottomConstraint.constant = kPickerConstraintSize + 49.0;
    } else {
        self.opposingTypeLabelBottomConstraint.constant = kOpposingTypeLabelConstraintSize;
        self.secondPickerViewBottomConstraint.constant = kPickerConstraintSize;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    typesDict = [PokeBallFactory typesDictMake];
    [PokeBallFactory instantiateTypeMatchups:typeMatchups];
    [PokeBallFactory instantiateReds:reds greens:greens blues:blues];
    
    gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:ALPHA] CGColor],
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:ALPHA] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    // Make the labels vertical
    attackTypeLabel.transform = CGAffineTransformMakeRotation(3 * M_PI_2);
    opposingTypeLabel.transform = CGAffineTransformMakeRotation(3 * M_PI_2);
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [typesDict count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [typesDict objectForKey:[NSNumber numberWithLong:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    firstSelectedRow  = [firstPickerView selectedRowInComponent:0];
    secondSelectedRow = [secondPickerView selectedRowInComponent:0];
    int effectiveness     = typeMatchups[firstSelectedRow][secondSelectedRow];
    
    switch (effectiveness) {
        case noEffect:
            label.text = @"Has no effect.";
            break;
        case notVeryEffective:
            label.text = @"It's not very effective...";
            break;
        case normallyEffective:
            label.text = @"Normally effective.";
            break;
        case superEffective:
            label.text = @"It's super effective!";
            break;
        default:
            break;
    }
    
    gradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:reds[firstSelectedRow] green:greens[firstSelectedRow] blue:blues[firstSelectedRow] alpha:ALPHA] CGColor],
                          (id)[[UIColor colorWithRed:reds[secondSelectedRow] green:greens[secondSelectedRow] blue:blues[secondSelectedRow] alpha:ALPHA] CGColor], nil];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
