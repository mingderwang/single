//
//  MyLeftViewController.m
//  single
//
//  Created by Wang Ming-der on 5/11/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "MyLeftViewController.h"
#import "MDAppDelegate.h"
#import "MDCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@implementation MyLeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initListItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)showCenter:(id)sender {
    // sweet, I can access my parent JASidePanelController as a property!
    [self.sidePanelController showCenterPanelAnimated:YES];
    
}

#pragma mark - list of items

- (void) initListItems {
    MDAppDelegate *app = (MDAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.itemArray = [NSArray arrayWithArray:app.itemsArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MyExampleTableCell";
    
    MDCell *cell = [self.tableView
                            dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[MDCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    [cell.imageView setImageWithURL:[NSURL URLWithString:[_itemArray objectAtIndex:indexPath.row]]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
     {
       
     }];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 320;
}
@end
