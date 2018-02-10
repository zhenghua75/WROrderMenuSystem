//
//  OrderDeskCell.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-4.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderDeskCell.h"
#import "WROrderMenuSystemAppDelegate.h"
@implementation OrderDeskCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (IBAction)openDeskClick:(id)sender {
    //[self.myPopoverController dismissPopoverAnimated:YES];
    [_orderDeskViewController dismissViewControllerAnimated:YES completion:nil];
    id delegate = [[UIApplication sharedApplication] delegate];
    [delegate showAlert3:self.lblDeskNo.text];
    delegate=nil;
}
@end
