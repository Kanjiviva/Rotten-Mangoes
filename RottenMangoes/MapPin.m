//
//  MapPin.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle
{
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
        _title = aTitle;
        _subtitle = aSubtitle;
    }
    return self;
}

@end
