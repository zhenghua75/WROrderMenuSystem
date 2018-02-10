//
//  KTThumbView.h
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderMenuInfo.h"
#import "MyButton.h"
@class KTThumbsViewController;
@class KTThumbsView;
@class SearchViewController;
@interface KTThumbView : UIButton
{
@private
    KTThumbsViewController *controller_;
    KTThumbsView *thumbsView_;
    
    SearchViewController *controller1_;
    OrderMenuInfo *_orderInventory;
    MyButton *addButton;
    UILabel *lblStar;
    UILabel  *lblInventoryName;
    UILabel  *lblEnglishName;
    UILabel *lblPrice;
}

@property (nonatomic, strong) KTThumbsViewController *controller;
@property (nonatomic, strong) SearchViewController *controller1;
@property (nonatomic, strong) KTThumbsView *thumbsView;

- (id)initWithFrame:(CGRect)frame;
- (void)setThumbImage:(OrderMenuInfo *)newImage size:(CGSize)size image:(UIImage*)image;
- (void)setHasBorder:(BOOL)hasBorder;

@end

