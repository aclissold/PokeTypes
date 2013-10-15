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

// I'd recommend folding this method if you're not me and haven't already. Lots of hard-coded stuff.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.typesDict = @{
                       [NSNumber numberWithInt:bug]:      @"Bug",
                       [NSNumber numberWithInt:dark]:     @"Dark",
                       [NSNumber numberWithInt:dragon]:   @"Dragon",
                       [NSNumber numberWithInt:electric]: @"Electric",
                       [NSNumber numberWithInt:fairy]:    @"Fairy",
                       [NSNumber numberWithInt:fighting]: @"Fighting",
                       [NSNumber numberWithInt:fire]:     @"Fire",
                       [NSNumber numberWithInt:flying]:   @"Flying",
                       [NSNumber numberWithInt:ghost]:    @"Ghost",
                       [NSNumber numberWithInt:grass]:    @"Grass",
                       [NSNumber numberWithInt:ground]:   @"Ground",
                       [NSNumber numberWithInt:ice]:      @"Ice",
                       [NSNumber numberWithInt:norm]:     @"Normal",
                       [NSNumber numberWithInt:poison]:   @"Poison",
                       [NSNumber numberWithInt:psychic]:  @"Psychic",
                       [NSNumber numberWithInt:rock]:     @"Rock",
                       [NSNumber numberWithInt:steel]:    @"Steel",
                       [NSNumber numberWithInt:water]:    @"Water",
                       };
    
    // Bug attack type
    typeMatchups[bug][bug]      = normallyEffective;
    typeMatchups[bug][dark]     = superEffective;
    typeMatchups[bug][dragon]   = normallyEffective;
    typeMatchups[bug][electric] = normallyEffective;
    typeMatchups[bug][fairy]    = notVeryEffective;
    typeMatchups[bug][fighting] = notVeryEffective;
    typeMatchups[bug][fire]     = notVeryEffective;
    typeMatchups[bug][flying]   = notVeryEffective;
    typeMatchups[bug][ghost]    = notVeryEffective;
    typeMatchups[bug][grass]    = superEffective;
    typeMatchups[bug][ground]   = normallyEffective;
    typeMatchups[bug][ice]      = normallyEffective;
    typeMatchups[bug][norm]     = normallyEffective;
    typeMatchups[bug][poison]   = notVeryEffective;
    typeMatchups[bug][psychic]  = superEffective;
    typeMatchups[bug][rock]     = normallyEffective;
    typeMatchups[bug][steel]    = notVeryEffective;
    typeMatchups[bug][water]    = normallyEffective;
    
    // Dark attack type
    typeMatchups[dark][bug]      = normallyEffective;
    typeMatchups[dark][dark]     = notVeryEffective;
    typeMatchups[dark][dragon]   = normallyEffective;
    typeMatchups[dark][electric] = normallyEffective;
    typeMatchups[dark][fairy]    = notVeryEffective;
    typeMatchups[dark][fighting] = notVeryEffective;
    typeMatchups[dark][fire]     = normallyEffective;
    typeMatchups[dark][flying]   = normallyEffective;
    typeMatchups[dark][ghost]    = superEffective;
    typeMatchups[dark][grass]    = normallyEffective;
    typeMatchups[dark][ground]   = normallyEffective;
    typeMatchups[dark][ice]      = normallyEffective;
    typeMatchups[dark][norm]     = normallyEffective;
    typeMatchups[dark][poison]   = normallyEffective;
    typeMatchups[dark][psychic]  = superEffective;
    typeMatchups[dark][rock]     = normallyEffective;
    typeMatchups[dark][steel]    = normallyEffective;
    typeMatchups[dark][water]    = normallyEffective;

    // Dragon attack type
    typeMatchups[dragon][bug]      = normallyEffective;
    typeMatchups[dragon][dark]     = normallyEffective;
    typeMatchups[dragon][dragon]   = superEffective;
    typeMatchups[dragon][electric] = normallyEffective;
    typeMatchups[dragon][fairy]    = noEffect;
    typeMatchups[dragon][fighting] = normallyEffective;
    typeMatchups[dragon][fire]     = normallyEffective;
    typeMatchups[dragon][flying]   = normallyEffective;
    typeMatchups[dragon][ghost]    = normallyEffective;
    typeMatchups[dragon][grass]    = normallyEffective;
    typeMatchups[dragon][ground]   = normallyEffective;
    typeMatchups[dragon][ice]      = normallyEffective;
    typeMatchups[dragon][norm]     = normallyEffective;
    typeMatchups[dragon][poison]   = normallyEffective;
    typeMatchups[dragon][psychic]  = normallyEffective;
    typeMatchups[dragon][rock]     = normallyEffective;
    typeMatchups[dragon][steel]    = notVeryEffective;
    typeMatchups[dragon][water]    = normallyEffective;
    
    // Electric attack type
    typeMatchups[electric][bug]      = normallyEffective;
    typeMatchups[electric][dark]     = normallyEffective;
    typeMatchups[electric][dragon]   = notVeryEffective;
    typeMatchups[electric][electric] = notVeryEffective;
    typeMatchups[electric][fairy]    = normallyEffective;
    typeMatchups[electric][fighting] = normallyEffective;
    typeMatchups[electric][fire]     = normallyEffective;
    typeMatchups[electric][flying]   = superEffective;
    typeMatchups[electric][ghost]    = normallyEffective;
    typeMatchups[electric][grass]    = notVeryEffective;
    typeMatchups[electric][ground]   = noEffect;
    typeMatchups[electric][ice]      = normallyEffective;
    typeMatchups[electric][norm]     = normallyEffective;
    typeMatchups[electric][poison]   = normallyEffective;
    typeMatchups[electric][psychic]  = normallyEffective;
    typeMatchups[electric][rock]     = normallyEffective;
    typeMatchups[electric][steel]    = normallyEffective;
    typeMatchups[electric][water]    = superEffective;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.typesDict count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.typesDict objectForKey:[NSNumber numberWithInt:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    int effectiveness = typeMatchups[[firstPickerView selectedRowInComponent:0]][[secondPickerView selectedRowInComponent:0]];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
