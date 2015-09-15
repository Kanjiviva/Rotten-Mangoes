//
//  Movie.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-14.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSURL *)thumbnail criticsScore:(NSNumber *)criticsScore audienceScore:(NSNumber *)audienceScore synopsis:(NSString *)synopsis highResThumbnail:(NSURL *)highResThumbnail year:(NSNumber *)year website:(NSString *)website
{
    self = [super init];
    if (self) {
        
        _website = website;
        _year = year;
        _title = title;
        _thumbnail = thumbnail;
        _criticsScore = criticsScore;
        _audienceScore = audienceScore;
        _synopsis = synopsis;
        _highResThumbnail = highResThumbnail;
    }
    return self;
}

@end
