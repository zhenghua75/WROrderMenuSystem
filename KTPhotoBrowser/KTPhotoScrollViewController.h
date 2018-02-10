//
//  KTPhotoScrollViewController.h
//  KTPhotoBrowser
//
//  Created by Kirby Turner on 2/4/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@class KTPhotoViewController;
@protocol KTPhotoBrowserDataSource;

@interface KTPhotoScrollViewController : UIViewController<UIScrollViewDelegate, UIActionSheetDelegate>
{
    id <KTPhotoBrowserDataSource> dataSource_;
    UIScrollView *scrollView_;
    UIView *view_;
    NSUInteger startWithIndex_;
    NSInteger currentIndex_;
    NSInteger photoCount_;
    NSMutableArray *photoViews_;
    
    // these values are stored off before we start rotation so we adjust our content offset appropriately during rotation
    //int firstVisiblePageIndexBeforeRotation_;
    CGFloat percentScrolledIntoFirstVisiblePage_;
    
    UIBarButtonItem *nextButton_;
    UIBarButtonItem *previousButton_;
    UIBarButtonItem *backButton_;
    
    MyButton *addButton;
    UILabel  *lblInventoryName;
    UILabel  *lblfeature;
    UILabel  *lbldosage;
    UILabel  *lblpalette;
    UILabel *lblPrice;
    UILabel *lblStar;
    UILabel *lblEnglishName;
    UILabel *lblEnglishIntroduce;
    UILabel *lblEnglishDosage;
}

- (id)initWithDataSource:(id <KTPhotoBrowserDataSource>)dataSource andStartWithPhotoAtIndex:(NSUInteger)index;
@property (nonatomic,assign) NSInteger currentIndex;
- (void)unloadPhoto:(NSInteger)index;
@end
