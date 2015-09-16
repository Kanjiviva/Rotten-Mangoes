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
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;

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
    
    NSURL *thumbnailURL = self.object.thumbnail;
    
    
    if (self.downloadTask){
        [self.downloadTask suspend];
        [self.downloadTask cancel];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.downloadTask = [session downloadTaskWithURL:self.object.thumbnail completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *dataURL = [NSData dataWithContentsOfURL:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([thumbnailURL isEqual:self.object.thumbnail]) {
                self.displayImage.image = [UIImage imageWithData:dataURL];
            }
            
        });
        
    }];
    [self.downloadTask resume];
}

@end
