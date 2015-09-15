//
//  Review.h
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic) NSString *date;
@property (nonatomic) NSString *publication;
@property (nonatomic) NSString *quote;

- (instancetype)initWithDate:(NSString *)date pulication:(NSString *)publication quote:(NSString *)quote;

@end
