//
//  MySettingsViewController.m
//  single
//
//  Created by Wang Ming-der on 5/15/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "MySettingsViewController.h"
#import "IASKSettingsReader.h"
#import "MDAppDelegate.h"

@interface MySettingsViewController ()

@end

@implementation MySettingsViewController

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
	// Do any additional setup after loading the view.
    hasChanged = NO;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingDidChange:) name:kIASKAppSettingChanged object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exit:(id) sender{
    if (hasChanged) {
        [self synchronizeSettings];
        [self performSelectorOnMainThread:@selector(updateAppItemsData) withObject:nil waitUntilDone:NO];
        hasChanged = NO;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) updateAppItemsData {
    MDAppDelegate *app = (MDAppDelegate *)[[UIApplication sharedApplication] delegate];
    [app update500pxItems];
}

#pragma mark kIASKAppSettingChanged notification

- (void)settingDidChange:(NSNotification*)notification {
//    NSLog(@"%@", notification.object);
	if ([notification.object isEqual:@"search_key.single.katdc.com"]) {
#ifdef DEBUG
        NSLog(@"%s|%@",__PRETTY_FUNCTION__,[notification.userInfo objectForKey:notification.object]);
#endif
        hasChanged = YES;
	}
}


@end
