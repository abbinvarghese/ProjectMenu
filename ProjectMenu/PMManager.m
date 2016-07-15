//
//  PMManager.m
//  ProjectMenu
//
//  Created by Abbin Varghese on 15/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PMManager.h"
#import "PMConstants.h"

@implementation PMManager

+(BOOL)isFirstLaunch{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:kPMFirstLaunchKey]) {
        return YES;
    }
    else{
        return NO;
    }
}

+(BOOL)isUserLocationSet{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPMUserLocationKey]) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
