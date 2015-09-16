//
//  Theater.h
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theatre : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) NSNumber *lat;
@property (nonatomic) NSNumber *lng;
@property (nonatomic) double distance;

- (instancetype)initWithName:(NSString *)name address:(NSString *)address lat:(NSNumber *)lat lng:(NSNumber *)lng distance:(double)distance;

@end
