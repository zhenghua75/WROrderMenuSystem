//
//  NavViewController.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTThumbsViewController.h"
#import "PhotoDataSource.h"

@interface NavViewController : KTThumbsViewController<UINavigationControllerDelegate>{
    PhotoDataSource *data_;
    PhotoDataSource *data2_;
}

@property NSString *categoryId2;
- (void)reloadData;

@end
