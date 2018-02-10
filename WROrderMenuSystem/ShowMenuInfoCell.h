//
//  ShowMenuInfoCell.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-27.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderMenuViewController;
@interface ShowMenuInfoCell : UITableViewCell 

@property IBOutlet UILabel *nameLabel;
@property IBOutlet UILabel *englishLabel;
@property IBOutlet UILabel *priceLabel;
@property IBOutlet UILabel *countLabel;
@property IBOutlet UILabel *amountLabel;
@property IBOutlet UILabel *indexLabel;
@property IBOutlet UILabel *statusLabel;
@property IBOutlet UIButton *subBtn;
@property IBOutlet UIButton *addBtn;
@property IBOutlet UITextField *commentText;

@property OrderMenuViewController *orderMenuViewController;

- (IBAction)subClick:(id)sender;
- (IBAction)addClick:(id)sender;

- (IBAction)commendEdit:(id)sender;

@end
