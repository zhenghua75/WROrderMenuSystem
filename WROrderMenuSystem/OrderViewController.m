//
//  OrderViewController.m
//  OrderMenuSystem
//
//  Created by zheng hua on 11-9-20.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderViewDataSource.h"
#import "WROrderMenuSystemAppDelegate.h"
#import "OrderInventory.h"

@implementation OrderViewController

@synthesize popoverController,myDeskPopOver,myMenuPopOver;


-(BOOL)commitInv:(OrderInventory*)orderInventory {
//    NSString *path = [[NSBundle mainBundle] pathForResource:  
//                      @"Property List" ofType:@"plist"];  
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSString *serverAddress = [dict objectForKey:@"ServerAddress"]; 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *serverAddress = [defaults stringForKey:@"ServerAddress"];
    TTURLRequest *request = [TTURLRequest requestWithURL:[NSString stringWithFormat: @"%@%@",serverAddress,[NSString stringWithFormat:@"%@/%@/%@/%d", @"/Service1/OrderDish",[WROrderMenuSystemAppDelegate deskNo],orderInventory.invId,orderInventory.count]] delegate:self];
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    [request setResponse: [[TTURLDataResponse alloc] init]];
    [request sendSynchronously];
    return [[[[NSString alloc] initWithData:((TTURLDataResponse*)request.response).data encoding:NSASCIIStringEncoding] lowercaseString] isEqualToString:@"true"];
}
-(void)btncommitclick{
    NSMutableArray* array = [WROrderMenuSystemAppDelegate inventories];
    if ([array count]==0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提交" message:@"请首先点菜！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
    }
    else{
    for (int i=0; i<[array count]; i++) {
        if([self commitInv:[array objectAtIndex:i]]){
            //提交成功
        }
        else{
            //提交失败
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提交" message:@"提交失败，请再次提交！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            //[alert release];
        }
    }
    }
}
- (void)showMenuPopover:(id)sender
{
	if(![popoverController isPopoverVisible]){
		myMenuPopOver = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
		popoverController = [[UIPopoverController alloc] initWithContentViewController:myMenuPopOver];
		myMenuPopOver.popoverController = popoverController;
		[popoverController setPopoverContentSize:CGSizeMake(299.0f, 222.0f)];
		[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}else{
		[popoverController dismissPopoverAnimated:YES];
	}
}
-(void)btngetmenuclick{
    [self showMenuPopover:self.navigationItem.rightBarButtonItem];
    [self updateView];
}
- (void)showDeskPopover:(id)sender
{
	if(![popoverController isPopoverVisible]){
		myDeskPopOver = [[DeskViewController alloc] initWithNibName:@"DeskViewController" bundle:nil];
		popoverController = [[UIPopoverController alloc] initWithContentViewController:myDeskPopOver];
		myDeskPopOver.popoverController = popoverController;
		[popoverController setPopoverContentSize:CGSizeMake(299.0f, 222.0f)];
		[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}else{
		[popoverController dismissPopoverAnimated:YES];
	}
}
-(void)btnopenclick{
    [self showDeskPopover:self.navigationItem.rightBarButtonItem];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的菜单";
        [self setEditing:YES];
        
        UIToolbar *tools = [[UIToolbar alloc]
                            initWithFrame:CGRectMake(0.0f, 0.0f, 203.0f, 44.01f)]; // 44.01 shifts it up 1px for some reason
        tools.clearsContextBeforeDrawing = NO;
        tools.clipsToBounds = NO;
        tools.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f]; // closest I could get by eye to black, translucent style.
        // anyone know how to get it perfect?
        tools.barStyle = -1; // clear background
        //tools.barStyle = UIBarStyleBlackTranslucent;
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
        
        // Create a standard refresh button.
        UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target: self action:@selector(btncommitclick)];
        [buttons addObject:bi];
        //[bi release];
        
        // Create a spacer.
        bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        bi.width = 12.0f;
        [buttons addObject:bi];
        //[bi release];
        
        // Add profile button.
        bi = [[UIBarButtonItem alloc] initWithTitle:@"获取菜单" style:UIBarButtonItemStyleBordered target: self action:@selector(btngetmenuclick)]
       ; 
        [buttons addObject:bi];
        //[bi release];
        
        // Create a spacer.
        bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        bi.width = 12.0f;
        [buttons addObject:bi];
        //[bi release];
        
        bi = [[UIBarButtonItem alloc] initWithTitle:@"开台" style:UIBarButtonItemStyleBordered target: self action:@selector(btnopenclick)];
        [buttons addObject:bi];
        //[bi release];
        
        // Add buttons to toolbar and toolbar to nav bar.
        [tools setItems:buttons animated:NO];
        //[buttons release];
        UIBarButtonItem *twoButtons = [[UIBarButtonItem alloc] initWithCustomView:tools];
        //[tools release];
        self.navigationItem.rightBarButtonItem = twoButtons;
        //[twoButtons release];
        
        self.navigationBarStyle = UIBarStyleBlackTranslucent;
        self.navigationBarTintColor = [UIColor colorWithWhite:0.305f alpha:0.0f];
    }
    return self;
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    UINavigationBar *navbar = [[self navigationController] navigationBar];
//    [navbar setBarStyle:UIBarStyleBlackTranslucent];
//}
- (void) createModel{
    self.dataSource = [OrderViewDataSource orderViewDataSource];
}


@end
