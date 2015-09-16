//
//  Theater.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "Theatre.h"

@implementation Theatre

- (instancetype)initWithName:(NSString *)name address:(NSString *)address lat:(NSNumber *)lat lng:(NSNumber *)lng distance:(double)distance
{
    self = [super init];
    if (self) {
        
        _distance = distance;
        _name = name;
        _address = address;
        _lat = lat;
        _lng = lng;
        
    }
    return self;
}

@end
