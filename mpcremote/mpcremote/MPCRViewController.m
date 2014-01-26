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
    NSString *bodyData = @"wm_command=887";
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.101:13579/command.html"]];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self];
    if (conn) {
        NSLog(@"wohooo!!!");
    }
    
    NSString *host = [hostIP text];
    NSLog(@"it works: %@", host);
}
@end
