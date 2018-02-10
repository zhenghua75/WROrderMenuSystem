//
//  OrderMenuViewController.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-26.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowMenuInfoCell.h"
#import "WROrderMenuSystemAppDelegate.h"

@interface OrderMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    UIViewController *titleViewController;
}

@property IBOutlet UITableView *tableView;
@property IBOutlet UILabel *currentDateTime;
@property IBOutlet UILabel *deskNo;
@property IBOutlet UILabel *count;
@property IBOutlet UILabel *totalMoney;
@property IBOutlet UIToolbar *toolbar;
@property IBOutlet UIButton *button;

- (IBAction)backHome:(id)sender;
- (IBAction)submitClick:(id)sender;

-(void)resetTotalMoney;

@end
