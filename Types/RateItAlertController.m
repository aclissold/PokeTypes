//
//  RateItAlertController.m
//  Types
//
//  Created by Andrew Clissold on 6/22/15.
//  Copyright (c) 2015 Andrew Clissold. All rights reserved.
//

#import "RateItAlertController.h"

@interface RateItAlertController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSString *currentVersion;

@end

@implementation RateItAlertController

static NSString * const lastRatedVersionKey = @"lastRatedVersion";
static NSString * const tappedNoThanksKey = @"tappedNoThanks";
static NSString * const setRemindMeDateKey = @"setShouldRemindDate";
static NSString * const installDateKey = @"installDate";
static NSString * const appStoreURL = @"itms-apps://itunes.apple.com/app/id784727885";

static const NSTimeInterval twoDays = 60*60*24*2;

- (nonnull instancetype)init {
    self = [super init];
    self.currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    return self;
}

- (BOOL)didRateThisVersion {
    NSString *lastRatedVersion = [[NSUserDefaults standardUserDefaults] stringForKey:lastRatedVersionKey];
    if (lastRatedVersion == nil) {
        return NO;
    }

    return [lastRatedVersion isEqualToString:self.currentVersion];
}

- (void)showRateItAlertIfNecessary {
    BOOL ratedIt = [self didRateThisVersion];
    BOOL tappedNoThanks = [[NSUserDefaults standardUserDefaults] boolForKey:tappedNoThanksKey];
    if (ratedIt || tappedNoThanks) {
        return;
    }

    NSDate *installDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:installDateKey];
    if (installDate == nil) {
        // First run.
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:installDateKey];
        return;
    }

    NSDate *setRemindMeDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:setRemindMeDateKey];

    NSTimeInterval timeIntervalSinceInstall = [[NSDate date] timeIntervalSinceDate:installDate];
    NSTimeInterval timeIntervalSinceSetRemindMe = 0;
    if (setRemindMeDate != nil) {
        timeIntervalSinceSetRemindMe = [[NSDate date] timeIntervalSinceDate:setRemindMeDate];
    }

    if (setRemindMeDate != nil && timeIntervalSinceSetRemindMe > twoDays) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:setRemindMeDateKey];
        [self showRateItAlert];
    } else if (setRemindMeDate == nil && timeIntervalSinceInstall > twoDays) {
        [self showRateItAlert];
    } else {
        // It hasn't been two days since first run or "Remind Me Later" was tapped yet.
    }
}

- (void)showRateItAlert {
    NSString *title = NSLocalizedString(@"Love Types?",
                                        @"App Store rating alert view title");
    NSString *message = NSLocalizedString(@"If you enjoy using Types, I’d really appreciate it if you left a rating or wrote me a review in the App Store! 😀",
                                          @"App Store rating alert view message");

    NSString *noThanks = NSLocalizedString(@"No Thanks", @"App Store rating alert view dismiss forever button");
    NSString *rateIt = NSLocalizedString(@"Rate It!", @"App Store rating alert view jump to App Store button");
    NSString *remindMeLater = NSLocalizedString(@"Remind Me Later", @"App Store rating alert view remind me button");

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:noThanks
                                              otherButtonTitles:rateIt, remindMeLater, nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:tappedNoThanksKey];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:self.currentVersion forKey:lastRatedVersionKey];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreURL]];
            break;
        case 2:
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:setRemindMeDateKey];
            break;
        default:
            NSLog(@"error: unexpected alert view button index: %ld", (long)buttonIndex);
            break;
    }
}

@end
