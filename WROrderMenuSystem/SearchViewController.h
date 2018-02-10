//
//  SearchViewController.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTPhotoView.h"
#import "KTPhotoBrowserDataSource.h"
#import "KTThumbsView.h"
#import "KTPhotoScrollViewController.h"
#import "KTThumbView.h"
#import "PhotoDataSource.h"

@interface SearchViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,NSFetchedResultsControllerDelegate,KTThumbsViewDataSource> {
    PhotoDataSource *data_;
    SearchViewController *_searchViewController;
    UILabel *_deskNo;
    MyButton *addButton;
    OrderMenuInfo *orderInventory;
    id <KTPhotoBrowserDataSource> _dataSource;
}

@property NSMutableArray       *inventoryCategory;
@property NSMutableArray       *inventoryCategory2;
@property NSMutableArray       *inventory;
@property NSString *categoryId;

@property int selectedInventoryIndex;

@property IBOutlet KTThumbsView *scrollView;
@property IBOutlet UIButton *imageButton;
@property IBOutlet UIPickerView *picker;
@property IBOutlet UIImageView *imageView;

- (void)didSelectThumbAtIndex:(NSUInteger)index thumbsView:(KTThumbsView *)thumbsView;

- (IBAction)imgClick:(id)sender;


@end
