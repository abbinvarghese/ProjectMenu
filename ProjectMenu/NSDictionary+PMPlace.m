//
//  NSDictionary+PMPlace.m
//  ProjectMenu
//
//  Created by Abbin Varghese on 15/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "NSDictionary+PMPlace.h"

@implementation NSMutableDictionary (PMPlace)

-(instancetype)initWithPlace:(NSDictionary*)place{
    self = [self init];
    if (self) {
        @try {
            [self setObject:place[@"geometry"][@"location"][@"lat"] forKey:@"lat"];
        } @catch (NSException *exception) {
            [self setObject:@"" forKey:@"lat"];
        }
        @try {
            [self setObject:place[@"geometry"][@"location"][@"lng"] forKey:@"lng"];
        } @catch (NSException *exception) {
            [self setObject:@"" forKey:@"lng"];
        }
        @try {
            [self setObject:place[@"name"] forKey:@"name"];
        } @catch (NSException *exception) {
            [self setObject:@"" forKey:@"name"];
        }
        @try {
            [self setObject:place[@"place_id"] forKey:@"place_id"];
        } @catch (NSException *exception) {
            [self setObject:@"" forKey:@"place_id"];
        }
        @try {
            [self setObject:place[@"formatted_address"] forKey:@"formatted_address"];
        } @catch (NSException *exception) {
            [self setObject:@"" forKey:@"formatted_address"];
        }
    }
    return self;
}

@end
