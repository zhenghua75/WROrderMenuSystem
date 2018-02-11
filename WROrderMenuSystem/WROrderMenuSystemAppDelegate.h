//
//  WROrderMenuSystemAppDelegate.h
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//
//  modify by zheng hua on 13-6-11
//  修改弹出菜单为UIActionSheet UIAlertView
//#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "OrderInfo.h"
#import "DeskStatusViewController.h"
#import "OrderDeskViewController.h"
#import "MLTableAlert.h"

#import "OrderMenuInfo.h"
#import "MenuStatus.h"
#import "OrderDeskInfo.h"
#import "OrderBookDeskInfo.h"
#import "PackageInfo.h"
#import "NSDictionary+Extends.h"
#import "NSManagedObject+Extends.h"
#import "InventoryCategory.h"
#import "NSDecimalNumber+Compare.h"

@interface WROrderMenuSystemAppDelegate : UIResponder <UIApplicationDelegate> {
    UIAlertView *_syncAlertView;
    NSMutableDictionary *_inventoriesOfCategory;
    NSMutableArray *_categories;
    NSMutableArray *_allInventories;
    NSMutableDictionary *_inventoriesOfPackage;
    NSData *urlData;
}


@property (nonatomic)UIWindow *window;
@property MainViewController *mainViewController;
@property NSFetchedResultsController *fetchedResultsController;

@property (readonly) NSManagedObjectContext *managedObjectContext;
@property (readonly) NSManagedObjectModel *managedObjectModel;
@property (readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property IBOutlet UIAlertController *alertController;
@property IBOutlet UIAlertController *alert0;
@property IBOutlet UIAlertController *alert1;
@property IBOutlet UIAlertController *alert2;
@property IBOutlet UIAlertController *alert3;
@property IBOutlet UIAlertController *alert4;
@property IBOutlet UIAlertController *alert7;

@property (nonatomic,strong) DeskStatusViewController *deskStatusViewController;
@property (nonatomic,strong) OrderDeskViewController *orderDeskViewController;
- (BOOL)sync:(NSInteger) tag userNameField:(NSString*) userName passwdField:(NSString*) passwd;
- (void)theProcess:(UIAlertView *)alertView;
-(void)initAlertControl;
-(void)initAlert0;
-(void)initAlert1;
-(void)initAlert2;
-(void)initAlert3;
-(void)initAlert4;
-(void)initAlert7;
-(void)showAlert3:(NSString*)deskNo;
-(void)showAlert4:(NSString*)deskNo;

- (NSMutableDictionary*)inventoriesOfCategory;
- (void)setInventoriesOfCategory:(NSMutableDictionary *) md;
- (NSArray*)categories;
- (void)setCategories:(NSArray *) array;
- (NSMutableArray*)allInventories;
- (void)setAllInventories:(NSMutableArray *)array;
- (NSMutableDictionary*)inventoriesOfPackage;
- (void)setInventoriesOfPackage:(NSMutableDictionary *) md;


- (void)showAlertView:(OrderMenuInfo*)omi
                  btn:(MyButton*)btn;

- (void)selectPackage:(NSMutableArray *)fixGroup
          optionGroup:(NSMutableArray *)optionGroup
                  omi:(OrderMenuInfo*)omi
                  btn:(MyButton*)btn;

- (void)SyncObject:(UIAlertView*)alertView;
- (BOOL)loginServer:(NSString*)userName passwd:(NSString*)passwd;

- (NSMutableArray*)getOrderBookDeskInfo;
- (NSMutableArray*)getOrderDeskInfo;
- (BOOL)order;

+ (OrderInfo*)orderInfo;
- (BOOL)haveOrderInv:(NSString*)invId;
- (void)menuButtonImgAndAction:(MyButton*)btn;
- (void)InitOrderInfo;
+ (void)ClearOrderInfo;
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
@end
