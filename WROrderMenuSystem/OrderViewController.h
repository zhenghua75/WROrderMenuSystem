//
//  OrderViewController.h
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeskViewController.h"
#import "MenuViewController.h"
#import <extThree20JSON/extThree20JSON.h>
#import <Three20/Three20.h>
@interface OrderViewController : TTTableViewController
@property (nonatomic, retain) UIPopoverController *popoverController; 
@property (nonatomic, retain) DeskViewController *myDeskPopOver;
@property (nonatomic, retain) MenuViewController *myMenuPopOver;
@end
