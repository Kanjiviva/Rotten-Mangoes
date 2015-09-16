//
//  ViewController.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-14.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "CustomCollectionViewCell.h"
#import "DetailViewController.h"

@interface ViewController () <NSURLSessionDataDelegate, NSURLSessionDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

#pragma mark - Life Cycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movies = [NSMutableArray new];
    
    [self getInitialData];
    
    
}

#pragma mark - Helper Methods -

- (void)getInitialData {
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=40";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
                        NSLog(@"%@", jsonDict);
            
            NSArray *allMovies = [jsonDict objectForKey:@"movies"];
            
                        NSLog(@"%@", allMovies);
            
            for (NSDictionary *eachMovie in allMovies) {
                
                NSString *title = [eachMovie objectForKey:@"title"];
                
                NSNumber *year = [eachMovie objectForKey:@"year"];
                
                NSDictionary *poster = [eachMovie objectForKey:@"posters"];
                NSString *originalThumbnail = [poster objectForKey:@"thumbnail"];
                NSURL *thumbnail = [NSURL URLWithString:[poster objectForKey:@"thumbnail"]];
                NSString *newThumbnail = [NSString stringWithFormat:@"http://%@", [originalThumbnail substringFromIndex:([originalThumbnail rangeOfString:@"dkpu1ddg7pbsk.cloudfront.net"].location)]];
                NSURL *highResThumbnail = [NSURL URLWithString:newThumbnail];
                
                NSDictionary *links = [eachMovie objectForKey:@"links"];
                NSString *website = [links objectForKey:@"alternate"];

                
                NSString *synopsis = [eachMovie objectForKey:@"synopsis"];
                
                NSString *reviewString = [[links objectForKey:@"reviews"] stringByAppendingString:@"?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=3"];
                
                Movie *movie = [[Movie alloc] initWithTitle:title thumbnail:thumbnail synopsis:synopsis highResThumbnail:highResThumbnail year:year website:website reviewURL:reviewString];
                
                [self.movies addObject:movie];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
        
        
    }];
    
    [dataTask resume];
}

#pragma mark - UICollectionView Datasource -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Movie *movie = self.movies[indexPath.item];
    cell.object = movie;
    cell.tag = (int)movie.highResThumbnail;
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detailView"]) {
        
        DetailViewController *detailVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        
        detailVC.movie = self.movies[indexPath.row];
        
    }
    
}

@end
