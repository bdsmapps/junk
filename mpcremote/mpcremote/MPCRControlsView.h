//
//  MPCRControlsView.h
//  mpcremote
//
//  Created by Admin on 1/27/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPCRHost;

@interface MPCRControlsView : UIViewController <UIAlertViewDelegate>
{
    __weak IBOutlet UISlider *volume;
    __weak IBOutlet UILabel *volumeLabel;
    __weak IBOutlet UIActivityIndicatorView *loadIndicator;
    __weak IBOutlet UIButton *playButton;
    
    __weak IBOutlet UIButton *pauseButton;
}

@property (nonatomic, strong) MPCRHost *host;

- (IBAction)remoteCommand:(id)sender;
- (void)disableControls;
- (void)enableControls;
- (void)showAlertMessage;
- (void)establishConnection;



@end
