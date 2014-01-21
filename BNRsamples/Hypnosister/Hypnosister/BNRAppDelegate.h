//
//  BNRAppDelegate.h
//  Hypnosister
//
//  Created by Admin on 12/17/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRHypnosisView.h"

@interface BNRAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate> {

    BNRHypnosisView *view;
}

@property (strong, nonatomic) UIWindow *window;

@end
