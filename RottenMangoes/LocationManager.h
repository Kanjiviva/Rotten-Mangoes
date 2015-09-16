//
//  LocationManager.h
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

#define sharedLocationManager [LocationManager sharedManager]

@interface LocationManager : NSObject

+ (instancetype)sharedManager;


@end
