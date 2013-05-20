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
#import "UIImageView+AFNetworking.h"

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@implementation MyLeftViewController
@synthesize itemArray;

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
    
    NSLog(@"%d", indexPath.row);
    // Set up the cell...
//    Example *cellValue = [itemArray objectAtIndex:indexPath.row];

//    cell.detailTextLabel.text = [itemArray objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[itemArray objectAtIndex:indexPath.row]];
    [cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:url]
                       placeholderImage:[UIImage imageNamed:@"Placeholder.png"]
                                success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
                                    
                                    if (request) {
                                        //Fade animation
                                        [UIView transitionWithView:cell.imageView
                                                          duration:0.8f
                                                           options:UIViewAnimationOptionTransitionCrossDissolve
                                                        animations:^{
                                                            [cell.imageView setImage:image];
                                                            
                                                            
                                                            
                                                        } completion:NULL];
                                        
                                    }
                                    
                                    
                                }
                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                    
                                }
     ];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    return 320;
//}
@end
