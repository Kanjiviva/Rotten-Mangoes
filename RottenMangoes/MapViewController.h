//
//  MapViewController.h
//  RottenMangoes
//
//  Created by Steve on 2015-09-15.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Movie.h"


@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic) Movie *movie;

@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
