//
//  MyRightViewController.m
//  single
//
//  Created by Wang Ming-der on 5/12/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "MyRightViewController.h"

@interface MyRightViewController ()

@end

@implementation MyRightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    // reconfigure code here
}

@end
