//
//  FirstViewController.m
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import "PokeBallFactory.h"
#import "QuickViewController.h"
#import "PickerRowView.h"

#define ALPHA 0.7

@interface QuickViewController() {
    CGFloat reds[18], greens[18], blues[18]; // holds the RGB values of type colors for the background
    int typeMatchups[18][18]; // A 2D array of type matchups; the rows are attack types and the columns are opposing Pokémon
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *opposingTypeLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondPickerViewBottomConstraint;
@property (strong, nonatomic) CAGradientLayer *gradient;
@property (strong, nonatomic) NSArray *typesArray;
@end

@implementation QuickViewController

const CGFloat kPickerConstraintSize = -10.0;
const CGFloat kOpposingTypeLabelConstraintSize = 30.0;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set up the data objects
    _typesArray = [PokeBallFactory initializeTypesArray];
    [PokeBallFactory initializeTypeMatchups:typeMatchups];
    [PokeBallFactory initializeReds:reds greens:greens blues:blues];

    // Add the gradient background
    _gradient = [CAGradientLayer layer];
    _gradient.frame = self.view.bounds;
    _gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:ALPHA] CGColor],
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:ALPHA] CGColor], nil];
    [self.view.layer insertSublayer:_gradient atIndex:0];
    
    // Make the labels vertical
    self.attackTypeLabel.transform = CGAffineTransformMakeRotation(3 * M_PI_2);
    self.opposingTypeLabel.transform = CGAffineTransformMakeRotation(3 * M_PI_2);
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.typesArray count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger firstSelectedRow  = [self.firstPickerView selectedRowInComponent:0];
    NSInteger secondSelectedRow = [self.secondPickerView selectedRowInComponent:0];
    int effectiveness     = typeMatchups[firstSelectedRow][secondSelectedRow];
    
    switch (effectiveness) {
        case noEffect:
            self.effectivenessLabel.text = @"Has no effect.";
            break;
        case notVeryEffective:
            self.effectivenessLabel.text = @"It's not very effective...";
            break;
        case normallyEffective:
            self.effectivenessLabel.text = @"Normally effective.";
            break;
        case superEffective:
            self.effectivenessLabel.text = @"It's super effective!";
            break;
        default:
            break;
    }
    
    self.gradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:reds[firstSelectedRow] green:greens[firstSelectedRow] blue:blues[firstSelectedRow] alpha:ALPHA] CGColor],
                          (id)[[UIColor colorWithRed:reds[secondSelectedRow] green:greens[secondSelectedRow] blue:blues[secondSelectedRow] alpha:ALPHA] CGColor], nil];
    }

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

// The images are instantiated directly within this method as a workaround for a display bug
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *type = self.typesArray[row];
    return [[PickerRowView alloc] initWithTitle:type image:[UIImage imageNamed:type]];
}

@end
