//
//  TypesViewController.m
//  Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

#import "PokeBallFactory.h"
#import "TypesViewController.h"
#import "PickerRowView.h"

static const float kAlpha = 0.7;

@interface TypesViewController() {
    CGFloat reds[18], greens[18], blues[18];
    int typeMatchups[18][18];
}

@property (weak, nonatomic) IBOutlet UILabel *effectivenessLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *topPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *bottomPickerView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) CAGradientLayer *gradient;
@property (strong, nonatomic) NSArray *typesArray;
@property (nonatomic) NSInteger lastSelectedRow;

// For localization
@property (strong, nonatomic) IBOutlet UIImageView *attackTypePill;
@property (strong, nonatomic) IBOutlet UIImageView *opposingTypePill;

@property (weak, nonatomic) IBOutlet UIToolbar *rateItView;

@end

@implementation TypesViewController

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

    UIBarButtonItem *hideButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                  target:self
                                                  action:@selector(hideRateItView)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *items = @[space, hideButton];
    self.rateItView.items = items;
    self.rateItView.clipsToBounds = YES;

    NSString *attackTypePillImageName = NSLocalizedString(@"AttackTypePill", @"Attack type pill image name");
    NSString *opposingTypePillImageName = NSLocalizedString(@"OpposingTypePill", @"Opposing type pill image name");
    self.attackTypePill.image = [UIImage imageNamed:attackTypePillImageName];
    self.opposingTypePill.image = [UIImage imageNamed:opposingTypePillImageName];
}

- (void)updateEffectivenessLabelAndBackground {
    NSInteger i  = [self.topPickerView selectedRowInComponent:0];
    NSInteger j = [self.bottomPickerView selectedRowInComponent:0];
    NSInteger k = -1;
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        k = [self.bottomPickerView selectedRowInComponent:1];
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
    NSInteger firstPickerRow = [self.topPickerView selectedRowInComponent:0];
    NSInteger secondPickerRow = [self.bottomPickerView selectedRowInComponent:0];
    [self.topPickerView selectRow:secondPickerRow inComponent:0 animated:YES];
    [self.bottomPickerView selectRow:firstPickerRow inComponent:0 animated:YES];
    [self updateEffectivenessLabelAndBackground];
}

- (IBAction)segmentedControlChanged:(UISegmentedControl *)segmentedControl {
    [self.bottomPickerView reloadAllComponents];
    if (segmentedControl.selectedSegmentIndex == 1) {
        [self.bottomPickerView selectRow:self.lastSelectedRow inComponent:1 animated:NO];
    }
    [self updateEffectivenessLabelAndBackground];
}

#pragma mark - RateIt View Logic

static NSString * const hasRatedKey = @"hasRated";
static NSString * const installDateKey = @"installDate";
static NSString * const hasSeenItKey = @"hasSeenIt";
static NSString * const appStoreURL = @"itms-apps://itunes.apple.com/app/id784727885";

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showRateItViewIfNecessary];
}

- (void)showRateItViewIfNecessary {
    BOOL hasRated = [[NSUserDefaults standardUserDefaults] boolForKey:hasRatedKey];
    if (hasRated) {
        return;
    }

    NSDate *installDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:installDateKey];
    if (installDate == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:installDateKey];
        return;
    }

    CGRect frame = self.rateItView.frame;
    frame.origin.y = CGRectGetHeight(self.view.bounds);
    self.rateItView.frame = frame;
    self.rateItView.hidden = NO;

    NSTimeInterval timeIntervalSinceInstall = [[NSDate date] timeIntervalSinceDate:installDate];
    BOOL hasSeenIt = [[NSUserDefaults standardUserDefaults] boolForKey:hasSeenItKey];
    if (timeIntervalSinceInstall > 60*60*24*10) { // 10 days
        [self showRateItView];
        // Just assume the user rated it to avoid bothering them anymore
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:hasRatedKey];
    } else if (timeIntervalSinceInstall > 60*60*24*2 && !hasSeenIt) { // 2 days
        [self showRateItView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:hasSeenItKey];
    }
}

- (IBAction)rateIt {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:hasRatedKey];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreURL]];
    [self hideRateItView];
}

- (void)showRateItView {
    [self animateRateItViewByY:-self.rateItView.frame.size.height];
}

- (void)hideRateItView {
    [self animateRateItViewByY:self.rateItView.frame.size.height];
}

- (void)animateRateItViewByY:(CGFloat)y {
    CGRect frame = self.rateItView.frame;
    frame.origin.y += y;
    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.rateItView.frame = frame;
    } completion:NULL];
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
