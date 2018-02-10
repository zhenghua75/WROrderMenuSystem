//
//  KTThumbsViewController.h
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/3/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTPhotoBrowserDataSource.h"
#import "KTThumbsView.h"
#import "SearchViewController.h"

typedef enum{
    OneView,
    TwoView
}ThumbsType;

@class KTThumbsView;

@interface KTThumbsViewController : UIViewController <KTThumbsViewDataSource>
{
    SearchViewController *_searchViewController;
    NSString *_categoryId;
@private
    id <KTPhotoBrowserDataSource> dataSource1_;
    id <KTPhotoBrowserDataSource> dataSource2_;
    id <KTPhotoBrowserDataSource> dataSource_;
    KTThumbsView *scrollView1_;
    KTThumbsView *scrollView2_;
    KTThumbsView *scrollView_;
    ThumbsType thumbsType_;
    UILabel *_deskNo;
}

@property (nonatomic, retain) id <KTPhotoBrowserDataSource> dataSource1;
@property (nonatomic, retain) id <KTPhotoBrowserDataSource> dataSource2;
@property (nonatomic, retain) id <KTPhotoBrowserDataSource> dataSource;
@property (nonatomic, retain) KTThumbsView *scrollView1;
@property (nonatomic, retain) KTThumbsView *scrollView2;
@property (nonatomic, retain) KTThumbsView *scrollView;
@property (nonatomic, assign) ThumbsType thumbsType;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,strong) UILabel *deskNo;
/**
 * Re-displays the thumbnail images.
 */
- (void)reloadThumbs;

/**
 * Called before the thumbnail images are loaded and displayed.
 * Override this method to prepare. For instance, display an
 * activity indicator.
 */
- (void)willLoadThumbs;

/**
 * Called immediately after the thumbnail images are loaded and displayed.
 */
- (void)didLoadThumbs;

/**
 * Used internally. Called when the thumbnail is touched by the user.
 */
- (void)didSelectThumbAtIndex:(NSUInteger)index thumbsView:(KTThumbsView *)thumbsView;

@end
