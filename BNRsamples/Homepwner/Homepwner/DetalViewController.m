//
//  DetalViewController.m
//  Homepwner
//
//  Created by Admin on 1/14/14.
//  Copyright (c) 2014 slayer. All rights reserved.
//

#import "DetalViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"


@implementation DetalViewController

@synthesize item, dismissBlock;

- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"DetalViewController" bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    return self;
}


- (void)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}


- (void)cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:item];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initilizer" reason:@"Use initWithNewItem"  userInfo:nil];
    return nil;
}


- (void)setItem:(BNRItem *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [nameField setText:[item itemName]];
    [serialNumberField setText:[item serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]];
    
    NSString *imageKey = [item imageKey];
    if (imageKey) {
        UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
        [imageView setImage:imageToDisplay];
    } else {
        [imageView setImage:nil];
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self view] endEditing:YES];
    [item setItemName:[nameField text]];
    [item setSerialNumber:[serialNumberField text]];
    [item setValueInDollars:[[valueField text] intValue]];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)backgroundTapped:(id)sender
{
    [[self view] endEditing:YES];
}


- (IBAction)takePicture:(id)sender {
    if ([imagePickerPopover isPopoverVisible]){
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
        return;
    }
    
    
    
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    
    // If our device has a camera, we want to take a picture, otherwise, we
    // just pick from photo library
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
  
    [imagePicker setDelegate:self];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [imagePickerPopover setDelegate:self];
        [imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    } else {
        // Place image picker on the screen
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey = [item imageKey];
    if (oldKey) {
        [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
    }
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [item setImageKey:key];
    [[BNRImageStore sharedStore] setImage:image forKey:key];
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    [noImageLabel setHidden:YES];
    
    [imageView setImage:image];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
    }
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    imagePickerPopover = nil;
}



@end
