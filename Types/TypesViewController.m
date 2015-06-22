//
//  TypesViewController.m
//  Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

#import "TypesViewController.h"

#import "PickerRowView.h"
#import "PokeBallFactory.h"
#import "RateItAlertController.h"

static const float kAlpha = 0.7;

@interface TypesViewController() <UIPickerViewDelegate, UIPickerViewDataSource> {
    CGFloat reds[18], greens[18], blues[18];
    int typeMatchups[18][18];
}

@property (weak, nonatomic) IBOutlet UILabel *effectivenessLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *attackTypePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *opposingTypePickerView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) CAGradientLayer *gradient;
@property (strong, nonatomic) NSArray *typesArray;
@property (nonatomic) NSInteger lastSelectedRow;

@property (nonatomic, strong) RateItAlertController *rateItAlertController;

// For localization
@property (weak, nonatomic) IBOutlet UIImageView *attackTypePill;
@property (weak, nonatomic) IBOutlet UIImageView *opposingTypePill;
@property (weak, nonatomic) IBOutlet UIImageView *attackTypePillHorizontal;
@property (weak, nonatomic) IBOutlet UIImageView *opposingTypePillHorizontal;

@end

@implementation TypesViewController
const CGFloat kPickerConstraintSize = -10.0;
const CGFloat kOpposingTypeLabelConstraintSize = 30.0;

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set up the data objects
    self.typesArray = [PokeBallFactory initializeTypesArray];
    [PokeBallFactory initializeTypeMatchups:typeMatchups];
    [PokeBallFactory initializeReds:reds greens:greens blues:blues];

    // Add the gradient background
    self.gradient = [CAGradientLayer layer];
    self.gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:kAlpha] CGColor],
                       (id)[[UIColor colorWithRed:reds[bug] green:greens[bug] blue:blues[bug] alpha:kAlpha] CGColor], nil];
    [self.view.layer insertSublayer:self.gradient atIndex:0];
    [self updateGradientFrame];

    self.rateItAlertController = [[RateItAlertController alloc] init];

    NSString *attackTypePillImageName = NSLocalizedString(@"AttackTypePill", @"Attack type pill image name");
    NSString *opposingTypePillImageName = NSLocalizedString(@"OpposingTypePill", @"Opposing type pill image name");
    NSString *attackTypePillHorizontalImageName = NSLocalizedString(@"AttackTypePillHorizontal", @"Horizontal attack type pill image name");
    NSString *opposingTypePillHorizontalImageName = NSLocalizedString(@"OpposingTypePillHorizontal", @"Horizontal opposing type pill image name");
    self.attackTypePill.image = [UIImage imageNamed:attackTypePillImageName];
    self.opposingTypePill.image = [UIImage imageNamed:opposingTypePillImageName];
    self.attackTypePillHorizontal.image = [UIImage imageNamed:attackTypePillHorizontalImageName];
    self.opposingTypePillHorizontal.image = [UIImage imageNamed:opposingTypePillHorizontalImageName];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rateItAlertController showRateItAlertIfNecessary];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateGradientFrame];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateGradientFrame];
}

- (void)updateGradientFrame {
    BOOL isRegularWidthRegularHeight;
    if ([UITraitCollection class]) {
        isRegularWidthRegularHeight =
        (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) &&
        (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular);
    } else {
        isRegularWidthRegularHeight =
        [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    }

    CGFloat angle = isRegularWidthRegularHeight ? -M_PI_2 : 0;
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(angle);
    self.gradient.transform = CATransform3DMakeAffineTransform(rotationTransform);
    self.gradient.frame = self.view.bounds;
}

#pragma mark - Primary Logic

- (void)updateEffectivenessLabelAndBackground {
    NSInteger i  = [self.attackTypePickerView selectedRowInComponent:0];
    NSInteger j = [self.opposingTypePickerView selectedRowInComponent:0];
    NSInteger k = -1;
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        k = [self.opposingTypePickerView selectedRowInComponent:1];
    }

    int effectiveness;
    if (k == -1 || j == k) {
        // Only one picker view onscreen or bottom pickers are the same type
        effectiveness = typeMatchups[i][j];
    } else {
        int firstEffectiveness = typeMatchups[i][j];
        int secondEffectiveness = typeMatchups[i][k];
        effectiveness = [self combinedEffectivenessForFirstEffectiveness:firstEffectiveness
                                                     secondEffectiveness:secondEffectiveness];
    }
    switch (effectiveness) {
        case noEffect:
            self.effectivenessLabel.text = NSLocalizedString(@"Has no effect.", @"0x effectiveness description");
            break;
        case veryNotVeryEffective:
            self.effectivenessLabel.text = NSLocalizedString(@"It’s ¼ effective…", @"1/4x effectiveness description");
            break;
        case notVeryEffective:
            self.effectivenessLabel.text = NSLocalizedString(@"It’s not very effective…", @"1/2x effectiveness description");
            break;
        case normallyEffective:
            self.effectivenessLabel.text = NSLocalizedString(@"Normally effective.", @"1x effectiveness description");
            break;
        case superEffective:
            self.effectivenessLabel.text = NSLocalizedString(@"It’s super effective!", @"2x effectiveness description");
            break;
        case superSuperEffective:
            self.effectivenessLabel.text = NSLocalizedString(@"It’s 4x effective!", @"4x effectiveness description");
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

float damageMultipliers[4] = {1.0, 0.0, 0.5, 2.0};
- (int)combinedEffectivenessForFirstEffectiveness:(int)firstEffectiveness
                              secondEffectiveness:(int)secondEffectiveness {

    float damage = damageMultipliers[firstEffectiveness] * damageMultipliers[secondEffectiveness];

    if (damage == 0.0)  return noEffect;
    if (damage == 0.25) return veryNotVeryEffective;
    if (damage == 0.5)  return notVeryEffective;
    if (damage == 1.0)  return normallyEffective;
    if (damage == 2.0)  return superEffective;
    if (damage == 4.0)  return superSuperEffective;

    NSLog(@"Unknown damage amount: %f", damage);
    return -1;
}

- (IBAction)swapPickers:(UIButton *)sender {
    NSInteger firstPickerRow = [self.attackTypePickerView selectedRowInComponent:0];
    NSInteger secondPickerRow = [self.opposingTypePickerView selectedRowInComponent:0];
    [self.attackTypePickerView selectRow:secondPickerRow inComponent:0 animated:YES];
    [self.opposingTypePickerView selectRow:firstPickerRow inComponent:0 animated:YES];
    [self updateEffectivenessLabelAndBackground];
}

- (IBAction)segmentedControlChanged:(UISegmentedControl *)segmentedControl {
    [self.opposingTypePickerView reloadAllComponents];
    if (segmentedControl.selectedSegmentIndex == 1) {
        [self.opposingTypePickerView selectRow:self.lastSelectedRow inComponent:1 animated:NO];
    }
    [self updateEffectivenessLabelAndBackground];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.opposingTypePickerView) {
        return self.segmentedControl.selectedSegmentIndex + 1;
    }

    return 1;
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    // The images are instantiated directly within this method as a workaround for a display bug.
    NSString *typeImageName = self.typesArray[row][0];
    UIImage *typeImage = [UIImage imageNamed:typeImageName];

    NSString *typeName = self.typesArray[row][1];

    return [[PickerRowView alloc] initWithTitle:typeName image:typeImage];
}

@end
