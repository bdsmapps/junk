//
//  MPCRViewController.m
//  mpcremote
//
//  Created by Bohdan Likhyy on 1/25/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRViewController.h"

@interface MPCRViewController ()

@end

@implementation MPCRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testConnection:(id)sender {
   
    MPCRHost *host = [[MPCRHost alloc] init];
    [host setHostIPString:[hostIP text]];
    [host setHostPort:[hostPort text]];
    NSString *command = [NSString stringWithFormat:@"%u", [sender tag]];
    [host remoteCommand:command];

}
@end
