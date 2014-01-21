//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Admin on 12/16/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject <MKAnnotation> {
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

@end
