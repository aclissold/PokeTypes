//
//  PokeBallFactory.h
//  Types
//
//  PokeBallFactory, named after the Poké Ball Factory in the Kalos region, is a factory method for arrays and dictionaries required by the other classes that have a large amount of hard-coded values.
//  Created by Andrew Clissold on 11/3/13.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

#import <Foundation/Foundation.h>

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

enum effectiveness {
    normallyEffective,
    noEffect,
    notVeryEffective,
    superEffective,
    superSuperEffective
};

@interface PokeBallFactory : NSObject

+ (NSArray *) initializeTypesArray;
+ (void) initializeTypeMatchups:(int[18][18]) typeMatchups;
+ (void) initializeReds:(CGFloat[18])reds greens:(CGFloat[18])greens blues:(CGFloat[18])blues;

@end
