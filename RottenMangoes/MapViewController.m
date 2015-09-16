//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "MapViewController.h"
#import "Theatre.h"
#import "MapPin.h"
#import "TableViewCell.h"

@interface MapViewController () <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSString *searchItem;
@property (nonatomic) NSMutableArray *theatres;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MapViewController

#pragma mark - Life Cycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mapView setDelegate:self];
    
    self.theatres = [NSMutableArray new];
    
    [self setUpLocation];
}

#pragma mark - Helper Methods -

- (void)setUpLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation; // 100 m
    
    self.mapView.showsUserLocation = YES;
    [_locationManager requestWhenInUseAuthorization];
    
    [_locationManager startUpdatingLocation];
    
    [self zoomInLocation];
}

- (void)startLocationManager{
    if ([CLLocationManager locationServicesEnabled]) {
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
            [self setUpLocation];
            
        }else if (!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)){
            [self setUpLocation];
            
        }else{
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Location services are disabled, Please go into Settings > Privacy > Location to enable them for Play"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"Ok", nil];
            [alertView show];
            
        }
    }
}

- (void)currentPostalCode {
    
    // Reverse Geocorder to get the user current location postal code
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *postalCode = [[NSString alloc]initWithString:placemark.postalCode];
             NSLog(@"Postal code is: %@",postalCode);
             
             
             NSString *stringURL = [NSString stringWithFormat:@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=%@&movie=%@", postalCode, self.movie.title];
             
             self.searchItem = [stringURL stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding];
             
             [self jsonRequest:self.searchItem];
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             
         });
     }];
}

#pragma mark - Location Manager Delegate -

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    self.currentLocation = [locations objectAtIndex:0];
//    [self.locationManager stopUpdatingLocation];
    
    
    [self currentPostalCode];

}

- (void)zoomInLocation {
    
    NSLog(@"Zoom - IN");
    MKCoordinateRegion region;
    //Set Zoom level using Span
    MKCoordinateSpan span;
    
    region.center.latitude = _locationManager.location.coordinate.latitude;
    region.center.longitude = _locationManager.location.coordinate.longitude;
    
    span.latitudeDelta=_mapView.region.span.latitudeDelta / 20000;
    span.longitudeDelta=_mapView.region.span.longitudeDelta / 20000;
    region.span=span;
    [self.mapView setRegion:region animated:YES];
    
}

#pragma mark - NSURLSession -

- (void) jsonRequest:(NSString *)searchString {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:searchString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *allTheatres = [jsonDict objectForKey:@"theatres"];
            
            for (NSDictionary *eachTheatre in allTheatres) {
                
                NSString *name = [eachTheatre objectForKey:@"name"];
                
                NSString *address = [eachTheatre objectForKey:@"address"];
                
                NSNumber *lat = [eachTheatre objectForKey:@"lat"];
                
                NSNumber *lng = [eachTheatre objectForKey:@"lng"];
                
                CLLocation *theatreLocation = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
                
                double distance = [self.currentLocation distanceFromLocation:theatreLocation];
                
                Theatre *theatre = [[Theatre alloc] initWithName:name address:address lat:lat lng:lng distance:distance];
                
                MapPin *mapPin = [[MapPin alloc] initWithCoordinate:CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]) andTitle:name andSubtitle:address];
                
                [self.theatres addObject:theatre];
                
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [self.mapView addAnnotation:mapPin];
                    
                    [self.tableView reloadData];
                });
                
                
                
            }
        } else {
            NSLog(@"ERORRORORORORORO!!!! %@",error.localizedDescription);
        }
        
        
    }];
    
    [dataTask resume];
    
}
//-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view

#pragma mark - Tableview datasource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.theatres count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    

    Theatre *theatre = self.theatres[indexPath.row];
        
    cell.theatreTitleLabel.text = theatre.name;
    
    return cell;
}
@end
