//
//  DetalViewController.h
//  Homepwner
//
//  Created by Admin on 1/14/14.
//  Copyright (c) 2014 slayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetalViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *noImageLabel;
    
    UIPopoverController *imagePickerPopover;
}

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (id)initForNewItem:(BOOL)isNew;
- (IBAction)takePicture:(id)sender;

- (IBAction)backgroundTapped:(id)sender;


@end
