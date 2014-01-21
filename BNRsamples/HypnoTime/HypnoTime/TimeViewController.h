//
//  TimeViewController.h
//  HypnoTime
//
//  Created by Admin on 12/24/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeViewController : UIViewController {

    IBOutlet UILabel *timeLabel;
}

- (IBAction)showCurrentTime:(id)sender;

@end
