//
//  MPCRHostPickerViewController.m
//  mpcremote
//
//  Created by Admin on 1/28/14.
//  Copyright (c) 2014 Bohdan Likhyy. All rights reserved.
//

#import "MPCRHostPickerViewController.h"
#import "MPCRHost.h"
#import "MPCRHostStore.h"
#import "MPCRHostViewController.h"
#import "MPCRControlsView.h"
#import "MPCRHelpView.h"

@implementation MPCRHostPickerViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"MPC Hosts"];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addHost:)];
        [[self navigationItem] setRightBarButtonItem:bbi];
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    BOOL didViewHelp = NO;
    int hosts = [[[MPCRHostStore sharedStore] allHosts] count];
    if (!didViewHelp && hosts <= 0) {
        MPCRHelpView *helpView = [[MPCRHelpView alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:helpView];
        [navController setModalPresentationStyle:UIModalPresentationFormSheet];
        [navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:navController animated:NO completion:nil];
        didViewHelp = YES;
     }
    
    [[self tableView] reloadData];
}


- (void)addHost:(id)sender
{
    MPCRHost *newHost = [[MPCRHostStore sharedStore] createDefaultHost];
    MPCRHostViewController *hostController = [[MPCRHostViewController alloc]initForNewHost:YES];
    [hostController setHost:newHost];
    [hostController setDismissBlock:^{
        [[self tableView] reloadData];
    }];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hostController];
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navController animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[MPCRHostStore sharedStore] allHosts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
    }
    
    MPCRHost *host = [[[MPCRHostStore sharedStore] allHosts] objectAtIndex:[indexPath row]];
    
    NSString *str = [NSString stringWithFormat:@"%@ (%@:%@)", [host hostName], [host hostIPString], [host hostPort]];
    
    [[cell textLabel] setText:str];
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MPCRHostStore *hs = [MPCRHostStore sharedStore];
        NSArray *hosts = [hs allHosts];
        MPCRHost *host = [hosts objectAtIndex:[indexPath row]];
        [hs removeHost:host];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[MPCRHostStore sharedStore] moveItemAtIndex:(int)[sourceIndexPath row]
                                         toIndex:(int)[destinationIndexPath row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPCRControlsView *controlsView = [[MPCRControlsView alloc] init];
    
    NSArray *hosts = [[MPCRHostStore sharedStore] allHosts];
    MPCRHost *selectedHost = [hosts objectAtIndex:[indexPath row]];
    [controlsView setHost: selectedHost];
   
    
    [[self navigationController] pushViewController:controlsView animated:YES];
}




- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    MPCRHostViewController *hostController = [[MPCRHostViewController alloc] initForNewHost:NO];
    
    NSArray *hosts = [[MPCRHostStore sharedStore] allHosts];
    MPCRHost *selectedHost = [hosts objectAtIndex:[indexPath row]];
    [hostController setHost: selectedHost];
    [[self navigationController] pushViewController:hostController animated:YES];
    
    
}



@end

