//
//  BNRViewController.h
//  Whereami
//
//  Created by Admin on 12/13/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRViewController : UIViewController  <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>{
    CLLocationManager *locationManager;
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}

- (void)findLocation;
- (void)foundLocation: (CLLocation *)loc;

@end
