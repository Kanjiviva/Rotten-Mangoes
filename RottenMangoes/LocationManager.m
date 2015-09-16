//
//  LocationManager.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (instancetype)sharedManager {
    static LocationManager *_sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMyManager = [self new];
    });
    return _sharedMyManager;
}

@end
