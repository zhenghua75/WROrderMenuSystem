//
//  MainViewController.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavViewController.h"
#import "TwoLevelMenuViewController.h"
#import "OrderMenuViewController.h"
#import "InfoViewController.h"
#import "HelpViewController.h"
//
//
//UIActionSheetDelegate,
//UIAlertViewDelegate
@interface MainViewController : UIViewController<NSFetchedResultsControllerDelegate,UIPopoverControllerDelegate,UIScrollViewDelegate> {
    NSInteger buttonCount;
    int scrollLength;
}

@property IBOutlet UIImageView *imageView;
@property IBOutlet UIImageView *imageLogoView;
@property IBOutlet UIScrollView *scrollView;
@property IBOutlet UIButton *infoButton;
@property IBOutlet UINavigationController *navigationController;
@property IBOutlet UIView *mainView;

@property NavViewController *navViewController;
@property UIPopoverController *myPopoverController;
@property OrderMenuViewController *orderViewController;
@property NSString *categoryId;
@property NSString *categoryId2;
@property (nonatomic, strong) IBOutlet UIButton *sysButton;

@property (nonatomic,strong) HelpViewController *helpViewController;
@property (nonatomic,strong) InfoViewController *infoViewController;

- (IBAction)myMenuClick:(id)sender;
- (IBAction)dragClick:(UIButton*)sender;
- (IBAction)infoClick:(id)sender;
- (IBAction)helpClick:(id)sender;


- (void)reloadData;

@end
