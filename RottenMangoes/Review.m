//
//  Review.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "Review.h"

@implementation Review

- (instancetype)initWithDate:(NSString *)date pulication:(NSString *)publication quote:(NSString *)quote
{
    self = [super init];
    if (self) {
        
        _date = date;
        _publication = publication;
        _quote = quote;
        
        
    }
    return self;
}

@end
