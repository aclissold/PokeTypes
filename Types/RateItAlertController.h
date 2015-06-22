//
//  RateItAlertController.h
//  Types
//
//  Created by Andrew Clissold on 6/22/15.
//  Copyright (c) 2015 Andrew Clissold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RateItAlertController : NSObject

// Show a prompt to rate the app on the App Store if
//   1. they haven't yet decided whether or not to rate it,
//   2. it's been at least two days since they first opened the app, or
//   3. it's been at least two days since they tapped "Remind Me Later."
// Therefore, it's safe to call this method as frequently as necessary, such as in viewDidAppear:.
- (void)showRateItAlertIfNecessary;

@end
