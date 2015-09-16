//
//  DetailViewController.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-14.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "Review.h"
#import "MapViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *highResImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet UILabel *reviewDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pulicationLabel;

@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;

@property (nonatomic) NSMutableArray *reviews;
@property (nonatomic) Review *review;


//@property (nonatomic) NSMutableArray *reviews;

@end

#pragma mark - Life Cycle -

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reviews = [[NSMutableArray alloc] init];
    
    [self getReviewData];
    
    self.titleLabel.text = self.movie.title;
    self.yearLabel.text = [NSString stringWithFormat:@"%@",self.movie.year];
    self.highResImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.movie.highResThumbnail]];
    self.detailLabel.text = self.movie.synopsis;
    
    
}

#pragma mark - Helper Method -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showWebsite"]) {
        WebViewController *webVC = segue.destinationViewController;
        
        webVC.movie = self.movie;
        
    } else if ([segue.identifier isEqualToString:@"showMap"]){
        
        MapViewController *mapVC = segue.destinationViewController;
        
        mapVC.movie = self.movie;
        
    }
}

- (void)getReviewData {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSLog(@"review URL: %@", self.movie.reviewURL);
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.movie.reviewURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

            NSArray *allReviews = [jsonDict objectForKey:@"reviews"];
            
            for (NSDictionary *eachReview in allReviews) {
                
                NSString *date = [eachReview objectForKey:@"date"];
                
                NSString *publication = [eachReview objectForKey:@"publication"];
                
                NSString *quote = [eachReview objectForKey:@"quote"];
                
                self.review = [[Review alloc] initWithDate:date pulication:publication quote:quote];
                
                [self.reviews addObject:self.review];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.reviewDateLabel.text = self.review.date;
                self.pulicationLabel.text = self.review.publication;
                self.quoteLabel.text = self.review.quote;
            });
        }
        
        
    }];
    
    [dataTask resume];

}

@end
