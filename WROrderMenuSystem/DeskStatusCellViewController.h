//
//  DeskStatusCellViewController.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-2.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainViewController;
@class DeskStatusViewController;
@interface DeskStatusCellViewController : UITableViewCell 

@property IBOutlet UILabel *lblDeskNo;
@property IBOutlet UILabel *lblStatus;
@property IBOutlet UIImageView *img;
@property IBOutlet UIButton *btnOpenDesk;
@property IBOutlet UIButton *btnDeskNo;
@property IBOutlet UIButton *deskInfo;
@property DeskStatusViewController *deskStatusViewController;
//@property UIPopoverController *myPopoverController;
//@property MainViewController *mvController;

- (IBAction)openDeskClick:(id)sender;
- (IBAction)deskNoClick:(id)sender;

@end
