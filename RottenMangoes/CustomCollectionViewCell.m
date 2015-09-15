//
//  CustomCollectionViewCell.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-14.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;

@end

@implementation CustomCollectionViewCell

#pragma mark - Accessors -

- (void)setObject:(Movie *)object {
    _object = object;
    
    [self setup];
}

#pragma mark - General Method -

- (void)setup {
    
    self.displayImage.image = nil;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:self.object.thumbnail completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *dataURL = [NSData dataWithContentsOfURL:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.tag == (int)self.object.thumbnail) {
                self.displayImage.image = [UIImage imageWithData:dataURL];
//                NSLog(@"high res image : %@", self.object.highResThumbnail);
            }
            
        });
        
    }];
    [downloadTask resume];
}

@end
