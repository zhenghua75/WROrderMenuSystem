//
//  OrderDeskCell.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-4.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@class OrderDeskViewController;
@interface OrderDeskCell : UITableViewCell 

@property IBOutlet UILabel *lblDeskNo;
@property IBOutlet UILabel *lblCustomer;
@property IBOutlet UILabel *lblLinkPhone;
@property IBOutlet UILabel *lblBookBeginDate;
@property IBOutlet UILabel *lblBookEndDate;
@property IBOutlet UIButton *btnOpenDesk;
//@property UIPopoverController *myPopoverController;
//@property MainViewController *mvController;
@property OrderDeskViewController *orderDeskViewController;

- (IBAction)openDeskClick:(id)sender;

@end
