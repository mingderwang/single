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
}

- (void)viewWillAppear:(BOOL)animated {
    [self initListItems];
    [super viewWillAppear:animated];
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
    if (nil == searchText || [searchText isEqualToString:app.searchText]) {
        searchText = app.searchText;
        self.itemArray = [NSArray arrayWithArray:app.itemsArray];
    }
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
    cell.cell = [_itemArray objectAtIndex:indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 260;
}

//- (void)reload:(id)sender {
//    [_activityIndicatorView startAnimating];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//    
//    [Example globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
//        if (error) {
//            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
//        } else {
//            _posts = posts;
//            [self.tableView reloadData];
//        }
//        
//        [_activityIndicatorView stopAnimating];
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//    }];
//}

#pragma mark - search handler

- (void)handleSearch:(UISearchBar *)searchBar {

    NSString *searchString = [searchBar text];
    if ([searchString isEqualToString:searchText]) {
        return;
    }
    MDAppDelegate *app = (MDAppDelegate *)[[UIApplication sharedApplication] delegate];
    app.searchText = searchString;
    searchText = nil;
    [app update500pxItems];
    [self initListItems];
    [self performSelectorOnMainThread:@selector(uloadTableView) withObject:nil waitUntilDone:NO];
}

- (void) uloadTableView {
    [self.tableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *) searchBar
{
    [self performSelectorInBackground:@selector(handleSearch:) withObject:searchBar];
}
@end
