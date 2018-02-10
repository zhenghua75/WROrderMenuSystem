//
//  MLTableAlert.h
//
//  Version 1.3
//
//  Created by Matteo Del Vecchio on 11/12/12.
//  Updated on 03/07/2013.
//
//  Copyright (c) 2012 Matthew Labs. All rights reserved.
//  For the complete copyright notice, read Source Code License.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class MLTableAlert;


// Blocks definition for table view management
//
typedef NSInteger (^MLTableAlertNumberOfSectionsBlock)(void);
typedef NSString* (^MLTableAlertTitleForHeadersBlock)(NSInteger section);

typedef NSInteger (^MLTableAlertNumberOfRowsBlock)(NSInteger section);
typedef UITableViewCell* (^MLTableAlertTableCellsBlock)(MLTableAlert *alert, NSIndexPath *indexPath);

typedef void (^MLTableAlertRowSelectionBlock)(NSIndexPath *selectedIndex);
typedef void (^MLTableAlertCompletionBlock)(void);


@interface MLTableAlert : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) MLTableAlertCompletionBlock completionBlock;	// Called when Cancel button pressed
@property (nonatomic, strong) MLTableAlertRowSelectionBlock selectionBlock;	// Called when a row in table view is pressed


// Classe method; rowsBlock and cellsBlock MUST NOT be nil
// Pass NIL to cancelButtonTitle to show an alert without cancel button
+(MLTableAlert *)tableAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelBtnTitle
                    numberOfSections:(MLTableAlertNumberOfSectionsBlock)sectionsBlock
                     titleForHeaders:(MLTableAlertTitleForHeadersBlock)titlesBlock
                        numberOfRows:(MLTableAlertNumberOfRowsBlock)rowsBlock
                            andCells:(MLTableAlertTableCellsBlock)cellsBlock;

// Initialization method; rowsBlock and cellsBlock MUST NOT be nil
// Pass NIL to cancelButtonTitle to show an alert without cancel button
-(id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelBtnTitle
  numberOfSections:(MLTableAlertNumberOfSectionsBlock)sectionsBlock
   titleForHeaders:(MLTableAlertTitleForHeadersBlock)titlesBlock
      numberOfRows:(MLTableAlertNumberOfRowsBlock)rowsBlock
          andCells:(MLTableAlertTableCellsBlock)cellsBlock;

// Allows you to perform custom actions when a row is selected or the cancel button is pressed
-(void)configureSelectionBlock:(MLTableAlertRowSelectionBlock)selBlock andCompletionBlock:(MLTableAlertCompletionBlock)comBlock;

// Show the alert
-(void)show;

@end

