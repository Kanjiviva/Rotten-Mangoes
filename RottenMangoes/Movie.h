//
//  Movie.h
//  RottenMangoes
//
//  Created by Steve on 2015-09-14.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *thumbnail;
@property (strong, nonatomic) NSString *synopsis;
@property (strong, nonatomic) NSNumber *year;
@property (strong, nonatomic) NSURL *highResThumbnail;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSString *reviewURL;


- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSURL *)thumbnail synopsis:(NSString *)synopsis highResThumbnail:(NSURL *)highResThumbnail year:(NSNumber *)year website:(NSString *)website reviewURL:(NSString *)reviewURL;

@end
