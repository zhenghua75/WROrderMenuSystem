//
//  MainViewController.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "MainViewController.h"
#import "WROrderMenuSystemAppDelegate.h"
#import "InventoryCategory.h"

@implementation MainViewController
-(void)setImg{
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
    [path appendFormat:@"/%@",@"left-86.png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    if (!img) {
        img = [UIImage imageNamed:@"left-86.png"];
    }
    self.imageView.image=img;
    img=nil;
    
    NSMutableString * path1 = [[NSMutableString alloc] initWithString:documentPath];
    [path1 appendFormat:@"/%@",@"logo.png"];
    UIImage *img1 = [UIImage imageWithContentsOfFile:path1];
    if (!img1) {
        self.imageLogoView.image=nil;
    }
    else{
        [self.imageLogoView setImage:img1];
        img1=nil;
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"%@",@"MainViewController-didReceiveMemoryWarning");
}

#pragma mark - View lifecycle
//搜索
-(void)buttonPress:(id)sender{
    //
    @autoreleasepool {
        UIButton *btn = (UIButton*)sender;
        id delegate = [[UIApplication sharedApplication] delegate];
        NSArray *array = [NSArray arrayWithArray:[[delegate categories] allObjects]];
        NSManagedObject *managedObject = [array objectAtIndex:btn.tag];
        PhotoDataSource *photoDataSource = [[PhotoDataSource alloc] initWithCategory:[managedObject valueForKey:@"id"]];
        [_navViewController setDataSource2:photoDataSource];
        managedObject=nil;
        photoDataSource=nil;
        array=nil;
        delegate=nil;
        btn=nil;
        
        UIViewController *vc = self.navigationController.visibleViewController;
        if ([vc isKindOfClass:[KTPhotoScrollViewController class]]) {
            KTPhotoScrollViewController *pvc = (KTPhotoScrollViewController*)vc;
            
            [pvc unloadPhoto:pvc.currentIndex];
            [pvc unloadPhoto:pvc.currentIndex + 1];
            [pvc unloadPhoto:pvc.currentIndex - 1];
            [pvc unloadPhoto:pvc.currentIndex + 2];
            [pvc unloadPhoto:pvc.currentIndex - 2];
            
            pvc=nil;
        }
        vc=nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.myPopoverController dismissPopoverAnimated:YES];
    }
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"popover dismissed");
}
-(void)twolevelmenu:(id)sender{
    UIButton *oneBtn = (UIButton*)sender;
    id delegate = [[UIApplication sharedApplication] delegate];
    NSArray *array = [NSArray arrayWithArray:[[delegate categories] allObjects]];
    InventoryCategory *oneIC = [array objectAtIndex:oneBtn.tag];
    NSString *oneCode = [oneIC code];
    
    int length = 0;
    int twocount=0;
    TwoLevelMenuViewController *_twoLevelMenuViewController=nil;
    
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSMutableString * path1 = [[NSMutableString alloc] initWithString:documentPath];
    [path1 appendFormat:@"/%@",@"StretchButton.png"];
    UIImage *normalButtonImage = [UIImage imageWithContentsOfFile:path1];
    if (!normalButtonImage) {
        normalButtonImage = [[UIImage imageNamed:@"StretchButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }
    else{
        normalButtonImage = [normalButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }
    
    NSMutableString * path2 = [[NSMutableString alloc] initWithString:documentPath];
    [path2 appendFormat:@"/%@",@"StretchButton-Highlighted.png"];
    UIImage *highlightedButtonImage = [UIImage imageWithContentsOfFile:path2];
    if (!highlightedButtonImage) {
        highlightedButtonImage = [[UIImage imageNamed:@"StretchButton-Highlighted.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }else{
        highlightedButtonImage = [highlightedButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }
    
    for (int i=0; i<[array count]; i++) {
        InventoryCategory *twoLevelIC = [array objectAtIndex:i];
        NSString *twoCode = [twoLevelIC code];
        
        if ([twoCode hasPrefix:oneCode] & ![twoCode isEqualToString: oneCode]) {
            
            UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [twoBtn setBackgroundImage:normalButtonImage forState:UIControlStateNormal];
            [twoBtn setBackgroundImage:highlightedButtonImage forState:UIControlStateHighlighted];
            
            
            [twoBtn setTitle:[twoLevelIC name] forState:UIControlStateNormal];
            twoBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:30];
            [twoBtn sizeToFit];
            twoBtn.tag=i;
            [twoBtn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            CGSize size = twoBtn.frame.size;
            CGFloat buttonWidth = size.width+1;
            [twoBtn setFrame:CGRectMake(length, 0, buttonWidth, 60)];
            [twoBtn setTag:i];
            length +=buttonWidth+1;
            if (_twoLevelMenuViewController==nil) {
                _twoLevelMenuViewController = [[TwoLevelMenuViewController alloc] initWithNibName:@"TwoLevelMenuViewController" bundle:nil];
                
                NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
                [path appendFormat:@"/%@",@"menu-two.png"];
                UIImage *img = [UIImage imageWithContentsOfFile:path];
                if (img) {
                    _twoLevelMenuViewController.view.backgroundColor=[[UIColor alloc] initWithPatternImage:img];
                }
            }
            [_twoLevelMenuViewController.view addSubview:twoBtn]; 
            twoBtn=nil;
            twocount++;
        }
        twoLevelIC=nil;
        twoCode=nil;
    }
    normalButtonImage=nil;
    highlightedButtonImage=nil;
    if (twocount>0) {
        if(![self.myPopoverController isPopoverVisible]){
            
            _myPopoverController = [[UIPopoverController alloc] initWithContentViewController:_twoLevelMenuViewController];
            _myPopoverController.delegate=self;
            _twoLevelMenuViewController=nil;
            
            CGRect screenBound = [[UIScreen mainScreen] bounds];
            CGSize screenSize = screenBound.size;
            CGFloat screenWidth = screenSize.width;
            CGFloat screenHeight = screenSize.height;
            
            [self.myPopoverController setPopoverContentSize:CGSizeMake(screenWidth-104, 61.0f)];
            
            [self.myPopoverController
             presentPopoverFromRect:CGRectMake(screenWidth, screenHeight-61, 0, 0)
             inView:self.view
             permittedArrowDirections:UIPopoverArrowDirectionDown
             animated:YES];
        }
        else{
            [self.myPopoverController dismissPopoverAnimated:YES];
        }
    } else {
        PhotoDataSource *photoDataSource = [[PhotoDataSource alloc] initWithCategory:[oneIC id]];
        [_navViewController setDataSource2:photoDataSource];
        photoDataSource=nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.myPopoverController dismissPopoverAnimated:YES];
    }
    
    oneCode=nil;
    oneIC=nil;
    array=nil;
    delegate=nil;
    oneBtn=nil;
    _twoLevelMenuViewController=nil;
}
- (void)setCurScrollView{
    scrollLength = 0;
    for(UIView *subview in [_scrollView subviews]) {
        if([subview isKindOfClass:[UIButton class]]) {
            //zhenghua 20180210
            dispatch_async(dispatch_get_main_queue(), ^{
                [subview removeFromSuperview];
            });
            
        } else {
            // Do nothing - not a UIButton or subclass instance
        }
    }
    id delegate = [[UIApplication sharedApplication] delegate];
    NSArray *array = [NSArray arrayWithArray:[[delegate categories] allObjects]];
    buttonCount=0;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSMutableString * path1 = [[NSMutableString alloc] initWithString:documentPath];
    [path1 appendFormat:@"/%@",@"StretchButton.png"];
    UIImage *normalButtonImage = [UIImage imageWithContentsOfFile:path1];
    if (!normalButtonImage) {
        normalButtonImage = [[UIImage imageNamed:@"StretchButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }
    else{
        normalButtonImage = [normalButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }
    
    NSMutableString * path2 = [[NSMutableString alloc] initWithString:documentPath];
    [path2 appendFormat:@"/%@",@"StretchButton-Highlighted.png"];
    UIImage *highlightedButtonImage = [UIImage imageWithContentsOfFile:path2];
    if (!highlightedButtonImage) {
        highlightedButtonImage = [[UIImage imageNamed:@"StretchButton-Highlighted.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }else{
        highlightedButtonImage = [highlightedButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    }
    
    for (int i=0; i<[array count]; i++) {
        if (![[array objectAtIndex:i] isMemberOfClass:[InventoryCategory class]]) {
            continue;
        }
        InventoryCategory *ic = [array objectAtIndex:i];
        NSString *code = [ic code];
        if (code.length<6) {
            NSString *title = [ic name];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:normalButtonImage forState:UIControlStateNormal];
            [btn setBackgroundImage:highlightedButtonImage forState:UIControlStateHighlighted];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:32.2];
            [btn sizeToFit];
            btn.tag=i;
            [btn addTarget:self action:@selector(twolevelmenu:) forControlEvents:UIControlEventTouchUpInside];
            CGSize size = btn.frame.size;
            CGFloat buttonWidth = size.width+1;
            [btn setFrame:CGRectMake(scrollLength, 0, buttonWidth, 60)];
            [btn setTag:i];
            //zhenghua 20180210
            dispatch_async(dispatch_get_main_queue(), ^{
                [_scrollView addSubview:btn];
            });
            
            btn=nil;
            code=nil;
            scrollLength +=buttonWidth+1;
            buttonCount++;
        }
        else
        {
            if (_categoryId2.length==0) {
                _categoryId2 = [ic id];
            }
            
        }
        code=nil;
        ic=nil;
    }
    normalButtonImage=nil;
    highlightedButtonImage=nil;
    
    CGSize size1 = CGSizeMake(screenWidth-84, 61);
    
    NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
    [path appendFormat:@"/%@",@"menu-one.png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    if (img) {
        _scrollView.backgroundColor = [UIColor clearColor];
        UIImageView* imageBackgroundView = [[UIImageView alloc] initWithImage:img];
        imageBackgroundView.frame = CGRectMake(84, 707, 940, 61);
        [self.view insertSubview:imageBackgroundView belowSubview:_scrollView];
    }
    [_scrollView setContentSize:size1];
    
    array=nil;
    delegate=nil;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setImg];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    [self.scrollView setDelegate:self];
    CGSize size = self.view.frame.size;
    scrollLength = 0;
    [self setCurScrollView];
    
    _navViewController = [[NavViewController alloc] initWithNibName:@"NavViewController" bundle:nil];
    [_navViewController setCategoryId:_categoryId];
    [_navViewController setCategoryId2:_categoryId2];
    [_navViewController.view setBounds:CGRectMake(0, 0, size.width-84, size.height-61)];
    [_navViewController.view setFrame:CGRectMake(0, 0, size.width-84,size.height-61)];
    
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_navViewController];
    _navigationController.delegate=_navViewController;
    [[_navigationController navigationBar] setBarStyle:UIBarStyleBlack];
    [[_navigationController navigationBar] setTranslucent:YES];

    [_navigationController.view setFrame:CGRectMake(84, 0, size.width-84, size.height-61)];
    [self.view addSubview:_navigationController.view];
}
-(void)reloadData{
    [self setCurScrollView];
    [_navViewController setCategoryId:_categoryId];
    [_navViewController setCategoryId2:_categoryId2];
    //[_navigationController loadView];
    [_navViewController reloadData];
    [self setImg];
}
- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [self setInfoButton:nil];
    [self setNavigationController:nil];
    [self setNavViewController:nil];
    [self setMainView:nil];
    [self setSysButton:nil];
    [self setMyPopoverController:nil];
    [self setCategoryId:nil];
    [self setCategoryId2:nil];
    [self setOrderViewController:nil];
    [self setSysButton:nil];
    //[self setAlertController:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)myMenuClick:(id)sender {
    if (self.orderViewController==nil) {
        self.orderViewController = [[OrderMenuViewController alloc] initWithNibName:@"OrderMenuViewController" bundle:nil];
    }
    
    if(_navigationController.visibleViewController != self.orderViewController){
        if ([_navigationController.viewControllers containsObject:self.orderViewController]) {
            [_navigationController popToViewController:self.orderViewController animated:YES];
        }
        else{
        [_navigationController pushViewController:self.orderViewController animated:YES];
        }
    }
}
- (IBAction)dragClick:(UIButton*)sender {
    [_navigationController popToRootViewControllerAnimated:YES];
    id delegate = [[UIApplication sharedApplication] delegate];
    if (delegate) {
        if ([delegate alertController]) {
            [self presentViewController:[delegate alertController] animated:YES completion:nil];
        }
    }
    
}
- (IBAction)infoClick:(id)sender {
    self.infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [_navigationController pushViewController:self.infoViewController animated:YES];
}
- (IBAction)helpClick:(id)sender {
    self.helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    [_navigationController pushViewController:self.helpViewController animated:YES];
}
@end
