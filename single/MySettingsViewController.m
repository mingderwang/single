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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exit:(id) sender {
    [self syncDB];
    MDAppDelegate *app = (MDAppDelegate *)[[UIApplication sharedApplication] delegate];
    [app update500pxItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - init settings database

- (void) syncDB {
    NSDictionary* settingsDictionary = [self.settingsReader settingsDictionary];
    NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //for each preference item, set its default if there is no value set
    for(NSDictionary *item in preferencesArray) {
        
        //get the item key, if there is no key then we can skip it
        NSString *key = [item objectForKey:@"Key"];
        if (key) {
            
            //check to see if the value and default value are set
            //if a default value exists and the value is not set, use the default
            id value = [defaults objectForKey:key];
            id defaultValue = [item objectForKey:@"DefaultValue"];
            if(defaultValue && !value) {
                [defaults setObject:defaultValue forKey:key];
            }
        }
    }
    
    //write the changes to disk
    [defaults synchronize];
}

@end
