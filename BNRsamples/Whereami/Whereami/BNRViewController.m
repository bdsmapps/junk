//
//  BNRViewController.m
//  Whereami
//
//  Created by Admin on 12/13/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import "BNRViewController.h"
#import "BNRMapPoint.h"

@interface BNRViewController ()

@end

@implementation BNRViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Init with bundle");
    }
    return self;
}*/


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"Init with coder");
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDistanceFilter:50];
        //[locationManager startUpdatingLocation];
        //[locationManager setHeadingFilter:kCLHeadingFilterNone];
        //[locationManager setHeadingOrientation:CLDeviceOrientationPortrait];
        //[locationManager startUpdatingHeading];
    }
    return self;
}

- (void)findLocation {
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc {
    CLLocationCoordinate2D coord = [loc coordinate];
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    [worldView addAnnotation:mp];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

    NSLog(@"%@", newLocation);
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    if (t < -180) {
        return;
    }
    
    [self foundLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSLog(@"Could not find location: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading {

    NSLog(@"The heading is changed: %@", newHeading);
}

- (void)viewDidLoad {
    NSLog(@"view is loaded");
    [worldView setShowsUserLocation:YES];
    [worldView setUserTrackingMode:YES animated:YES];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"updated");
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
    //[worldView setShowsUserLocation:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}


- (void)dealloc {

    [locationManager setDelegate:nil];
}



@end
