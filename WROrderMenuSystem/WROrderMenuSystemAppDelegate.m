//
//  WROrderMenuSystemAppDelegate.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "WROrderMenuSystemAppDelegate.h"

@implementation WROrderMenuSystemAppDelegate

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize fetchedResultsController=__fetchedResultsController;

static OrderInfo* _orderInfo;
static NSString* _userName=@"";
static NSString* _passwd=@"";

NSTimeInterval defaultTimeout=60.0;
#pragma application

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    _mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self initAlertControl];
    [self initAlert0];
    [self initAlert1];
    [self initAlert2];
    [self initAlert3];
    [self initAlert4];
    [self initAlert7];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:_mainViewController];
    [application setStatusBarHidden:YES];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)theProcess:(UIAlertView *)alertView {
    @autoreleasepool {
        [self SyncObject:alertView];
        [_mainViewController.navViewController viewDidLoad];
    }
}
- (BOOL)sync:(NSInteger) tag userNameField:(NSString*) userName passwdField:(NSString*) passwd{
    if (userName.length==0 || passwd.length==0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"登录" message:@"登录失败，请输入用户名密码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        return NO;
    }
    
    if(tag == 3){
        if (![self loginServer:userName passwd:passwd]) {
            _userName = @"";
            _passwd = @"";
            return NO;
        }
        _userName = userName;
        _passwd = passwd;
        
        return YES;
    }
    
    NSString *alertViewTitle = nil;
    switch (tag) {
        case 0:
            alertViewTitle=@"同步所有";
            break;
        case 1:
            alertViewTitle=@"同步数据";
            break;
        case 2:
            alertViewTitle=@"同步图片";
            break;
        default:
            break;
    }
    UIAlertView *syncAlert = [[UIAlertView alloc] initWithTitle:alertViewTitle message:@"正在同步" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    syncAlert.tag=tag;
    [syncAlert show];
    [NSThread detachNewThreadSelector:@selector(theProcess:) toTarget:self withObject:syncAlert];
    return YES;
}
- (void)initAlertControl{
    _deskStatusViewController = [[DeskStatusViewController alloc] initWithNibName:@"DeskStatusViewController" bundle:nil];
    _orderDeskViewController = [[OrderDeskViewController alloc] initWithNibName:@"OrderDeskViewController" bundle:nil];
    _alertController = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
        NSLog(@"取消");
    }];
    
    UIAlertAction* action0 = [UIAlertAction actionWithTitle:@"同步所有" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"同步所有");
        [_mainViewController presentViewController:_alert0 animated:YES completion:nil];
        //[self sync:0 userNameField:_userName passwdField:_passwd];
    }];
    
    UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"同步数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"同步数据");
        [_mainViewController presentViewController:_alert1 animated:YES completion:nil];
        //[self sync:1 userNameField:_userName passwdField:_passwd];
    }];
    
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"同步图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"同步图片");
        [_mainViewController presentViewController:_alert2 animated:YES completion:nil];
        //[self sync:2 userNameField:_userName passwdField:_passwd];
    }];
    
    UIAlertAction* action3 = [UIAlertAction actionWithTitle:@"开台" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"开台");
        [_mainViewController presentViewController:_alert3 animated:YES completion:nil];
    }];
    
    UIAlertAction* action4 = [UIAlertAction actionWithTitle:@"桌号" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"桌号");
        [_mainViewController presentViewController:_alert4 animated:YES completion:nil];
    }];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    //CGFloat screenHeight = screenSize.height;
    
    UIAlertAction* action5 = [UIAlertAction actionWithTitle:@"桌台信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"桌台信息");
        NSMutableArray *deskArray = [self getOrderDeskInfo];
        if ([deskArray count]>0) {
            [_deskStatusViewController setDeskArray:deskArray];
            
            _deskStatusViewController.modalPresentationStyle = UIModalPresentationPopover;
            UIPopoverPresentationController* presentationController=[_deskStatusViewController popoverPresentationController];
            presentationController.sourceView = _mainViewController.view;
            presentationController.sourceRect = CGRectMake(screenWidth/2, 100, 0, 0);
            
            [_mainViewController presentViewController:self.deskStatusViewController animated:YES completion:nil];
        }
        deskArray=nil;
    }];
    
    UIAlertAction* action6 = [UIAlertAction actionWithTitle:@"预订信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"预订信息");
        NSMutableArray *deskArray = [self getOrderBookDeskInfo];
        if ([deskArray count]>0) {
            [_orderDeskViewController setOrderDeskArray:deskArray];
            _orderDeskViewController.modalPresentationStyle = UIModalPresentationPopover;
            UIPopoverPresentationController* presentationController=[_orderDeskViewController popoverPresentationController];
            presentationController.sourceView = _mainViewController.view;
            presentationController.sourceRect = CGRectMake(screenWidth/2, 100, 0, 0);
            [_mainViewController presentViewController:self.orderDeskViewController animated:YES completion:nil];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预订信息" message:@"未能获取预订信息！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            alert=nil;
        }
        deskArray=nil;
    }];
    
    UIAlertAction* action7 = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        NSLog(@"登录");
        [_mainViewController presentViewController:_alert7 animated:YES completion:nil];
    }];
    
    UIAlertAction* resetAction = [UIAlertAction actionWithTitle:@"清台" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* action){
        NSLog(@"清台");
        @autoreleasepool {
            [WROrderMenuSystemAppDelegate ClearOrderInfo];
            [_mainViewController.navViewController.deskNo setText:nil];
            [_mainViewController.navViewController reloadData];
        }
    }];
    
    
    [_alertController addAction:action0];
    [_alertController addAction:action1];
    [_alertController addAction:action2];
    [_alertController addAction:action3];
    [_alertController addAction:action4];
    [_alertController addAction:action5];
    [_alertController addAction:action6];
    [_alertController addAction:action7];
    
    [_alertController addAction:resetAction];
    [_alertController addAction:cancelAction];
    
    
}
- (void)initAlert0{
    _alert0 = [UIAlertController alertControllerWithTitle:@"同步所有" message:@"登录后才能进行同步！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*     action00 = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"00 Cancel");
        //UITextField* field1 = _alert0.textFields.firstObject;
        //UITextField* field2 = _alert0.textFields.lastObject;
        
        //field1.text = @"";
        //field2.text = @"";
    }];
    UIAlertAction*     action01 = [UIAlertAction actionWithTitle:@"同步所有" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"01 ok");
        //UITextField* field1 = _alert0.textFields.firstObject;
        //UITextField* field2 = _alert0.textFields.lastObject;
        
        [self sync:0 userNameField:_userName passwdField:_passwd];
        
        //field1.text = @"";
        //field2.text = @"";
    }];
//    [_alert0 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder =@"用户名";
//    }];
//    [_alert0 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.secureTextEntry=YES;
//        textField.placeholder=@"密码";
//    }];
    [_alert0 addAction:action00];
    [_alert0 addAction:action01];
}
- (void)initAlert1{
    _alert1 = [UIAlertController alertControllerWithTitle:@"同步数据" message:@"登录后才能进行同步！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*     action10 = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"10 Cancel");
//        UITextField* field1 = _alert1.textFields.firstObject;
//        UITextField* field2 = _alert1.textFields.lastObject;
//
//        field1.text = @"";
//        field2.text = @"";
    }];
    UIAlertAction*     action11 = [UIAlertAction actionWithTitle:@"同步数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"11 ok");
//        UITextField* field1 = _alert1.textFields.firstObject;
//        UITextField* field2 = _alert1.textFields.lastObject;
        
        [self sync:1 userNameField:_userName passwdField:_passwd];
        
//        field1.text = @"";
//        field2.text = @"";
    }];
//    [_alert1 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder =@"用户名";
//    }];
//    [_alert1 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.secureTextEntry=YES;
//        textField.placeholder=@"密码";
//    }];
    [_alert1 addAction:action10];
    [_alert1 addAction:action11];
}
- (void)initAlert2{
    _alert2 = [UIAlertController alertControllerWithTitle:@"同步图片" message:@"登录后才能进行同步！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*     action20 = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"20 Cancel");
//        UITextField* field1 = _alert2.textFields.firstObject;
//        UITextField* field2 = _alert2.textFields.lastObject;
//
//        field1.text = @"";
//        field2.text = @"";
    }];
    UIAlertAction*     action21 = [UIAlertAction actionWithTitle:@"同步图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"21 ok");
//        UITextField* field1 = _alert2.textFields.firstObject;
//        UITextField* field2 = _alert2.textFields.lastObject;
        
        [self sync:2 userNameField:_userName passwdField:_passwd];
        
//        field1.text = @"";
//        field2.text = @"";
    }];
//    [_alert2 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder =@"用户名";
//    }];
//    [_alert2 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.secureTextEntry=YES;
//        textField.placeholder=@"密码";
//    }];
    [_alert2 addAction:action20];
    [_alert2 addAction:action21];
}
//开台
- (void)initAlert3{
    _alert3 = [UIAlertController alertControllerWithTitle:@"开台" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*     action30 = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"30 Cancel");
        UITextField* field1 = _alert3.textFields.firstObject;
        //UITextField* field2 = [_alert3.textFields objectAtIndex:1];
        //UITextField* field3 = [_alert3.textFields objectAtIndex:2];
        UITextField* field2 = _alert3.textFields.lastObject;
        
        field1.text = @"";
        field2.text = @"";
        //field3.text = @"";
        //field4.text = @"";
    }];
    UIAlertAction*     action31 = [UIAlertAction actionWithTitle:@"开台" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"31 ok");
        UITextField* field1 = _alert3.textFields.firstObject;
        //UITextField* field2 = [_alert3.textFields objectAtIndex:1];
        //UITextField* field3 = [_alert3.textFields objectAtIndex:2];
        UITextField* field2 = _alert3.textFields.lastObject;
        
        NSString *username = _userName;//field1.text;
        NSString *password = _passwd;//field2.text;
        NSString *deskno = field1.text;
        NSString *quantity = field2.text;
        
        NSString *msg=nil;
        if ([username length]==0 || [password length]==0) {
            msg = [msg stringByAppendingString:@"请登录！\n"];
        }
        if ([deskno length]==0) {
            msg = [msg stringByAppendingString:@"请输入桌台号！\n"];
        }
        if ([quantity length]==0) {
            msg = [msg stringByAppendingString:@"请输入人数！\n"];
        }
        if ([msg length]>0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"开台" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            alert=nil;
            return;
        }
        NSNumber *iquantity = [NSNumber numberWithInt:[quantity intValue]];
        if (iquantity==0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"开台" message:@"请输入人数！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            alert=nil;
            return;
        }
        if ([self postOpenData:username passwd:password deskno:deskno quantity:iquantity]) {
            NSDictionary *dict = [self jsonToObj:urlData];
            [self getOrderInfo:dict];
            [_mainViewController.navViewController.deskNo setText:deskno];
            [_mainViewController.navViewController reloadData];
        }
        field1.text = @"";
        field2.text = @"";
        //field3.text = @"";
        //field4.text = @"";
        
        username=nil;
        password=nil;
        deskno=nil;
        quantity=nil;
        msg=nil;
    }];
//    [_alert3 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder =@"用户名";
//    }];
//    [_alert3 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.secureTextEntry=YES;
//        textField.placeholder=@"密码";
//    }];
    [_alert3 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder =@"桌台号";
    }];
    [_alert3 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder =@"人数";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    [_alert3 addAction:action30];
    [_alert3 addAction:action31];
  
}
//桌号
- (void)initAlert4{
    _alert4 = [UIAlertController alertControllerWithTitle:@"桌号" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*     action40 = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"40 Cancel");
        UITextField* field1 = _alert4.textFields.firstObject;
        //UITextField* field2 = [_alert4.textFields objectAtIndex:1];
        //UITextField* field3 = _alert4.textFields.lastObject;
        
        field1.text = @"";
        //field2.text = @"";
        //field3.text = @"";
    }];
    UIAlertAction*     action41 = [UIAlertAction actionWithTitle:@"桌号" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"41 ok");
        UITextField* field1 = _alert4.textFields.firstObject;
        //UITextField* field2 = [_alert4.textFields objectAtIndex:1];
        //UITextField* field3 = _alert4.textFields.lastObject;
        
        NSString *username = _userName;//field1.text;
        NSString *password = _passwd;//field2.text;
        NSString *deskno = field1.text;
        
        NSString *msg=@"";
        if (username==nil || username.length==0|| password==nil || password.length==0) {
            msg = [msg stringByAppendingString:@"请登录！\n"];
        }
        if (deskno==nil || deskno.length==0) {
            msg = [msg stringByAppendingString:@"请输入桌台号！\n"];
        }
        if (msg.length>0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"桌号" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            alert=nil;
            return;
        }
        if ([self getOrderData:username passwd:password deskno:deskno]) {
            NSDictionary *dict = [self jsonToObj:urlData];
            [self getOrderInfo:dict];
            [self.mainViewController.navViewController.deskNo setText:deskno];
            [self.mainViewController.navViewController reloadData];
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"登录" message:@"登录失败，用户名或密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            alert=nil;
        }
        field1.text = @"";
        //field2.text = @"";
        //field3.text = @"";
        
        username=nil;
        password=nil;
        deskno=nil;
        msg=nil;
    }];
//    [_alert4 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder =@"用户名";
//    }];
//    [_alert4 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.secureTextEntry=YES;
//        textField.placeholder=@"密码";
//    }];
    [_alert4 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder =@"桌台号";
    }];
    
    [_alert4 addAction:action40];
    [_alert4 addAction:action41];
    
}

- (void)initAlert7{
    _alert7 = [UIAlertController alertControllerWithTitle:@"登录" message:@"请输入用户名、密码，点击登录按钮" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*     action70 = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"70 Cancel");
        UITextField* field1 = _alert0.textFields.firstObject;
        UITextField* field2 = _alert0.textFields.lastObject;
        
        field1.text = @"";
        field2.text = @"";
    }];
    UIAlertAction*     action71 = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"71 ok");
        UITextField* field1 = _alert7.textFields.firstObject;
        UITextField* field2 = _alert7.textFields.lastObject;
        
        if([self sync:3 userNameField:field1.text passwdField:field2.text]){
            _alertController.title = _userName;
        }
        
        field1.text = @"";
        field2.text = @"";
    }];
    [_alert7 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder =@"用户名";
    }];
    [_alert7 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.secureTextEntry=YES;
        textField.placeholder=@"密码";
    }];
    [_alert7 addAction:action70];
    [_alert7 addAction:action71];
}

- (void)showAlert3:(NSString*)deskNo{
    UITextField* textField = _alert3.textFields.firstObject;
    textField.text = deskNo;
    [_mainViewController presentViewController:_alert3 animated:YES completion:nil];
}
- (void)showAlert4:(NSString*)deskNo{
    UITextField* textField = [_alert4.textFields firstObject];
    textField.text = deskNo;
    
    //[_alertController dismissViewControllerAnimated:YES completion:nil];
    [_mainViewController presentViewController:_alert4 animated:YES completion:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application{
    [self saveContext];
}

//- (void)applicationWillEnterForeground:(UIApplication *)application{
//     [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
//}

#pragma mark - Core Data stack

- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WROrderMenuSystem" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WROrderMenuSystem.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES,
                              NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}
                              };
//
//    // Check if we need a migration
//    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:storeURL error:&error];
//    NSManagedObjectModel *destinationModel = [__persistentStoreCoordinator managedObjectModel];
//    BOOL isModelCompatible = (sourceMetadata == nil) || [destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata];
//    if (! isModelCompatible) {
//        // We need a migration, so we set the journal_mode to DELETE
//        options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
//                    NSInferMappingModelAutomaticallyOption:@YES,
//                    NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}
//                    };
//    }

    
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        
    }
    [self addSkipBackupAttributeToItemAtURL:storeURL];
//    NSPersistentStore *persistentStore = [__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
//    if (! persistentStore) {
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//    // Reinstate the WAL journal_mode
//    if (! isModelCompatible) {
//        [__persistentStoreCoordinator removePersistentStore:persistentStore error:NULL];
//        options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
//                    NSInferMappingModelAutomaticallyOption:@YES,
//                    NSSQLitePragmasOption: @{@"journal_mode": @"WAL"}
//                    };
//        [__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
//    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - jsonData

- (NSData*)getJsonData:(NSString*)pathUrl{
    if ([self getJSONData:pathUrl]) {
        return urlData;
    }
    else{
        return nil;
    }
}
- (NSData*)postJsonData:(NSString *)pathUrl dict:(NSDictionary*) dict{
    if ([self postJsonData:pathUrl dict:dict]) {
        return urlData;
    }
    else{
        return nil;
    }
}
- (BOOL)getJSONData:(NSString *)pathUrl{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *serverAddress = [defaults objectForKey:@"ServerAddress"];
    if ([serverAddress length]==0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败" message:@"服务器地址为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    NSURL *url=[[NSURL alloc]initWithString:[NSString stringWithFormat: @"%@%@",serverAddress,pathUrl]];
    //NSTimeInterval *interval =
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NO timeoutInterval:defaultTimeout];
    NSURLResponse *response=nil;
	NSError *err=nil;
	urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (nil!=err){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败" message:err.localizedDescription delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (nil==response) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败" message:@"无返回！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    NSHTTPURLResponse * httpResponse;
    httpResponse = (NSHTTPURLResponse *) response;
    if ((httpResponse.statusCode / 100) != 2) {
        NSString *urlStr = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败"
                                                        message:urlStr
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
	if(urlData==nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败"
                                                        message:@"空数据"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
	}
    return YES;
}
- (BOOL)postJSONData:(NSString *)pathUrl dict:(NSDictionary*) dict{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *serverAddress = [defaults stringForKey:@"ServerAddress"];
    if ([serverAddress length]==0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败" message:@"服务器地址为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    NSURL *url=[[NSURL alloc]initWithString:[NSString stringWithFormat: @"%@%@",serverAddress,pathUrl]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NO timeoutInterval:defaultTimeout];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *jsonError;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&jsonError];
    if (jsonError!=nil) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败" message:@"json数据解析失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    [request setHTTPBody:postData];
    
    NSURLResponse *response=nil;
	NSError *err=nil;
	urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (nil!=err){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败" message:err.localizedDescription delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (nil==response) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败" message:@"无返回！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    NSHTTPURLResponse * httpResponse;
    httpResponse = (NSHTTPURLResponse *) response;
    if ((httpResponse.statusCode / 100) != 2) {
        NSString *urlStr = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败"
                                                        message:urlStr
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
	if(urlData==nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务调用失败"
                                                        message:@"空数据"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
	}
    return YES;
}
- (id)jsonToObj:(NSData*)returnedData{
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:returnedData
                 options:0
                 error:&error];
    
    if(error) {
        return nil;
    }
    return object;
}

#pragma mark -Sync-AlertView
- (void)updateAlertViewMsg:(NSString *)msg{
    //NSLog(@"%@",msg);
    [_syncAlertView setMessage:msg];
}
- (void)syncAlertViewMsg:(NSString *)msg{
    [self performSelectorOnMainThread:@selector(updateAlertViewMsg:) withObject:msg waitUntilDone:NO];
}

#pragma mark -Sync-Img
- (UIImage *)getImgData:(NSString *) imageFileName{
    UIImage *img=nil;
    if ([self getJSONData:[NSString stringWithFormat: @"/Service1/ReadImg/%@",[imageFileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]) {
        img=[[UIImage alloc] initWithData:urlData];
    }
    return img;
}
- (UIImage *)generateImgThumbnail:(UIImage *)image rect:(CGRect)rect{
    UIGraphicsBeginImageContext( rect.size );
    
    [image drawInRect:CGRectMake(0,0,rect.size.width,rect.size.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}
- (void)saveLocalImg:(UIImage*)image path:(NSString*)path{
    NSString* fileExtension = [path pathExtension];
    if ([[fileExtension uppercaseString]  isEqual: @"PNG"]) {
        [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    }else{
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
    }
    
    NSURL *url = [NSURL fileURLWithPath:path];
    [self addSkipBackupAttributeToItemAtURL:url];
}
- (void)syncImg:(NSArray *) imgFileNames{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    int i=0;
    for (NSDictionary *ifn in imgFileNames) {
        //2 下载图片
        i++;
        

        @autoreleasepool {
            NSString *imageFileName = [ifn remoteFileName];
            NSDate *dateFromString = [ifn remoteModifyDate];
            NSString *imgpath = [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithString: imageFileName] ];
            NSString *msg = [NSString stringWithFormat:@"%@\n%i/%lu---%@",@"同步图片",i,(unsigned long)[imgFileNames count],imageFileName];
            //NSLog(@"%@",msg);
            [self syncAlertViewMsg:msg];
            msg=nil;
            //[NSThread sleepForTimeInterval:10];//测试消息显示用
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if([fileManager fileExistsAtPath:imgpath]){
                NSDictionary *dictAttr= [fileManager attributesOfItemAtPath:imgpath error:nil];
                if (dictAttr!=nil) {
                    NSDate *modifydate =[dictAttr objectForKey:NSFileModificationDate];
                    if ([dateFromString isEqualToDate:modifydate]) {
                        modifydate=nil;
                        dictAttr=nil;
                        continue;
                    }
                    modifydate=nil;
                }
                dictAttr=nil;
            }
            imgpath=nil;
            
            UIImage *image = [self getImgData:imageFileName];
            CGRect rect1 = CGRectMake(0, 0, 240, 135);
            CGRect rect2 = CGRectMake(0, 0, 340, 191.25);
            UIImage *image1 = [self generateImgThumbnail:image rect:rect1];
            UIImage *image2 = [self generateImgThumbnail:image rect:rect2];
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:
                              [NSString stringWithString: imageFileName] ];
            NSString *imageFileName1 = [NSString stringWithFormat:@"%@%@",imageFileName,@"_1.jpg"];
            NSString *imageFileName2 = [NSString stringWithFormat:@"%@%@",imageFileName,@"_2.jpg"];
            NSString *path1 = [documentsDirectory stringByAppendingPathComponent:
                               [NSString stringWithString: imageFileName1] ];
            NSString *path2 = [documentsDirectory stringByAppendingPathComponent:
                               [NSString stringWithString: imageFileName2] ];
            
            //3 保存图片
            [self saveLocalImg:image path:path];
            NSDictionary *oldAttr=[NSDictionary dictionaryWithObjectsAndKeys:dateFromString,NSFileModificationDate, nil];
            [fileManager setAttributes:oldAttr ofItemAtPath:path error:nil];
            [self saveLocalImg:image1 path:path1];
            [self saveLocalImg:image2 path:path2];
            
            image=nil;
            image1=nil;
            image2=nil;
            path=nil;
            path1=nil;
            path2=nil;
            imageFileName1=nil;
            imageFileName2=nil;
            imageFileName=nil;
        }
    }
    paths=nil;
    documentsDirectory=nil;
    
}
- (void)deleteLocalImg:(NSArray*)imgFileNames{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *localImgFiles = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSMutableArray *remoteImgFiles = [[NSMutableArray alloc] initWithCapacity:[imgFileNames count]];
    [remoteImgFiles addObject:@"WROrderMenuSystem.sqlite"];
    for (NSDictionary *ifn in imgFileNames)
    {
        NSString *imgFile = [ifn remoteFileName];
        NSString *imageFileName1 = [NSString stringWithFormat:@"%@%@",imgFile,@"_1.jpg"];
        NSString *imageFileName2 = [NSString stringWithFormat:@"%@%@",imgFile,@"_2.jpg"];
        [remoteImgFiles addObject:imgFile];
        [remoteImgFiles addObject:imageFileName1];
        [remoteImgFiles addObject:imageFileName2];
        
        imageFileName1=nil;
        imageFileName2=nil;
        imgFile=nil;
    }
    for (NSString *imgFile in localImgFiles) {
        if(![remoteImgFiles containsObject:imgFile])
        {
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:
                                           [NSString stringWithString: imgFile] ] error:nil];
        }
    }
    remoteImgFiles=nil;
    localImgFiles=nil;
    fileManager=nil;
    documentsDirectory=nil;
    paths=nil;
}

#pragma mark -Sync-Data
- (void)deleteLocalData:(NSString *) tableName SortDescriptorKey:(NSString *) sortDescriptorKey{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context reset];
    [context setRetainsRegisteredObjects:YES];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:sortDescriptorKey ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc]
                                initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *categoryDeleteArray = [context executeFetchRequest: fetchRequest error:&error];
    for (int idx=0; idx<[categoryDeleteArray count]; idx++) {
        [context deleteObject:[categoryDeleteArray objectAtIndex:idx]];
        [self saveContext];
    }
    
    error=nil;
    categoryDeleteArray=nil;
    sortDescriptors=nil;
    sortDescriptor=nil;
    entity=nil;
    fetchRequest=nil;
    context=nil;
}
- (void)addInventoryCategory:(NSArray *)categoryArray{
    //3 插入本地---------
    NSManagedObjectContext *context = [self managedObjectContext];
    [context reset];
    [context setRetainsRegisteredObjects:YES];
    for (NSDictionary *dict in categoryArray) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"InventoryCategory" inManagedObjectContext:context];
        [newManagedObject setLocalId:dict];
        [newManagedObject setLocalCode:dict];
        [newManagedObject setLocalName:dict];
        [newManagedObject setLocalComment:dict];
        [self saveContext];
        newManagedObject=nil;
    }
    context=nil;
}
- (void)addInventory:(NSArray *) inventoryArray{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context reset];
    [context setRetainsRegisteredObjects:YES];
    for (NSDictionary *dict in inventoryArray) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Inventory" inManagedObjectContext:context];
        [newManagedObject setLocalId:dict];
        [newManagedObject setLocalCategory:dict];
        [newManagedObject setLocalCode:dict];
        [newManagedObject setLocalName:dict];
        [newManagedObject setLocalEnglishName:dict];
        [newManagedObject setLocalUnitOfMeasure:dict];
        [newManagedObject setLocalSpecs:dict];
        [newManagedObject setLocalComment:dict];
        [newManagedObject setLocalImageFileName:dict];
        
        [newManagedObject setLocalSalePoint:dict];
        [newManagedObject setLocalSalePoint0:dict];
        [newManagedObject setLocalSalePoint1:dict];
        [newManagedObject setLocalSalePoint2:dict];
        
        [newManagedObject setLocalSalePrice:dict];
        [newManagedObject setLocalSalePrice0:dict];
        [newManagedObject setLocalSalePrice1:dict];
        [newManagedObject setLocalSalePrice2:dict];
        
        [newManagedObject setLocalIsDonate:dict];
        [newManagedObject setLocalIsRecommend:dict];
        [newManagedObject setLocalIsPackage:dict];
        [newManagedObject setLocalStars:dict];
        [newManagedObject setLocalSort:dict];
        [newManagedObject setLocalFeature:dict];
        [newManagedObject setLocalDosage:dict];
        [newManagedObject setLocalPalette:dict];
        [newManagedObject setLocalEnglishIntroduce:dict];
        [newManagedObject setLocalEnglishDosage:dict];
        [self saveContext];
        newManagedObject=nil;
    }
    context=nil;
}
- (void)addPackages:(NSArray *) packagesArray{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context reset];
    [context setRetainsRegisteredObjects:YES];
    for (NSDictionary *dict in packagesArray) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Packages" inManagedObjectContext:context];
        [newManagedObject setLocalId:dict];
        [newManagedObject setLocalPackageId:dict];
        [newManagedObject setLocalInventoryId:dict];
        [newManagedObject setLocalCode:dict];
        [newManagedObject setLocalName:dict];
        [newManagedObject setLocalSalePrice:dict];
        [newManagedObject setLocalIsOptional:dict];
        [newManagedObject setLocalOptionalGroup:dict];
        [newManagedObject setLocalComment:dict];
        [self saveContext];
        newManagedObject=nil;
    }
    
    context=nil;
}

#pragma mark -Sync-All
- (void)SyncObject:(UIAlertView*)alertView{
    //[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    _syncAlertView=alertView;
    @try {
        NSArray *imgFileNames;
        //同步图片
        //1 获取文件名列表
        int flag = (int)alertView.tag;
        if (flag==0||flag==2) {
            [self syncAlertViewMsg:@"取得图片\n文件列表"];
            if (![self getJSONData:@"/Service1/GetImageFileNames"]) {
                return;
            }
            imgFileNames = [self jsonToObj:urlData];
            [self deleteLocalImg:imgFileNames];
            [self syncAlertViewMsg:@"下载图片"];
            [self syncImg:imgFileNames];
        }
        NSArray *categoryArray;
        NSArray *inventoryArray;
        NSArray *packagesArray;
        if (flag==0||flag==1) {
            //--------同步InventoryCategory
            //1 获取
            [self syncAlertViewMsg:@"取得商品分类列表"];
            if (![self getJSONData:@"/Service1/GetCategory"]) {
                return;
            }
            
            categoryArray=[self jsonToObj:urlData];
            //2 删除本地
            [self syncAlertViewMsg:@"删除ipad商品分类"];
            [self deleteLocalData:@"InventoryCategory" SortDescriptorKey:@"code"];
            //3添加本地
            [self syncAlertViewMsg:@"添加ipad商品分类"];
            [self addInventoryCategory:categoryArray];
            //-----InvnetoryCategory同步完成
            
            //--------同步Inventory
            //1 获取
            [self syncAlertViewMsg:@"取得商品列表"];
            if (![self getJSONData:@"/Service1/GetInventory"]) {
                return;
            }
            inventoryArray=[self jsonToObj:urlData];
            //2 删除本地
            [self syncAlertViewMsg:@"删除Ipad商品信息"];
            [self deleteLocalData:@"Inventory" SortDescriptorKey:@"code"];
            //3 插入本地---------
            [self syncAlertViewMsg:@"添加Ipad商品信息"];
            [self addInventory:inventoryArray];
            
            //---同步套餐
            //1 获取
            [self syncAlertViewMsg:@"取得套餐列表"];
            if (![self getJSONData:@"/Service1/GetPackages"]) {
                return;
            }
            packagesArray=[self jsonToObj:urlData];
            //2 删除本地
            [self syncAlertViewMsg:@"删除Ipad套餐信息"];
            [self deleteLocalData:@"Packages" SortDescriptorKey:@"code"];
            //3 插入本地---------
            [self syncAlertViewMsg:@"添加Ipad套餐信息"];
            [self addPackages:packagesArray];
        }
        imgFileNames=nil;
        categoryArray=nil;
        inventoryArray=nil;
        packagesArray=nil;
        
        [self getData];
        [_mainViewController reloadData];
        [self syncAlertViewMsg:@"同步完成"];
        [_syncAlertView dismissWithClickedButtonIndex:0 animated:YES];
        _syncAlertView=nil;
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"同步" message:[exception reason] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        alert=nil;
    }
    @finally {
        if (_syncAlertView) {
            [_syncAlertView dismissWithClickedButtonIndex:0 animated:YES];
            _syncAlertView=nil;
        }
    }
}
- (BOOL)loginServer:(NSString*)userName passwd:(NSString*)passwd{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:userName,@"userName",passwd,@"passwd", nil];
    if([self postJSONData:@"/Service1/LogOn" dict:dict]){
        NSString *retStr = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
        return[[retStr lowercaseString] isEqualToString:@"true"];
    }
    return NO;
}


#pragma mark --静态变量
+ (OrderInfo*)orderInfo{
    if (!_orderInfo) {
        _orderInfo = [[OrderInfo alloc] init];
        if (!_orderInfo.lOrderMenu) {
            _orderInfo.lOrderMenu = [[NSMutableArray alloc] init];
        }
        if (!_orderInfo.lPackage) {
            _orderInfo.lPackage = [[NSMutableArray alloc] init];
        }
        if (!_orderInfo.lLackMenu) {
            _orderInfo.lLackMenu = [[NSMutableArray alloc] init];
        }
    }
    return _orderInfo;
}
#pragma mark 自定义属性
- (NSMutableDictionary*)inventoriesOfCategory{
    if (_inventoriesOfCategory!=nil) {
        return _inventoriesOfCategory;
    }
    [self getData];
    return _inventoriesOfCategory;
}
- (void)setInventoriesOfCategory:(NSMutableDictionary *) md{
    _inventoriesOfCategory = md;
}
- (NSArray*)categories{
    if (_categories!=nil) {
        return _categories;
    }
    [self getData];
    return  _categories;
}
- (void)setCategories:(NSMutableArray *) array{
    _categories=array;
}
- (NSMutableArray*)allInventories{
    if (_allInventories!=nil) {
        return _allInventories;
    }
    [self getData];
    return  _allInventories;
}
- (void)setAllInventories:(NSMutableArray *)array{
    _allInventories = array;
}
- (NSMutableDictionary*)inventoriesOfPackage{
    if (_inventoriesOfPackage!=nil) {
        return _inventoriesOfPackage;
    }
    [self getData];
    return  _inventoriesOfPackage;
}
- (void)setInventoriesOfPackage:(NSMutableDictionary *) md{
    _inventoriesOfPackage=md;
}

#pragma mark 获取sqllit数据
- (NSArray*)getLoaclData:(NSString *) tableName SortDescriptorKey:(NSString *) sortDescriptorKey{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:sortDescriptorKey ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc]
                                initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest: fetchRequest error:&error];
    fetchRequest=nil;
    entity=nil;
    sortDescriptor=nil;
    sortDescriptors=nil;
    context=nil;
    return array;
}

- (void)getData{
    _categories=nil;
    [_inventoriesOfCategory removeAllObjects];
    NSArray *inv = [self getLoaclData:@"Inventory" SortDescriptorKey:@"sort"];
    NSArray *pkg = [self getLoaclData:@"Packages" SortDescriptorKey:@"code"];
    NSArray *cat = [self getLoaclData:@"InventoryCategory" SortDescriptorKey:@"code"];

    _categories = [[NSMutableArray alloc] init];
    for (int i=0; i<[cat count]; i++) {
        InventoryCategory *ic = [[InventoryCategory alloc] initWithManagedObject:[cat objectAtIndex:i]];
        [_categories addObject:ic];
        ic=nil;
    }
    cat=nil;
    
    _allInventories = [[NSMutableArray alloc] init];
    for (int i=0; i<[inv count]; i++) {
        OrderMenuInfo *omi=[[OrderMenuInfo alloc] initWithManagedObject:[inv objectAtIndex:i]];
        [_allInventories addObject:omi];
        omi=nil;
    }
    inv=nil;
    
    _inventoriesOfCategory = [[NSMutableDictionary alloc] init];
    for (int i=0; i<[_categories count]; i++) {
        InventoryCategory *ic = [_categories objectAtIndex:i];
        if ([[ic id] length]>0) {
            NSMutableArray *invOfCategory = [[NSMutableArray alloc] init];
            for (int j=0; j<[_allInventories count]; j++) {
                OrderMenuInfo *omi = [_allInventories objectAtIndex:j];
                if ([[ic id] isEqualToString:[omi categoryId]]) {
                    [invOfCategory addObject:omi];
                }
                omi=nil;
            }
            [_inventoriesOfCategory setObject:invOfCategory forKey:[ic id]];
            invOfCategory=nil;
        }
        ic=nil;
    }
    
    NSMutableArray *recommandArray=[[NSMutableArray alloc] init];
    for (int i=0; i<[_allInventories count]; i++) {
        OrderMenuInfo *omi = [_allInventories objectAtIndex:i];
        if([[omi isRecommend] boolValue])
        {
            [recommandArray addObject:omi];
        }
        omi=nil;
    }
    
    [_inventoriesOfCategory setObject:recommandArray forKey:@"this is a recommend category"];
    //[recommandArray removeAllObjects];
    recommandArray=nil;
    
    _inventoriesOfPackage = [[NSMutableDictionary alloc] init];
    for (int i=0; i<[pkg count]; i++) {
        NSManagedObject *mo = [pkg objectAtIndex:i];
        NSString *strPackageId = [mo localPackageId];
        PackageInfo *pi = [[PackageInfo alloc] initWithManagedObject:mo];
        id hiop = [_inventoriesOfPackage objectForKey:strPackageId];
        if (hiop==nil) {
            NSMutableArray *invOfPackage = [[NSMutableArray alloc] init];
            [invOfPackage addObject:pi];
            [_inventoriesOfPackage setObject:invOfPackage forKey:strPackageId];
            //[invOfPackage removeAllObjects];
            invOfPackage=nil;
        }
        else{
            [hiop addObject:pi];
        }
        hiop=nil;
        pi=nil;
        strPackageId=nil;
        mo=nil;
    }
    pkg=nil;
}

#pragma mark 获取桌台信息
- (NSMutableArray*)getOrderDeskInfo{
    if (![self getJSONData:@"/Service1/GetOrderDeskInfo"]) {
        return nil;
    }
    NSArray *deskArray=[self jsonToObj:urlData];
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in deskArray) {
        OrderDeskInfo *odi = [[OrderDeskInfo alloc] initWithDictionary:dict];
        [retArray addObject:odi];
        odi=nil;
    }
    deskArray=nil;
    return retArray;
}

#pragma mark 获取预订信息
- (NSMutableArray*)getOrderBookDeskInfo{
    if (![self getJSONData:@"/Service1/GetOrderBookDeskInfo"]) {
        return nil;
    }
    NSArray *deskArray = [self jsonToObj:urlData];
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in deskArray) {
        OrderBookDeskInfo *obdi = [[OrderBookDeskInfo alloc] initWithDictionary:dict];
        [retArray addObject:obdi];
        obdi=nil;
    }
    deskArray=nil;
    return retArray;
}

#pragma mark 套餐
- (void)showAlertView:(OrderMenuInfo*)omi
                  btn:(MyButton*)btn{
    NSMutableArray *invOfPackage = [_inventoriesOfPackage objectForKey:omi.invId];
    NSString *fixTitle=@"套餐必选内容：\n";
    if (invOfPackage) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSMutableArray *listOfOptionGroup = [[NSMutableArray alloc] init];
        NSMutableArray *fixGroup = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[invOfPackage count]; i++) {
            PackageInfo *pi = [invOfPackage objectAtIndex:i];
            if(pi.isOptional && [pi.isOptional boolValue]){
                NSString *did = [NSString stringWithFormat:@"OG_%@",pi.optionalGroup];
                id hiop = [dict objectForKey:did];
                if(hiop==nil){
                    NSMutableArray *invOfPackage = [[NSMutableArray alloc] init];
                    [invOfPackage addObject:pi];
                    
                    [dict setObject:invOfPackage forKey:did];
                    [listOfOptionGroup addObject:pi.optionalGroup];
                }
                else{
                    [hiop addObject:pi];
                }
            }
            else{
                [fixGroup addObject:pi];
                fixTitle = [NSString stringWithFormat:@"%@%@\n",fixTitle,pi.name];
            }
        }
 
        if([listOfOptionGroup count]>0){
            NSMutableArray *listOfItems = [[NSMutableArray alloc] init];
            for (int i=0; i<[listOfOptionGroup count]; i++) {
                NSString *did = [listOfOptionGroup objectAtIndex:i];
                NSDictionary *countriesToLiveInDict = [NSDictionary dictionaryWithObject:[dict objectForKey:[NSString stringWithFormat:@"OG_%@",did]] forKey:did];
                
                
                [listOfItems addObject:countriesToLiveInDict];
            }
            
            MLTableAlert* alert = [MLTableAlert tableAlertWithTitle:@"可选菜品" cancelButtonTitle:@"确定"
                                   numberOfSections:^NSInteger{
                                       return [listOfItems count];
                                   } titleForHeaders:^NSString *(NSInteger section) {
                                       NSDictionary *dictionary = [listOfItems objectAtIndex:section];
                                       NSString *did = [[dictionary.keyEnumerator allObjects] objectAtIndex:0];
                                       return did;
                                   }
                                    numberOfRows:^NSInteger (NSInteger section)
                                   {
                                       NSDictionary *dictionary = [listOfItems objectAtIndex:section];
                                       NSString *did = [[dictionary.keyEnumerator allObjects] objectAtIndex:0];
                                       NSArray *array = [dictionary objectForKey:did];
                                       return [array count];
                                   }
                                   andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                                   {
                                       static NSString *CellIdentifier = @"CellIdentifier";
                                       UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                                       if (cell == nil)
                                           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                                       
                                       NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
                                       NSString *did = [[dictionary.keyEnumerator allObjects] objectAtIndex:0];
                                       NSArray *array = [dictionary objectForKey:did];
                                       PackageInfo *pi = [array objectAtIndex:indexPath.row];
                                       cell.textLabel.text = pi.name;
                                       
                                       return cell;
                                   }];
            
            alert.height = 350;
            
            [alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
                
            } andCompletionBlock:^{
                NSLog(@"CompletionBlock");
                NSArray *selectedRows = [alert.table indexPathsForSelectedRows];
                NSMutableArray *selectedPackage = [[NSMutableArray alloc]init];

                if ([selectedRows count] != [alert.table numberOfSections] ) {
                    [[[UIAlertView alloc] initWithTitle:@"选择可选菜品" message:@"每个可选组必须选一个，且只能选一个" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    return;
                }
                for (NSIndexPath *selectionIndex in selectedRows){
                    NSDictionary *dict = [listOfItems objectAtIndex:selectionIndex.section];
                    //secs+=selectionIndex.section;
                    NSString *did = [[dict.keyEnumerator allObjects] objectAtIndex:0];
                    NSMutableArray *lpi = [dict objectForKey:did];
                    PackageInfo *pi = [lpi objectAtIndex:selectionIndex.row];
                    [selectedPackage addObject:pi];
                }

                [self selectPackage:fixGroup optionGroup:selectedPackage omi:omi btn:btn];
            }];
            [alert show];
        }
        else{
            NSMutableArray *listOfItems = [[NSMutableArray alloc] init];
            [self selectPackage:fixGroup optionGroup:listOfItems omi:omi btn:btn];
        }
    }
}
- (void)selectPackage:(NSMutableArray *)fixGroup
            optionGroup:(NSMutableArray *)optionGroup
                  omi:(OrderMenuInfo *)omi
                  btn:(MyButton*)btn{
    [self InitOrderInfo];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (int i=0; i<[_orderInfo.lOrderMenu count]; i++) {
        OrderMenuInfo *omi = [_orderInfo.lOrderMenu objectAtIndex:i];
        if(omi.isPackage && [omi.isPackage boolValue]){
            if (omi.packageId && ![omi.packageId isEqualToString:@"00000000-0000-0000-000000000000"]) {
                NSNumber *isn = [dict objectForKey:omi.packageId];
                if (isn==nil) {
                    if (omi.packageSn && omi.packageSn>0) {
                        [dict setObject:omi.packageSn forKey:omi.packageId];
                    }
                    else{
                        [dict setObject:[NSNumber numberWithInt:1] forKey:omi.packageId];
                    }
                }
                else{
                    if (omi.packageSn && omi.packageSn>isn ) {
                        isn = omi.packageSn;
                        [dict setObject:isn forKey:omi.packageId];
                    }
                }
                
            }
        }
    }

    if ([optionGroup count]>0) {
        [fixGroup addObjectsFromArray:optionGroup];
    }
    
    for (int i=0; i< [fixGroup count]; i++) {
        PackageInfo *pi = [fixGroup objectAtIndex:i];
        for (int j=0; j<[_allInventories count]; j++) {
            OrderMenuInfo *alloi = [_allInventories objectAtIndex:j];
            if ([alloi.invId isEqualToString:pi.inventoryId]) {
                OrderMenuInfo *oi = [alloi copy];
                oi.quantity=[NSDecimalNumber one];
                oi.amount = pi.salePrice;
                oi.salePrice = pi.salePrice;
                oi.comment=@"TC";
                oi.isPackage=[NSDecimalNumber one];
                oi.packageId = pi.packageId;
                oi.isAdd = [NSNumber numberWithInt:1];
                NSNumber *obj = [dict objectForKey:oi.packageId];
                if (obj==nil) {
                    oi.packageSn=[NSNumber numberWithInt:1];
                }
                else{
                    oi.packageSn= [NSNumber numberWithInt:[obj intValue]+1];
                }
                
                [_orderInfo.lOrderMenu addObject:oi];
                oi=nil;
            }
        }
    }
    [_orderInfo.lPackage addObject:omi];
    
    UIImage *img = [UIImage imageNamed:@"ticket-add.png"];
    [btn setImage:img forState:UIControlStateNormal];
    img=nil;
}

#pragma mark 开台
- (BOOL)postOpenData:(NSString*)username
              passwd:(NSString*)passwd
              deskno:(NSString*)deskno
            quantity:(NSNumber*) quantity{
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:username,@"userName",passwd,@"passwd",deskno,@"deskNo",quantity,@"quantity", nil];
        if ([self postJSONData:@"/Service1/OpenDesk" dict:dict]) {
            return YES;
        }
        return NO;
    
}


-(void)openLogon{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"开台" message:@"登录后开台" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"登录", nil];
    alertview.tag = 2;
    alertview.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
    UITextField* t1 = [alertview textFieldAtIndex:0];
    t1.placeholder=@"用户名";
    UITextField* t2 = [alertview textFieldAtIndex:1];
    t2.placeholder=@"密码";
    [alertview show];
}

#pragma mark 获取订单
- (BOOL)getOrderData:(NSString*)userName passwd:(NSString*)passwd deskno:(NSString *)deskno{
    if (![self getJSONData:[NSString stringWithFormat:@"%@/%@/%@/%@", @"/Service1/GetOrder",userName,passwd,deskno]]) {
        return NO;
    }
    return YES;
}
- (NSMutableArray*)getOrderMenuInfo:(NSArray*)array{
    NSMutableArray *marray = [[NSMutableArray alloc]init];
    if (array==nil || [array count]==0) {
        return marray;
    }
    for (int i=0; i<[array count]; i++) {
        NSDictionary* dict = [array objectAtIndex:i];
        OrderMenuInfo* omi = [[OrderMenuInfo alloc] initWithDictionary:dict];
        [marray addObject:omi];
    }
    return marray;
}
- (NSMutableArray*)getLackMenuInfo:(NSArray*)array{
    NSMutableArray *marray = [[NSMutableArray alloc]init];
    if (array==nil || [array count]==0) {
        return marray;
    }
    for (int i=0; i<[array count]; i++) {
        NSDictionary* dict = [array objectAtIndex:i];
        MenuStatus* ms = [[MenuStatus alloc] initWithDictionary:dict];
        [marray addObject:ms];
        if (ms.status && [ms.status isEqualToNumber:[NSNumber numberWithInt:Lack]]) {
        for (OrderMenuInfo *omi in _allInventories) {
            if ([ms.inventory isEqualToString:omi.invId]) {
                omi.status=ms.status;
            }
        }
        }
    }
    return marray;
}
- (void)getOrderInfo:(NSDictionary *)dict{
    _orderInfo = [[OrderInfo alloc] init];
    _orderInfo.orderDesk = [[OrderDeskInfo alloc] initWithDictionary:[dict remoteOrderDesk]];
    _orderInfo.lOrderMenu = [self getOrderMenuInfo:[dict remotelOrderMenu]];
    _orderInfo.lLackMenu = [self getLackMenuInfo:[dict remotelLackMenu]];
    //[self getData];
    [_mainViewController reloadData];
}



#pragma mark 下单
- (BOOL)postOrderData{
    NSDictionary *dictOrderDesk = [_orderInfo.orderDesk toDictionary];
    NSMutableArray *arrayOrderMenu = [[NSMutableArray alloc] init];
    for (int i=0; i<[_orderInfo.lOrderMenu count]; i++) {
        NSDictionary *dictOrderMenu = [[_orderInfo.lOrderMenu objectAtIndex:i] toDictionary];
        [arrayOrderMenu addObject:dictOrderMenu];
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:dictOrderDesk,@"orderDesk",arrayOrderMenu,@"lOrderMenu", nil];
    if ([self postJSONData:@"/Service1/Order" dict:dict]) {
        return YES;
    }
    return NO;
}
- (BOOL)order{
    if ([self postOrderData]) {
        [self getOrderInfo:[self jsonToObj:urlData]];
        return YES;
    }
    return NO;
}

#pragma mark 判断是否已订购
- (BOOL)haveOrderInv:(NSString*)invId{
    if (_orderInfo==nil) {
        return NO;
    }
    BOOL result = NO;
    if ([_orderInfo lOrderMenu] != nil) {
        result = [[[_orderInfo lOrderMenu] filteredArrayUsingPredicate:
                   [NSPredicate predicateWithFormat:@"invId == %@", invId]] count]>0;
    }
    if (!result && [_orderInfo lPackage]!=nil) {
        result = [[[_orderInfo lPackage] filteredArrayUsingPredicate:
                   [NSPredicate predicateWithFormat:@"invId == %@", invId]] count]>0;
    }
    return result;
}
//-(void)didSelectRowAtIndex:(NSInteger)row withContext:(id)context tableView:(UITableView *)tableView data:(NSArray *)data invName:(NSString *)packageName btn:(MyButton *)btn{
//    if (row==-1) {
//        [self selectPackage:context tableView:tableView data:data addButton:btn invName:packageName btn:btn];
//    }
//}
- (void)InitOrderInfo{
      if (!_orderInfo) {
          _orderInfo = [[OrderInfo alloc] init];
          if (!_orderInfo.lOrderMenu) {
              _orderInfo.lOrderMenu = [[NSMutableArray alloc] init];
          }
          if (!_orderInfo.lPackage) {
              _orderInfo.lPackage = [[NSMutableArray alloc] init];
          }
          if (!_orderInfo.lLackMenu) {
            _orderInfo.lLackMenu = [[NSMutableArray alloc] init];
        }
    }
}
+ (void)ClearOrderInfo{
    if (_orderInfo) {
        if (_orderInfo.lOrderMenu) {
            [_orderInfo.lOrderMenu removeAllObjects];
            _orderInfo.lOrderMenu=nil;
        }
        if (_orderInfo.lPackage) {
            [_orderInfo.lPackage removeAllObjects];
            _orderInfo.lPackage=nil;
        }
        if (_orderInfo.lLackMenu) {
            [_orderInfo.lLackMenu removeAllObjects];
            _orderInfo.lLackMenu=nil;
        }
        if (_orderInfo.orderDesk) {
            _orderInfo.orderDesk=nil;
        }
        _orderInfo=nil;
    }
    
}
-(void)orderMenu:(id)sender{
    MyButton *btn= (MyButton*)sender;
    OrderMenuInfo *omi = [btn omi];
    if(omi){
        if(omi.isPackage && [omi.isPackage boolValue]){
            [self showAlertView:omi btn:btn];
        }
        else{
            OrderMenuInfo *oi = [omi copy];
            oi.quantity=[NSDecimalNumber one];
            oi.amount=omi.salePrice;
            oi.comment=nil;
            oi.isAdd = [NSNumber numberWithInt:1];
            [self InitOrderInfo];
            [_orderInfo.lOrderMenu addObject:oi];
            oi=nil;
            UIImage *img = [UIImage imageNamed:@"ticket-add.png"];
            [btn setImage:img forState:UIControlStateNormal];
            img=nil;
        }
    }
}
- (void)menuButtonImgAndAction:(MyButton*)btn{
    OrderMenuInfo *omi = btn.omi;
    if([self haveOrderInv:omi.invId]){
        NSString *imageName = @"ticket-add.png";
        if (omi.status && [omi.status isEqualToNumber:[NSNumber numberWithInt:Lack]]) {
            imageName=@"1372624615_button_fewer.png";
        }
        UIImage *img = [UIImage imageNamed:imageName];
        [btn setImage:img forState:UIControlStateNormal];
        img=nil;
        if (omi.status && [omi.status isEqualToNumber:[NSNumber numberWithInt:Lack]]) {
            //[btn addTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
            [btn removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [btn addTarget:self action:@selector(orderMenu:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else
    {
        NSString *imageName = @"Add-32.png";
        if (omi.status && [omi.status isEqualToNumber:[NSNumber numberWithInt:Lack]]) {
            imageName=@"1372624615_button_fewer.png";
        }
        UIImage *addImg = [UIImage imageNamed:imageName];
        imageName=nil;
        [btn setImage:addImg forState:UIControlStateNormal];
        addImg=nil;
        if (omi.status && [omi.status isEqualToNumber:[NSNumber numberWithInt:Lack]]) {
            //[btn addTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
            [btn removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [btn addTarget:self action:@selector(orderMenu:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
@end
