//
//  FirstViewController.m
//  Pokémon Types
//
//  Created by Andrew Clissold on 10/10/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import "QuickViewController.h"
#include <stdlib.h>

@interface QuickViewController ()

@end

@implementation QuickViewController

enum effectiveness {
    noEffect,
    notVeryEffective,
    normallyEffective,
    superEffective
};

enum types {
    bug,
    dark,
    dragon,
    electric,
    fairy,
    fighting,
    fire,
    flying,
    ghost,
    grass,
    ground,
    ice,
    norm, // normal is already taken by an enum of font stylings
    poison,
    psychic,
    rock,
    steel,
    water
};

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.typesArray = @[@"Bug", @"Dark", @"Dragon", @"Electric", @"Fairy", @"Fighting", @"Fire", @"Flying", @"Ghost", @"Grass", @"Ground", @"Ice", @"Normal", @"Poison", @"Psychic", @"Rock", @"Steel", @"Water"];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.typesArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.typesArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *firstType = self.typesArray[[firstPickerView selectedRowInComponent:0]];
    NSString *secondType = self.typesArray[[secondPickerView selectedRowInComponent:0]];
    NSMutableString *stringToDisplay = [NSMutableString new];
    [stringToDisplay appendString:firstType];
    [stringToDisplay appendString:@" vs. "];
    [stringToDisplay appendString:secondType];
    label.text = stringToDisplay;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
