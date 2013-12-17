//
//  PokeBallFactory.m
//  Types
//
//  Created by Andrew Clissold on 11/3/13.
//  Copyright (c) 2013 Andrew Clissold. All rights reserved.
//

#import "PokeBallFactory.h"

@implementation PokeBallFactory

+ (NSArray *)initializeTypesArray {

    return @[@"Bug", @"Dark", @"Dragon", @"Electric", @"Fairy", @"Fighting",
             @"Fire", @"Flying", @"Ghost", @"Grass", @"Ground", @"Ice",
             @"Normal", @"Poison", @"Psychic", @"Rock", @"Steel", @"Water"];
}

+ (void)initializeTypeMatchups:(int[18][18])typeMatchups {

    // normallyEffective is intentionally the first value of the effectiveness enum since it's the most common. This lets us halve the number of assignments that have to be made to this array, since each cell of the array is already set to 0 upon instantiation.
    // They're left here commented-out for reference.

    // Bug attack type
    typeMatchups[bug][bug]         = normallyEffective;
    typeMatchups[bug][dark]        = superEffective;
    // typeMatchups[bug][dragon]   = normallyEffective;
    // typeMatchups[bug][electric] = normallyEffective;
    typeMatchups[bug][fairy]       = notVeryEffective;
    typeMatchups[bug][fighting]    = notVeryEffective;
    typeMatchups[bug][fire]        = notVeryEffective;
    typeMatchups[bug][flying]      = notVeryEffective;
    typeMatchups[bug][ghost]       = notVeryEffective;
    typeMatchups[bug][grass]       = superEffective;
    // typeMatchups[bug][ground]   = normallyEffective;
    // typeMatchups[bug][ice]      = normallyEffective;
    // typeMatchups[bug][norm]     = normallyEffective;
    typeMatchups[bug][poison]      = notVeryEffective;
    typeMatchups[bug][psychic]     = superEffective;
    // typeMatchups[bug][rock]     = normallyEffective;
    typeMatchups[bug][steel]       = notVeryEffective;
    // typeMatchups[bug][water]    = normallyEffective;

    // Dark attack type
    // typeMatchups[dark][bug]      = normallyEffective;
    typeMatchups[dark][dark]        = notVeryEffective;
    // typeMatchups[dark][dragon]   = normallyEffective;
    // typeMatchups[dark][electric] = normallyEffective;
    typeMatchups[dark][fairy]       = notVeryEffective;
    typeMatchups[dark][fighting]    = notVeryEffective;
    // typeMatchups[dark][fire]     = normallyEffective;
    // typeMatchups[dark][flying]   = normallyEffective;
    typeMatchups[dark][ghost]       = superEffective;
    // typeMatchups[dark][grass]    = normallyEffective;
    // typeMatchups[dark][ground]   = normallyEffective;
    // typeMatchups[dark][ice]      = normallyEffective;
    // typeMatchups[dark][norm]     = normallyEffective;
    // typeMatchups[dark][poison]   = normallyEffective;
    typeMatchups[dark][psychic]     = superEffective;
    // typeMatchups[dark][rock]     = normallyEffective;
    // typeMatchups[dark][steel]    = normallyEffective;
    // typeMatchups[dark][water]    = normallyEffective;

    // Dragon attack type
    // typeMatchups[dragon][bug]      = normallyEffective;
    // typeMatchups[dragon][dark]     = normallyEffective;
    typeMatchups[dragon][dragon]      = superEffective;
    // typeMatchups[dragon][electric] = normallyEffective;
    typeMatchups[dragon][fairy]       = noEffect;
    // typeMatchups[dragon][fighting] = normallyEffective;
    // typeMatchups[dragon][fire]     = normallyEffective;
    // typeMatchups[dragon][flying]   = normallyEffective;
    // typeMatchups[dragon][ghost]    = normallyEffective;
    // typeMatchups[dragon][grass]    = normallyEffective;
    // typeMatchups[dragon][ground]   = normallyEffective;
    // typeMatchups[dragon][ice]      = normallyEffective;
    // typeMatchups[dragon][norm]     = normallyEffective;
    // typeMatchups[dragon][poison]   = normallyEffective;
    // typeMatchups[dragon][psychic]  = normallyEffective;
    // typeMatchups[dragon][rock]     = normallyEffective;
    typeMatchups[dragon][steel]       = notVeryEffective;
    // typeMatchups[dragon][water]    = normallyEffective;

    // Electric attack type
    // typeMatchups[electric][bug]      = normallyEffective;
    // typeMatchups[electric][dark]     = normallyEffective;
    typeMatchups[electric][dragon]      = notVeryEffective;
    typeMatchups[electric][electric]    = notVeryEffective;
    // typeMatchups[electric][fairy]    = normallyEffective;
    // typeMatchups[electric][fighting] = normallyEffective;
    // typeMatchups[electric][fire]     = normallyEffective;
    typeMatchups[electric][flying]      = superEffective;
    // typeMatchups[electric][ghost]    = normallyEffective;
    typeMatchups[electric][grass]       = notVeryEffective;
    typeMatchups[electric][ground]      = noEffect;
    // typeMatchups[electric][ice]      = normallyEffective;
    // typeMatchups[electric][norm]     = normallyEffective;
    // typeMatchups[electric][poison]   = normallyEffective;
    // typeMatchups[electric][psychic]  = normallyEffective;
    // typeMatchups[electric][rock]     = normallyEffective;
    // typeMatchups[electric][steel]    = normallyEffective;
    typeMatchups[electric][water]       = superEffective;

    // Fairy attack type
    // typeMatchups[fairy][bug]      = normallyEffective;
    typeMatchups[fairy][dark]        = superEffective;
    typeMatchups[fairy][dragon]      = superEffective;
    // typeMatchups[fairy][electric] = normallyEffective;
    // typeMatchups[fairy][fairy]    = normallyEffective;
    typeMatchups[fairy][fighting]    = superEffective;
    typeMatchups[fairy][fire]        = notVeryEffective;
    // typeMatchups[fairy][flying]   = normallyEffective;
    // typeMatchups[fairy][ghost]    = normallyEffective;
    // typeMatchups[fairy][grass]    = normallyEffective;
    // typeMatchups[fairy][ground]   = normallyEffective;
    // typeMatchups[fairy][ice]      = normallyEffective;
    // typeMatchups[fairy][norm]     = normallyEffective;
    typeMatchups[fairy][poison]      = notVeryEffective;
    // typeMatchups[fairy][psychic]  = normallyEffective;
    // typeMatchups[fairy][rock]     = normallyEffective;
    typeMatchups[fairy][steel]       = notVeryEffective;
    // typeMatchups[fairy][water]    = normallyEffective;

    // Fighting attack type
    typeMatchups[fighting][bug]         = notVeryEffective;
    typeMatchups[fighting][dark]        = superEffective;
    // typeMatchups[fighting][dragon]   = normallyEffective;
    // typeMatchups[fighting][electric] = normallyEffective;
    typeMatchups[fighting][fairy]       = notVeryEffective;
    // typeMatchups[fighting][fighting] = normallyEffective;
    // typeMatchups[fighting][fire]     = normallyEffective;
    typeMatchups[fighting][flying]      = notVeryEffective;
    typeMatchups[fighting][ghost]       = noEffect;
    // typeMatchups[fighting][grass]    = normallyEffective;
    // typeMatchups[fighting][ground]   = normallyEffective;
    typeMatchups[fighting][ice]         = superEffective;
    typeMatchups[fighting][norm]        = superEffective;
    typeMatchups[fighting][poison]      = notVeryEffective;
    typeMatchups[fighting][psychic]     = notVeryEffective;
    typeMatchups[fighting][rock]        = superEffective;
    typeMatchups[fighting][steel]       = superEffective;
    // typeMatchups[fighting][water]    = normallyEffective;

    // Fire attack type
    typeMatchups[fire][bug]         = superEffective;
    // typeMatchups[fire][dark]     = normallyEffective;
    typeMatchups[fire][dragon]      = notVeryEffective;
    // typeMatchups[fire][electric] = normallyEffective;
    // typeMatchups[fire][fairy]    = normallyEffective;
    // typeMatchups[fire][fighting] = normallyEffective;
    typeMatchups[fire][fire]        = notVeryEffective;
    // typeMatchups[fire][flying]   = normallyEffective;
    // typeMatchups[fire][ghost]    = normallyEffective;
    typeMatchups[fire][grass]       = superEffective;
    // typeMatchups[fire][ground]   = normallyEffective;
    typeMatchups[fire][ice]         = superEffective;
    // typeMatchups[fire][norm]     = normallyEffective;
    // typeMatchups[fire][poison]   = normallyEffective;
    // typeMatchups[fire][psychic]  = normallyEffective;
    typeMatchups[fire][rock]        = notVeryEffective;
    typeMatchups[fire][steel]       = superEffective;
    typeMatchups[fire][water]       = notVeryEffective;

    // Flying attack type
    typeMatchups[flying][bug]         = superEffective;
    // typeMatchups[flying][dark]     = normallyEffective;
    // typeMatchups[flying][dragon]   = normallyEffective;
    typeMatchups[flying][electric]    = notVeryEffective;
    // typeMatchups[flying][fairy]    = normallyEffective;
    typeMatchups[flying][fighting]    = superEffective;
    // typeMatchups[flying][fire]     = normallyEffective;
    // typeMatchups[flying][flying]   = normallyEffective;
    // typeMatchups[flying][ghost]    = normallyEffective;
    typeMatchups[flying][grass]       = superEffective;
    // typeMatchups[flying][ground]   = normallyEffective;
    // typeMatchups[flying][ice]      = normallyEffective;
    // typeMatchups[flying][norm]     = normallyEffective;
    // typeMatchups[flying][poison]   = normallyEffective;
    // typeMatchups[flying][psychic]  = normallyEffective;
    typeMatchups[flying][rock]        = notVeryEffective;
    typeMatchups[flying][steel]       = notVeryEffective;
    // typeMatchups[flying][water]    = normallyEffective;

    // Ghost attack type
    // typeMatchups[ghost][bug]      = normallyEffective;
    typeMatchups[ghost][dark]        = notVeryEffective;
    // typeMatchups[ghost][dragon]   = normallyEffective;
    // typeMatchups[ghost][electric] = normallyEffective;
    // typeMatchups[ghost][fairy]    = normallyEffective;
    // typeMatchups[ghost][fighting] = normallyEffective;
    // typeMatchups[ghost][fire]     = normallyEffective;
    // typeMatchups[ghost][flying]   = normallyEffective;
    typeMatchups[ghost][ghost]       = superEffective;
    // typeMatchups[ghost][grass]    = normallyEffective;
    // typeMatchups[ghost][ground]   = normallyEffective;
    // typeMatchups[ghost][ice]      = normallyEffective;
    typeMatchups[ghost][norm]        = noEffect;
    // typeMatchups[ghost][poison]   = normallyEffective;
    typeMatchups[ghost][psychic]     = superEffective;
    // typeMatchups[ghost][rock]     = normallyEffective;
    // typeMatchups[ghost][steel]    = normallyEffective;
    // typeMatchups[ghost][water]    = normallyEffective;

    // Grass attack type
    typeMatchups[grass][bug]         = notVeryEffective;
    // typeMatchups[grass][dark]     = normallyEffective;
    typeMatchups[grass][dragon]      = notVeryEffective;
    // typeMatchups[grass][electric] = normallyEffective;
    // typeMatchups[grass][fairy]    = normallyEffective;
    // typeMatchups[grass][fighting] = normallyEffective;
    typeMatchups[grass][fire]        = notVeryEffective;
    typeMatchups[grass][flying]      = notVeryEffective;
    // typeMatchups[grass][ghost]    = normallyEffective;
    typeMatchups[grass][grass]       = notVeryEffective;
    typeMatchups[grass][ground]      = superEffective;
    // typeMatchups[grass][ice]      = normallyEffective;
    // typeMatchups[grass][norm]     = normallyEffective;
    typeMatchups[grass][poison]      = notVeryEffective;
    // typeMatchups[grass][psychic]  = normallyEffective;
    typeMatchups[grass][rock]        = superEffective;
    typeMatchups[grass][steel]       = notVeryEffective;
    typeMatchups[grass][water]       = superEffective;

    // Ground attack type
    typeMatchups[ground][bug]         = notVeryEffective;
    // typeMatchups[ground][dark]     = normallyEffective;
    // typeMatchups[ground][dragon]   = normallyEffective;
    typeMatchups[ground][electric]    = superEffective;
    // typeMatchups[ground][fairy]    = normallyEffective;
    // typeMatchups[ground][fighting] = normallyEffective;
    typeMatchups[ground][fire]        = superEffective;
    typeMatchups[ground][flying]      = noEffect;
    // typeMatchups[ground][ghost]    = normallyEffective;
    typeMatchups[ground][grass]       = notVeryEffective;
    // typeMatchups[ground][ground]   = normallyEffective;
    // typeMatchups[ground][ice]      = normallyEffective;
    // typeMatchups[ground][norm]     = normallyEffective;
    typeMatchups[ground][poison]      = superEffective;
    // typeMatchups[ground][psychic]  = normallyEffective;
    typeMatchups[ground][rock]        = superEffective;
    typeMatchups[ground][steel]       = superEffective;
    // typeMatchups[ground][water]    = normallyEffective;

    // Ice attack type
    // typeMatchups[ice][bug]      = normallyEffective;
    // typeMatchups[ice][dark]     = normallyEffective;
    typeMatchups[ice][dragon]      = superEffective;
    // typeMatchups[ice][electric] = normallyEffective;
    // typeMatchups[ice][fairy]    = normallyEffective;
    // typeMatchups[ice][fighting] = normallyEffective;
    typeMatchups[ice][fire]        = notVeryEffective;
    typeMatchups[ice][flying]      = superEffective;
    // typeMatchups[ice][ghost]    = normallyEffective;
    typeMatchups[ice][grass]       = superEffective;
    typeMatchups[ice][ground]      = superEffective;
    typeMatchups[ice][ice]         = notVeryEffective;
    // typeMatchups[ice][norm]     = normallyEffective;
    // typeMatchups[ice][poison]   = normallyEffective;
    // typeMatchups[ice][psychic]  = normallyEffective;
    // typeMatchups[ice][rock]     = normallyEffective;
    typeMatchups[ice][steel]       = notVeryEffective;
    typeMatchups[ice][water]       = notVeryEffective;

    // Normal attack type
    // typeMatchups[norm][bug]      = normallyEffective;
    // typeMatchups[norm][dark]     = normallyEffective;
    // typeMatchups[norm][dragon]   = normallyEffective;
    // typeMatchups[norm][electric] = normallyEffective;
    // typeMatchups[norm][fairy]    = normallyEffective;
    // typeMatchups[norm][fighting] = normallyEffective;
    // typeMatchups[norm][fire]     = normallyEffective;
    // typeMatchups[norm][flying]   = normallyEffective;
    typeMatchups[norm][ghost]       = noEffect;
    // typeMatchups[norm][grass]    = normallyEffective;
    // typeMatchups[norm][ground]   = normallyEffective;
    // typeMatchups[norm][ice]      = normallyEffective;
    // typeMatchups[norm][norm]     = normallyEffective;
    // typeMatchups[norm][poison]   = normallyEffective;
    // typeMatchups[norm][psychic]  = normallyEffective;
    typeMatchups[norm][rock]        = notVeryEffective;
    typeMatchups[norm][steel]       = notVeryEffective;
    // typeMatchups[norm][water]    = normallyEffective;

    // Poison attack type
    // typeMatchups[poison][bug]      = normallyEffective;
    // typeMatchups[poison][dark]     = normallyEffective;
    // typeMatchups[poison][dragon]   = normallyEffective;
    // typeMatchups[poison][electric] = normallyEffective;
    typeMatchups[poison][fairy]       = superEffective;
    // typeMatchups[poison][fighting] = normallyEffective;
    // typeMatchups[poison][fire]     = normallyEffective;
    // typeMatchups[poison][flying]   = normallyEffective;
    typeMatchups[poison][ghost]       = notVeryEffective;
    typeMatchups[poison][grass]       = superEffective;
    typeMatchups[poison][ground]      = notVeryEffective;
    // typeMatchups[poison][ice]      = normallyEffective;
    // typeMatchups[poison][norm]     = normallyEffective;
    typeMatchups[poison][poison]      = notVeryEffective;
    // typeMatchups[poison][psychic]  = normallyEffective;
    typeMatchups[poison][rock]        = notVeryEffective;
    typeMatchups[poison][steel]       = noEffect;
    // typeMatchups[poison][water]    = normallyEffective;

    // Psychic attack type
    // typeMatchups[psychic][bug]      = normallyEffective;
    typeMatchups[psychic][dark]        = notVeryEffective;
    // typeMatchups[psychic][dragon]   = normallyEffective;
    // typeMatchups[psychic][electric] = normallyEffective;
    // typeMatchups[psychic][fairy]    = normallyEffective;
    typeMatchups[psychic][fighting]    = superEffective;
    // typeMatchups[psychic][fire]     = normallyEffective;
    // typeMatchups[psychic][flying]   = normallyEffective;
    // typeMatchups[psychic][ghost]    = normallyEffective;
    // typeMatchups[psychic][grass]    = normallyEffective;
    // typeMatchups[psychic][ground]   = normallyEffective;
    // typeMatchups[psychic][ice]      = normallyEffective;
    // typeMatchups[psychic][norm]     = normallyEffective;
    typeMatchups[psychic][poison]      = superEffective;
    typeMatchups[psychic][psychic]     = notVeryEffective;
    // typeMatchups[psychic][rock]     = normallyEffective;
    typeMatchups[psychic][steel]       = notVeryEffective;
    // typeMatchups[psychic][water]    = normallyEffective;

    // Rock attack type
    typeMatchups[rock][bug]         = superEffective;
    // typeMatchups[rock][dark]     = normallyEffective;
    // typeMatchups[rock][dragon]   = normallyEffective;
    // typeMatchups[rock][electric] = normallyEffective;
    // typeMatchups[rock][fairy]    = normallyEffective;
    typeMatchups[rock][fighting]    = notVeryEffective;
    typeMatchups[rock][fire]        = superEffective;
    typeMatchups[rock][flying]      = superEffective;
    // typeMatchups[rock][ghost]    = normallyEffective;
    // typeMatchups[rock][grass]    = normallyEffective;
    typeMatchups[rock][ground]      = notVeryEffective;
    typeMatchups[rock][ice]         = superEffective;
    // typeMatchups[rock][norm]     = normallyEffective;
    // typeMatchups[rock][poison]   = normallyEffective;
    // typeMatchups[rock][psychic]  = normallyEffective;
    // typeMatchups[rock][rock]     = normallyEffective;
    typeMatchups[rock][steel]       = notVeryEffective;
    // typeMatchups[rock][water]    = normallyEffective;

    // Steel attack type
    // typeMatchups[steel][bug]      = normallyEffective;
    // typeMatchups[steel][dark]     = normallyEffective;
    // typeMatchups[steel][dragon]   = normallyEffective;
    typeMatchups[steel][electric]    = notVeryEffective;
    typeMatchups[steel][fairy]       = superEffective;
    // typeMatchups[steel][fighting] = normallyEffective;
    typeMatchups[steel][fire]        = notVeryEffective;
    // typeMatchups[steel][flying]   = normallyEffective;
    // typeMatchups[steel][ghost]    = normallyEffective;
    // typeMatchups[steel][grass]    = normallyEffective;
    // typeMatchups[steel][ground]   = normallyEffective;
    typeMatchups[steel][ice]         = superEffective;
    // typeMatchups[steel][norm]     = normallyEffective;
    // typeMatchups[steel][poison]   = normallyEffective;
    // typeMatchups[steel][psychic]  = normallyEffective;
    typeMatchups[steel][rock]        = superEffective;
    typeMatchups[steel][steel]       = notVeryEffective;
    typeMatchups[steel][water]       = notVeryEffective;

    // Water attack type
    // typeMatchups[water][bug]      = normallyEffective;
    // typeMatchups[water][dark]     = normallyEffective;
    typeMatchups[water][dragon]      = notVeryEffective;
    // typeMatchups[water][electric] = normallyEffective;
    // typeMatchups[water][fairy]    = normallyEffective;
    // typeMatchups[water][fighting] = normallyEffective;
    typeMatchups[water][fire]        = superEffective;
    // typeMatchups[water][flying]   = normallyEffective;
    // typeMatchups[water][ghost]    = normallyEffective;
    typeMatchups[water][grass]       = notVeryEffective;
    typeMatchups[water][ground]      = superEffective;
    // typeMatchups[water][ice]      = normallyEffective;
    // typeMatchups[water][norm]     = normallyEffective;
    // typeMatchups[water][poison]   = normallyEffective;
    // typeMatchups[water][psychic]  = normallyEffective;
    typeMatchups[water][rock]        = superEffective;
    // typeMatchups[water][steel]    = normallyEffective;
    typeMatchups[water][water]       = notVeryEffective;
}

+ (void)initializeReds:(CGFloat[18])reds greens:(CGFloat[18])greens blues:(CGFloat[18])blues {

    reds[bug] = 184/255.0;
    greens[bug] = 202/255.0;
    blues[bug] = 32/255.0;

    reds[dark] = 130/255.0;
    greens[dark] = 105/255.0;
    blues[dark] = 89/255.0;

    reds[dragon] = 112/255.0;
    greens[dragon] = 56/255.0;
    blues[dragon] = 248/255.0;

    reds[electric] = 248/255.0;
    greens[electric] = 208/255.0;
    blues[electric] = 48/255.0;

    reds[fairy] = 255/255.0;
    greens[fairy] = 200/255.0;
    blues[fairy] = 255/255.0;

    reds[fighting] = 192/255.0;
    greens[fighting] = 48/255.0;
    blues[fighting] = 40/255.0;

    reds[fire] = 240/255.0;
    greens[fire] = 128/255.0;
    blues[fire] = 48/255.0;

    reds[flying] = 179/255.0;
    greens[flying] = 157/255.0;
    blues[flying] = 247/255.0;

    reds[ghost] = 128/255.0;
    greens[ghost] = 104/255.0;
    blues[ghost] = 169/255.0;

    reds[grass] = 80/255.0;
    greens[grass] = 184/255.0;
    blues[grass] = 59/255.0;

    reds[ground] = 224/255.0;
    greens[ground] = 189/255.0;
    blues[ground] = 104/255.0;

    reds[ice] = 152/255.0;
    greens[ice] = 216/255.0;
    blues[ice] = 216/255.0;

    reds[norm] = 193/255.0;
    greens[norm] = 193/255.0;
    blues[norm] = 167/255.0;

    reds[poison] = 160/255.0;
    greens[poison] = 64/255.0;
    blues[poison] = 160/255.0;

    reds[psychic] = 248/255.0;
    greens[psychic] = 88/255.0;
    blues[psychic] = 136/255.0;

    reds[rock] = 192/255.0;
    greens[rock] = 145/255.0;
    blues[rock] = 64/255.0;

    reds[steel] = 186/255.0;
    greens[steel] = 186/255.0;
    blues[steel] = 191/255.0;

    reds[water] = 104/255.0;
    greens[water] = 144/255.0;
    blues[water] = 240/255.0;
}

@end
