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
    CGFloat reds[18], greens[18], blues[18];
    int typeMatchups[18][18];
}

@property (weak, nonatomic) IBOutlet UILabel *effectivenessLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *topPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *bottomPickerView;

@property (weak, nonatomic) IBOutlet UILabel *attackTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *opposingTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *attackTypeView;
@property (weak, nonatomic) IBOutlet UIView *opposingTypeView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) CAGradientLayer *gradient;
@property (strong, nonatomic) NSArray *typesArray;
@property (nonatomic) NSInteger lastSelectedRow;

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

    self.attackTypeView.layer.cornerRadius = 5.0f;
    self.opposingTypeView.layer.cornerRadius = 5.0f;
}

- (void)updateEffectivenessLabelAndBackground {
    NSInteger i  = [self.topPickerView selectedRowInComponent:0];
    NSInteger j = [self.bottomPickerView selectedRowInComponent:0];
    NSInteger k = -1;
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        k = [self.bottomPickerView selectedRowInComponent:1];
    }

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

    UIColor *bottomGradientColor;
    if (k == -1) {
        // Only one picker view onscreen
        bottomGradientColor = [UIColor colorWithRed:reds[j] green:greens[j] blue:blues[j] alpha:kAlpha];
    } else {
        CGFloat red = (reds[j] + reds[k]) / 2.0f;
        CGFloat green = (greens[j] + greens[k]) / 2.0f;
        CGFloat blue = (blues[j] + blues[k]) / 2.0f;
        bottomGradientColor = [UIColor colorWithRed:red green:green blue:blue alpha:kAlpha];
    }

    self.gradient.colors = @[(id)[[UIColor colorWithRed:reds[i] green:greens[i] blue:blues[i] alpha:kAlpha] CGColor],
                             (id)[bottomGradientColor CGColor]];
}

- (IBAction)swapPickers:(UIButton *)sender {
    NSInteger firstPickerRow = [self.topPickerView selectedRowInComponent:0];
    NSInteger secondPickerRow = [self.bottomPickerView selectedRowInComponent:0];
    [self.topPickerView selectRow:secondPickerRow inComponent:0 animated:YES];
    [self.bottomPickerView selectRow:firstPickerRow inComponent:0 animated:YES];
    [self updateEffectivenessLabelAndBackground];
}

- (IBAction)segmentedControlChanged:(UISegmentedControl *)segmentedControl {
    [self.bottomPickerView reloadAllComponents];
    [self updateEffectivenessLabelAndBackground];
    if (segmentedControl.selectedSegmentIndex == 1) {
        [self.bottomPickerView selectRow:self.lastSelectedRow inComponent:1 animated:NO];
    }
}

#pragma mark - UIPickerViewDelegate

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.segmentedControl.selectedSegmentIndex + 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.typesArray count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self updateEffectivenessLabelAndBackground];
    if (component == 1) {
        self.lastSelectedRow = row;
    }
}

// The images are instantiated directly within this method as a workaround for a display bug
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *type = self.typesArray[row];
    return [[PickerRowView alloc] initWithTitle:type image:[UIImage imageNamed:type]];
}

@end
