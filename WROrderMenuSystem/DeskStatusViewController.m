//
//  DeskStatusViewController.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-2.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "DeskStatusViewController.h"
#import "DeskStatusCellViewController.h"
#import "OrderDeskInfo.h"
#import "WROrderMenuSystemAppDelegate.h"
@implementation DeskStatusViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(400, 600);
}

- (void)viewDidUnload{
    [super viewDidUnload];
    [self setDeskArray:nil];
    //[self setMainViewController:nil];
    [self setDeskInfo:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_deskArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    DeskStatusCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"DeskStatusCellViewController" bundle:nil];
        cell = (DeskStatusCellViewController*)viewController.view;
        viewController=nil;
    }
    OrderDeskInfo *di = [_deskArray objectAtIndex:indexPath.row];
    [cell.lblDeskNo setText:di.deskNo];
    [cell.lblStatus setText:[di getStatusName]];
    [cell.img setImage:[UIImage imageNamed:[di getImageFileName]]];
    //imageFileName=nil;
    
    if ([di.status isEqualToNumber:[NSNumber numberWithInt:Opened]] || [di.status isEqualToNumber:[NSNumber numberWithInt:Ordered]]) {
        [cell.btnOpenDesk setHidden:YES];
    }
    else{
        [cell.btnDeskNo setHidden:YES];
    }
//    if ([di.status isEqualToNumber:[NSNumber numberWithInt:Ordered]]) {
//        [cell.btnOpenDesk setHidden:YES];
//    }
    [cell setDeskInfo:self.deskInfo];

    //cell.mvController = self.mainViewController;
    [cell setDeskStatusViewController:self];
    //[cell setMyPopoverController:self.myPopoverController];
    di=nil;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  OrderDeskInfo *di = [_deskArray objectAtIndex:indexPath.row];
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([di.status isEqualToNumber:[NSNumber numberWithInt:Opened]] || [di.status isEqualToNumber:[NSNumber numberWithInt:Ordered]]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [delegate showAlert4:di.deskNo];
        
    }
    else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [delegate showAlert3:di.deskNo];
        
    }
    delegate=nil;
}

@end
