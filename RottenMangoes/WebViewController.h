//
//  WebViewController.h
//  RottenMangoes
//
//  Created by Steve on 2015-09-14.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic) Movie *movie;

@end
