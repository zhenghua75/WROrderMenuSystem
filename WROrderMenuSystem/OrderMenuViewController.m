//
//  OrderMenuViewController.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-26.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderMenuViewController.h"

@implementation OrderMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)resetTotalMoney{
    NSMutableArray *selectedInventories = [WROrderMenuSystemAppDelegate orderInfo].lOrderMenu;
    NSDecimalNumber *d = [NSDecimalNumber zero];
    for (int i=0; i<[selectedInventories count]; i++) {
        OrderMenuInfo *oi = [selectedInventories objectAtIndex:i];
        if (![oi.isDelete boolValue]) {
            d= [d decimalNumberByAdding:oi.amount];
        }
    }
    [self.totalMoney setText:[NSString stringWithFormat:@"%.2f",[d doubleValue]]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    [_toolbar setFrame:CGRectMake(0, screenHeight-71, screenWidth-75, 61)];
    //[_toolbar setFrame:CGRectMake(0, 697, 949, 61)];
    [self.tableView setScrollEnabled:YES];
    [self.tableView setScrollsToTop:YES];
    
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
    [path appendFormat:@"/%@",@"back-home-46.png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    if (!img) {
        img = [UIImage imageNamed:@"back-home-46.png"];
    }
    
    [self.button setImage:img forState:UIControlStateNormal];
    img=nil;
}
-(void)refreshView{
    [self.tableView reloadData];
    [self.deskNo setText:[WROrderMenuSystemAppDelegate orderInfo].orderDesk.deskNo];
    [self.count setText:[NSString stringWithFormat:@"%lu",(unsigned long)[[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu count]]];
    [self resetTotalMoney];
    NSDateFormatter *formatter;
    NSString        *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy年MM月dd日 cccc HH:mm"];
    dateString = [formatter stringFromDate:[NSDate date]];
    [self.currentDateTime setText:dateString];
    formatter=nil;
    dateString=nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [self refreshView];
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification 
											   object:nil]; 
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardWillHide:) 
												 name:UIKeyboardWillHideNotification 
											   object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void) keyboardWillShow:(NSNotification *)note { 
	NSDictionary *info = [note userInfo];
	CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	CGRect bkgndRect = self.tableView.frame;
    CGSize size = self.tableView.contentSize;
	bkgndRect.size.height += kbSize.height;
    size.height +=kbSize.height;
    self.tableView.contentSize=size;
} 

- (void)keyboardWillHide:(NSNotification*)aNotification{
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	
	
	NSDictionary *info = [aNotification userInfo];
	CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
	CGRect bkgndRect = self.tableView.frame;
	bkgndRect.size.height -= kbSize.height;
	CGSize size = self.tableView.contentSize;
    size.height-=kbSize.height;
    self.tableView.contentSize=size;
	[UIView commitAnimations];
	
}
- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setCurrentDateTime:nil];
    [self setDeskNo:nil];
    [self setCount:nil];
    [self setTotalMoney:nil];
    [self setToolbar:nil];
    [super viewDidUnload];
    titleViewController=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 22;
}
- (void)configureCell:(ShowMenuInfoCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
	NSMutableArray *selectedInventories = [WROrderMenuSystemAppDelegate orderInfo].lOrderMenu;
    OrderMenuInfo *oi = [selectedInventories objectAtIndex:indexPath.row];
    
    [[cell indexLabel] setText:[NSString stringWithFormat:@"%li",(long)indexPath.row +1]];
	[[cell nameLabel] setText:oi.invName];
    [[cell englishLabel] setText:oi.englishName];
	[[cell priceLabel] setText:[NSString stringWithFormat:@"%.2f",[oi.salePrice doubleValue]]];
    [[cell countLabel] setText:[NSString stringWithFormat:@"%d",[oi.quantity intValue]]];
    [[cell amountLabel] setText:[NSString stringWithFormat:@"%.2f",[oi.amount doubleValue]]];
    [[cell commentText] setText:oi.comment];
    [[cell statusLabel] setText:OrderMenuStatusDescription[[oi.status intValue]]];
    
    if (oi.status && ![oi.status isEqualToNumber:[NSNumber numberWithInt:Normal]]) {
        [cell.commentText setEnabled:NO];
        [cell.addBtn setEnabled:NO];
        [cell.subBtn setEnabled:NO];
    }
    
    if(oi.isPackage &&[oi.isPackage boolValue]){
        [cell.addBtn setEnabled:NO];
        [cell.subBtn setEnabled:NO];
    }
    
    oi=nil;
    selectedInventories=nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	ShowMenuInfoCell *cell = (ShowMenuInfoCell*)[tableView dequeueReusableCellWithIdentifier:@"OrderCell"];

	if (cell == nil) {
        UIViewController *cellViewController = [[UIViewController alloc] initWithNibName:@"ShowMenuInfoCell" bundle:nil];
        cell = (ShowMenuInfoCell*)cellViewController.view;
        cellViewController=nil;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
	}
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.showsReorderControl=YES;
    cell.tag = indexPath.row;
    
    [cell setOrderMenuViewController:self];
    [[cell subBtn] setTag:indexPath.row];
    [[cell addBtn] setTag:indexPath.row];
    [[cell commentText] setTag:indexPath.row];
    
	[self configureCell:cell forIndexPath:indexPath];
    
	return cell;
}


- (void)tableView:(UITableView *)ltableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *selectedInventories = [WROrderMenuSystemAppDelegate orderInfo].lOrderMenu;
    OrderMenuInfo *oi = [selectedInventories objectAtIndex:indexPath.row];
  
    if (oi.status) {
        if ([oi.status isEqualToNumber:[NSNumber numberWithInt:Ordered]]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"删除" message:@"前台已确认提交，不能删除！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            alert=nil;
            return;
        }
        switch ([oi.status intValue]) {
            case Normal:
                oi.isDelete=[NSNumber numberWithBool:YES];
                oi.status=[NSNumber numberWithInt:Withdraw];
                if (oi.isPackage && [oi.isPackage boolValue]) {
                    
                    for (OrderMenuInfo *omi2 in selectedInventories) {
                        if([omi2.packageId isEqualToString:oi.packageId] &&
                            [omi2.packageSn isEqualToNumber:oi.packageSn] &&
                           ![omi2.invId isEqualToString:oi.invId]){
                        omi2.isDelete=[NSNumber numberWithBool:YES];
                        omi2.status=[NSNumber numberWithInt:Withdraw];
                        }
                    }
                }
                break;
            case Withdraw:
                oi.status=[NSNumber numberWithInt:Normal];
                oi.isDelete=[NSNumber numberWithBool:NO];
                if (oi.isPackage && [oi.isPackage boolValue]) {
                    for (OrderMenuInfo *omi2 in selectedInventories) {
                        if([omi2.packageId isEqualToString:oi.packageId] &&
                           [omi2.packageSn isEqualToNumber:oi.packageSn] &&
                           ![omi2.invId isEqualToString:oi.invId]){
                        omi2.status=[NSNumber numberWithInt:Normal];
                        omi2.isDelete=[NSNumber numberWithBool:NO];
                        }
                    }
                }
                break;
            default:
                break;
        }
    }
    else{
        if (oi.isPackage && [oi.isPackage boolValue]) {
            NSArray *array = [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu copy];
            NSMutableArray *idxPathArray = [[NSMutableArray alloc]init];
            int i=0;
            for(OrderMenuInfo *omi in array){
                if([omi.packageId isEqualToString:oi.packageId] &&
                   [omi.packageSn isEqualToNumber:oi.packageSn]){
                    NSIndexPath *nip = [NSIndexPath indexPathForRow:i inSection:0];
                    [selectedInventories removeObject:omi];
                    [idxPathArray addObject:nip];
                    nip=nil;
                }
                i++;
            }
            if ([idxPathArray count]>0) {
            [ltableView deleteRowsAtIndexPaths:idxPathArray withRowAnimation:YES];
            [idxPathArray removeAllObjects];
            }
            idxPathArray=nil;
        }
        else{
            [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu removeObjectAtIndex:indexPath.row];
            [ltableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        }
    }
    
    [ltableView reloadData];
    [self resetTotalMoney];
    oi=nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderMenuInfo *oi = [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu objectAtIndex:indexPath.row];
    if (!oi.status||[oi.status isEqualToNumber:[NSNumber numberWithInt:Normal]]) {
        return  @"删除Delete";
    }
    return @"撤销删除Cancel";;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderMenuInfo *oi = [[WROrderMenuSystemAppDelegate orderInfo].lOrderMenu objectAtIndex:indexPath.row];
    if (!oi.status||[oi.status isEqualToNumber:[NSNumber numberWithInt:Normal]]||[oi.status isEqualToNumber:[NSNumber numberWithInt:Withdraw]]) {
        return  YES;
    }
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (titleViewController==nil) {
        titleViewController = [[UIViewController alloc] initWithNibName:@"OrderMenuCell" bundle:nil];
    }
    return titleViewController.view;
}

- (IBAction)backHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)submitClick:(id)sender {
    //[self.view setExclusiveTouch:YES];
    [self.tableView endEditing:YES];
    NSMutableArray* array = [WROrderMenuSystemAppDelegate orderInfo].lOrderMenu;
    if ([array count]==0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提交" message:@"请首先点菜！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        alert=nil;
    }
    else if([[[[WROrderMenuSystemAppDelegate orderInfo] orderDesk] deskNo] length]==0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提交" message:@"请首先选择桌台！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        alert=nil;
    }
    else if([[[[WROrderMenuSystemAppDelegate orderInfo] orderDesk] deskNo] length]==0)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提交" message:@"请首先选择桌台！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        alert=nil;
    }
    else{
        id delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate order]) {
            //提交成功
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提交" message:@"提交成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            //清空界面
//            [[[WROrderMenuSystemAppDelegate orderInfo] lOrderMenu] removeAllObjects];
//            [[WROrderMenuSystemAppDelegate orderInfo] setOrderDesk:nil];
//            [[WROrderMenuSystemAppDelegate orderInfo] setLOrderMenu:nil];
            [WROrderMenuSystemAppDelegate ClearOrderInfo];
            [self refreshView];
            alert=nil;
        }
    }

}
@end
