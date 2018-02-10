//
//  OrderDeskViewController.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-4.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderDeskViewController.h"
#import "OrderDeskCell.h"
#import "OrderBookDeskInfo.h"
@implementation OrderDeskViewController
//@synthesize orderDeskArray;
//@synthesize mainViewController;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(600, 600);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_orderDeskArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDeskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"OrderDeskCell" bundle:nil];
        cell = (OrderDeskCell*)viewController.view;
    }
    OrderBookDeskInfo *di = [_orderDeskArray objectAtIndex:indexPath.row];
    [cell.lblDeskNo setText:di.deskNo];
    [cell.lblCustomer setText:di.customer];
    [cell.lblLinkPhone setText:di.linkPhone];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [cell.lblBookBeginDate setText:[formatter stringFromDate:di.bookBeginDate]];
    [cell.lblBookEndDate setText:[formatter stringFromDate:di.bookEndDate]];
    formatter=nil;
    
    //[cell setMvController:self.mainViewController];
    [cell setOrderDeskViewController:self];
    //[cell setMyPopoverController:self.myPopoverController];
    di=nil;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"OrderDeskTitleCell" bundle:nil];
    return viewController.view;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
