//
//  Movie.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-14.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSURL *)thumbnail synopsis:(NSString *)synopsis highResThumbnail:(NSURL *)highResThumbnail year:(NSNumber *)year website:(NSString *)website reviewURL:(NSString *)reviewURL
{
    self = [super init];
    if (self) {
        
        _reviewURL = reviewURL;
        _website = website;
        _year = year;
        _title = title;
        _thumbnail = thumbnail;
        _synopsis = synopsis;
        _highResThumbnail = highResThumbnail;
    }
    return self;
}

@end
