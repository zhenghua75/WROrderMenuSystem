//
//  DeskStatusCellViewController.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-11-2.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "DeskStatusCellViewController.h"
#import "WROrderMenuSystemAppDelegate.h"
@implementation DeskStatusCellViewController

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
    [_deskStatusViewController dismissViewControllerAnimated:YES completion:nil];
    id delegate = [[UIApplication sharedApplication] delegate];
    [delegate showAlert3:_lblDeskNo.text];
    delegate=nil;
}

- (IBAction)deskNoClick:(id)sender {
    //[self.myPopoverController dismissPopoverAnimated:YES];
    [_deskStatusViewController dismissViewControllerAnimated:YES completion:nil];
    id delegate = [[UIApplication sharedApplication] delegate];
    [delegate showAlert4:_lblDeskNo.text];
    delegate=nil;
}
@end
