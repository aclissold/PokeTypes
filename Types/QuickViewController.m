//
//  FirstViewController.m
//  Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import "PokeBallFactory.h"
#import "QuickViewController.h"
#import "PickerRowView.h"

static const float kAlpha = 0.7;

@interface QuickViewController() {
    CGFloat reds[18], greens[18], blues[18]; // holds the RGB values of type colors for the background
    int typeMatchups[18][18]; // A 2D array of type matchups; the rows are attack types and the columns are opposing Pokémon
}
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
    self.typesArray = [PokeBallFactory initializeTypesArray];
    [PokeBallFactory initializeTypeMatchups:typeMatchups];
    [PokeBallFactory initializeReds:reds greens:greens blues:blues];

    // Add the gradient background
    self.gradient = [CAGradientLayer layer];
    self.gradient.frame = self.view.bounds;
    self.gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:kAlpha] CGColor],
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:kAlpha] CGColor], nil];
    [self.view.layer insertSublayer:self.gradient atIndex:0];

    // Make the labels vertical
    self.attackTypeLabel.transform = CGAffineTransformMakeRotation(3 * M_PI_2);
    self.opposingTypeLabel.transform = CGAffineTransformMakeRotation(3 * M_PI_2);
}

- (void)updateEffectivenessLabelAndBackground {
    NSInteger i  = [self.firstPickerView selectedRowInComponent:0];
    NSInteger j = [self.secondPickerView selectedRowInComponent:0];

    int effectiveness = typeMatchups[i][j];
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
                          (id)[[UIColor colorWithRed:reds[i] green:greens[i] blue:blues[i] alpha:kAlpha] CGColor],
                          (id)[[UIColor colorWithRed:reds[j] green:greens[j] blue:blues[j] alpha:kAlpha] CGColor], nil];
}

- (IBAction)swapPickers:(UIButton *)sender {
    NSInteger firstPickerRow = [self.firstPickerView selectedRowInComponent:0];
    NSInteger secondPickerRow = [self.secondPickerView selectedRowInComponent:0];
    [self.firstPickerView selectRow:secondPickerRow inComponent:0 animated:YES];
    [self.secondPickerView selectRow:firstPickerRow inComponent:0 animated:YES];
    [self updateEffectivenessLabelAndBackground];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.typesArray count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self updateEffectivenessLabelAndBackground];
}

// The images are instantiated directly within this method as a workaround for a display bug
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *type = self.typesArray[row];
    return [[PickerRowView alloc] initWithTitle:type image:[UIImage imageNamed:type]];
}

@end
