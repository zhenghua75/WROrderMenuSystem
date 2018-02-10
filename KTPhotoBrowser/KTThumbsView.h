//
//  KTThumbsView.h
//  Sample
//
//  Created by Kirby Turner on 3/23/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KTThumbsViewDataSource;
@class KTThumbsViewController;
@class KTThumbView;

@interface KTThumbsView : UIScrollView <UIScrollViewDelegate>
{
    //@private
    id <KTThumbsViewDataSource> dataSource_;
    KTThumbsViewController *controller_;
    BOOL thumbsHaveBorder_;
    NSInteger thumbsPerRow_;
    CGSize thumbSize_;
    
    NSMutableSet *reusableThumbViews_;
    
    // We use the following ivars to keep track of
    // which thumbnail view indexes are visible.
    int firstVisibleIndex_;
    int lastVisibleIndex_;
    int lastItemsPerRow_;
}

@property (nonatomic, strong) id<KTThumbsViewDataSource> dataSource;
@property (nonatomic, strong) KTThumbsViewController *controller;
@property (nonatomic, assign) BOOL thumbsHaveBorder;
@property (nonatomic, assign) NSInteger thumbsPerRow;
@property (nonatomic, assign) CGSize thumbSize;
@property (nonatomic, strong) NSMutableSet *reusableThumbViews;
@property (nonatomic, assign) int firstVisibleIndex;
@property (nonatomic, assign) int lastVisibleIndex;
@property (nonatomic, assign) int lastItemsPerRow;
- (KTThumbView *)dequeueReusableThumbView;
- (void)reloadData;

@end

@protocol KTThumbsViewDataSource <NSObject>
@required
- (NSInteger)thumbsViewNumberOfThumbs:(KTThumbsView *)thumbsView;
- (KTThumbView *)thumbsView:(KTThumbsView *)thumbsView thumbForIndex:(NSInteger)index;

@end
