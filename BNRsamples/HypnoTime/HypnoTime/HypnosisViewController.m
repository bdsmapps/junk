//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Admin on 12/23/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import "HypnosisViewController.h"
#import "BNRHypnosisView.h"

@implementation HypnosisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Hypnosis"];
        
    }
    return self;
    
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    BNRHypnosisView *v = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    [self setView:v];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hypnosis loaded");
}

@end
