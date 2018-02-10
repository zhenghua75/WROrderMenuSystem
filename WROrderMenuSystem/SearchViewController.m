//
//  SearchViewController.m
//  WROrderMenuSystem
//
//  Created by zheng hua on 11-10-8.
//  Copyright 2011年 kmdx. All rights reserved.
//

#import "SearchViewController.h"
#import "InventoryCategory.h"
#import "WROrderMenuSystemAppDelegate.h"

@implementation SearchViewController

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
}

#pragma mark - View lifecycle
-(void)getCurInv:(NSString*)categoryId{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dict = [delegate inventoriesOfCategory];
    self.inventory = [dict objectForKey:categoryId];
    dict=nil;
    delegate=nil;
}
-(void)getarray{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSArray *arrayCategory = [ NSArray arrayWithArray:[[delegate categories] allObjects]];
    self.inventoryCategory = [[NSMutableArray alloc] init];
    self.inventoryCategory2 = [[NSMutableArray alloc] init];
    for (int i=0; i<[arrayCategory count]; i++) {
        if (![[arrayCategory objectAtIndex:i] isMemberOfClass:[InventoryCategory class]]) {
            continue;
        }
        InventoryCategory *category = [arrayCategory objectAtIndex:i];
        if (category.code.length>5) {
            [self.inventoryCategory2 addObject:category];
        }
        else{
            [self.inventoryCategory addObject:category];
        }
        category=nil;
        //categoryCode=nil;
    }
    arrayCategory=nil;
    delegate=nil;
}
- (void)loadView {
    [super loadView];
    //[self setWantsFullScreenLayout:YES];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
}
- (PhotoDataSource *)data
{
    if (data_) {
        return data_;
    }
    
    data_ = [[PhotoDataSource alloc] initWithRecommend];
    return data_;
}
-(void)searchview{
    if (!_searchViewController) {
        _searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    }
    [self.navigationController pushViewController:_searchViewController animated:YES];
}
-(void)s1scroll{
    CGPoint offset = _scrollView.contentOffset;
    offset.y+=4;
    if (offset.y>_scrollView.contentSize.height-620-155) {
        offset.y=0;
    }
    
    if ( _scrollView.tracking ) return;
    if ( _scrollView.dragging ) return;
    if ( _scrollView.zooming ) return;
    if ( _scrollView.decelerating ) return;
    
    _scrollView.contentOffset = offset;
}

-(void)setcomponent2:(NSInteger)row{
    if ([self.inventory count]>0) {
        orderInventory = [self.inventory objectAtIndex:row];
        [_imageButton setImage:[UIImage imageWithContentsOfFile:orderInventory.imageFileName] forState:UIControlStateNormal];
        NSString *price = [NSString stringWithFormat:@"￥%.2f元",[orderInventory.salePrice doubleValue]];
        [self setTitle:[NSString stringWithFormat:@"%@ %@",orderInventory.invName,price]];
        price=nil;
        id delegate = [[UIApplication sharedApplication] delegate];
        addButton.omi = orderInventory;
        [delegate menuButtonImgAndAction:addButton];
    }
}
- (void)setcomponent2{
    [self setcomponent2:0];
}
- (void)backToFront{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSMutableString * path = [[NSMutableString alloc] initWithString:documentPath];
    [path appendFormat:@"/%@",@"middle-split.tif"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    if (!img) {
        img = [UIImage imageNamed:@"middle-split.tif"];
    }
    
    self.imageView.image=img;
    img=nil;
    
    [self getarray];
    if ([self.inventoryCategory count]>0) {
        InventoryCategory *category = [self.inventoryCategory objectAtIndex:0];
        [self setCategoryId:category.id];
        [self getCurInv:category.id];
        category=nil;
    }
    if ([self.inventoryCategory2 count]>0) {
        InventoryCategory *category = [self.inventoryCategory2 objectAtIndex:0];
        [self setCategoryId:category.id];
        [self getCurInv:category.id];
        category=nil;
    }
    [self setDataSource:[self data]];
    // Set default values.
    [_scrollView setThumbsHaveBorder:YES];
    [_scrollView setThumbsPerRow:NSIntegerMin];
    [_scrollView setThumbSize:CGSizeMake(240, 163)];
    [_scrollView setReusableThumbViews:[[NSMutableSet alloc] init]];
    [_scrollView setFirstVisibleIndex:(int)NSIntegerMax];
    [_scrollView setLastVisibleIndex:(int)NSIntegerMin];
    [_scrollView setLastItemsPerRow:(int)NSIntegerMin];
    
    [_scrollView setDataSource:self];
    //[_scrollView setController1:self];
    [_scrollView setScrollsToTop:YES];
    [_scrollView setScrollEnabled:YES];
    [_scrollView setAlwaysBounceVertical:YES];
    [_scrollView setBackgroundColor:[UIColor blackColor]];

    if ([_dataSource respondsToSelector:@selector(thumbsHaveBorder)]) {
        [_scrollView setThumbsHaveBorder:[_dataSource thumbsHaveBorder]];
    }
    
    if ([_dataSource respondsToSelector:@selector(thumbSize)]) {
        [_scrollView setThumbSize:[_dataSource thumbSize]];
    }
    
    if ([_dataSource respondsToSelector:@selector(thumbsPerRow)]) {
        [_scrollView setThumbsPerRow:[_dataSource thumbsPerRow]];
    }

    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    //toolbar.translucent=NO;
    
    _deskNo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [_deskNo setText:[WROrderMenuSystemAppDelegate orderInfo].orderDesk.deskNo];
    [_deskNo setTextColor:[UIColor yellowColor]];
    [_deskNo setBackgroundColor:[UIColor clearColor]];
    
    UILabel *lblDeskNo1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 35, 44)];
    [lblDeskNo1 setText:@"号桌"];
    [lblDeskNo1 setTextColor:[UIColor whiteColor]];
    [lblDeskNo1 setBackgroundColor:[UIColor clearColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, 44)];
    [view addSubview:_deskNo];
    [view addSubview:lblDeskNo1];
    lblDeskNo1=nil;
    
    UIBarItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                     target:nil 
                                                                     action:nil];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    [buttons addObject:space];
    [buttons addObject:item2];
    item2=nil;
    [buttons addObject:space];
    [toolbar setItems:buttons animated:NO];
    buttons=nil;
    [self.view addSubview:toolbar];
    toolbar=nil;
    
    
    NSMutableString * path1 = [[NSMutableString alloc] initWithString:documentPath];
    [path1 appendFormat:@"/%@",@"back-home-46.png"];
    UIImage *img1 = [UIImage imageWithContentsOfFile:path1];
    if (!img1) {
        img1 = [UIImage imageNamed:@"back-home-46.png"];
    }
    //UIImage *img = [UIImage imageNamed:@"back-home-46.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake( 0, 0, img1.size.width, 46.25 );
    [btn setImage:img1 forState:UIControlStateNormal];
    img1=nil;
    [btn addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton_ = [[UIBarButtonItem alloc] initWithCustomView:btn];
    btn=nil;
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:2];
    
    
    
    [toolbarItems addObject:space];
    [toolbarItems addObject:backButton_];
    backButton_=nil;
    CGRect toolbarFrame = CGRectMake(250, 646.75, 940-250, 61);
    UIToolbar *toolbar_ = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    [toolbar_ setBarStyle:UIBarStyleBlack];
    [toolbar_ setItems:toolbarItems];
    
    [[self view] addSubview:toolbar_];
    toolbar_=nil;
    
    addButton = [MyButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(940-50,50, 32, 32)];
    [self.view insertSubview:addButton aboveSubview:_imageButton];
    
    [self setcomponent2];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.scrollView reloadData];
    
    [self setcomponent2:[self.picker selectedRowInComponent:2]];
}

- (void)reloadThumbs {
    [_scrollView reloadData];
}
- (void)setDataSource:(id <KTPhotoBrowserDataSource>)newDataSource {
    _dataSource = newDataSource;
    [self reloadThumbs];
    newDataSource=nil;
}
- (void)didSelectThumbAtIndex:(NSUInteger)index thumbsView:(KTThumbsView *)thumbsView {
    
    OrderMenuInfo *oi = [_dataSource thumbImageAtIndex:index];
    
    id <KTPhotoBrowserDataSource> pickDataSource = [[PhotoDataSource alloc] initWithCategory:oi.categoryId];
    int selectedInventoryIndex = 0;
    for (int i=0;i<[pickDataSource numberOfPhotos];i++) {
        OrderMenuInfo *orderInv = [pickDataSource thumbImageAtIndex:i];
        if ([orderInv.invId isEqualToString:oi.invId]) {
            selectedInventoryIndex=i;
            break;
        }
        orderInv=nil;
    }
    KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc] 
                                                  initWithDataSource:pickDataSource 
                                                  andStartWithPhotoAtIndex:selectedInventoryIndex];
    
    [[self navigationController] pushViewController:newController animated:YES];
    oi=nil;
    pickDataSource=nil;
    newController=nil;
}

- (void)viewDidUnload
{
    [self setPicker:nil];
    [self setScrollView:nil];
    [self setImageButton:nil];
    [super viewDidUnload];
    [self setPicker:nil];
    [self setInventory:nil];
    [self setInventoryCategory:nil];
    [self setInventoryCategory2:nil];
    [self setCategoryId:nil];
    [self setDataSource:nil];
    [self setScrollView:nil];
    data_=nil;
    [self setImageButton:nil];
    _deskNo=nil;
    addButton=nil;
    orderInventory=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
#pragma mark KTThumbsViewDataSource

- (NSInteger)thumbsViewNumberOfThumbs:(KTThumbsView *)thumbsView
{
        NSInteger count = [_dataSource numberOfPhotos];
        return count;
}

- (KTThumbView *)thumbsView:(KTThumbsView *)thumbsView thumbForIndex:(NSInteger)index
{
        KTThumbView *thumbView = [thumbsView dequeueReusableThumbView];
        if (!thumbView) {
            CGRect frame = CGRectMake(0, 0, _scrollView.thumbSize.width, _scrollView.thumbSize.height);
            thumbView = [[KTThumbView alloc] initWithFrame:frame];
            [thumbView setController1:self];
            [thumbView setThumbsView:thumbsView];
        }
        
        if ([_dataSource respondsToSelector:@selector(thumbImageAtIndex:thumbView:)] == NO) {
            OrderMenuInfo *thumbImage = [_dataSource thumbImageAtIndex:index];
            [thumbView setThumbImage:thumbImage size:_scrollView.thumbSize image:thumbImage.image1];
            thumbImage=nil;
        } else {
            [_dataSource thumbImageAtIndex:index thumbView:thumbView];
        }
        
        return thumbView;
}

#pragma mark -
#pragma mark 处理方法
// 返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// 返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int count = 0;
    switch (component) {
        case 0:
            count = (int)[self.inventoryCategory count];
            break;
        case 1:
            count = (int)[self.inventoryCategory2 count];
            break;
        case 2:
            count = (int)[self.inventory count];
            break;
        default:
            break;
    }
    return count;
}

// 设置当前行的内容，若果行没有显示则自动释放
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title=nil;
    
    switch (component) {
        case 0:
            title = [[self.inventoryCategory objectAtIndex:row] name];
            break;
        case 1:
            title = [[self.inventoryCategory2 objectAtIndex:row] name];
            break;
        case 2:
            title = [[self.inventory objectAtIndex:row] invName];
            break;
        default:
            break;
    }
    return title;
 
}
-(void)updatearray:(NSString*)aCategoryCode{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSArray *arrayCategory = [NSArray arrayWithArray:[[delegate categories] allObjects]];
    
    self.inventoryCategory2 = [[NSMutableArray alloc] init];
    for (int i=0; i<[arrayCategory count]; i++) {
        InventoryCategory *category = [arrayCategory objectAtIndex:i];
        //NSString *categoryCode = [managedObject valueForKey:@"code"];
        if ([category.code hasPrefix:aCategoryCode] & ![category.code isEqualToString: aCategoryCode]) {
            //InventoryCategory *category = [[InventoryCategory alloc] init];
            //category.id = [managedObject valueForKey:@"id"];
            //category.code = categoryCode;
            //category.name = [managedObject valueForKey:@"name"];
            [self.inventoryCategory2 addObject:category];
            category=nil;
        }
        //categoryCode=nil;
        //managedObject=nil;
    }
    arrayCategory=nil;
    delegate=nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (row==-1) {
        return;
    }
    InventoryCategory *category = nil;
	int one_NewRow = (int)[pickerView selectedRowInComponent:1];
	int two_NewRow = (int)[pickerView selectedRowInComponent:2];
    
    switch (component) {
        case 0:
            category = [self.inventoryCategory objectAtIndex:row];
            [self updatearray:category.code];
            [_imageButton setImage:nil forState:UIControlStateNormal];
            orderInventory=nil;
            [addButton setImage:nil forState:UIControlStateNormal];
            if ([self.inventoryCategory2 count]>0) {
                if (one_NewRow+1>[self.inventoryCategory2 count]) {
                    one_NewRow=(int)[self.inventoryCategory2 count]-1;
                }
                if (one_NewRow>-1) {
                    category = [self.inventoryCategory2 objectAtIndex:one_NewRow];
                }
                else{
                    category = [self.inventoryCategory2 objectAtIndex:0];
                }
            }
            [self setCategoryId:category.id];
            [self getCurInv:category.id];
            if ([self.inventory count]>0) {
                if (two_NewRow+1>[self.inventory count]) {
                    two_NewRow=(int)[self.inventory count]-1;
                }
                if(two_NewRow>-1) {
                    orderInventory = [self.inventory objectAtIndex:two_NewRow];
                }
                else{
                    orderInventory = [self.inventory objectAtIndex:0];
                }
                [self setcomponent2];
            }

            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            break;
        case 1:
                category = [self.inventoryCategory2 objectAtIndex:row];
                [self setCategoryId:category.id];
                [self getCurInv:category.id];
                
            [_imageButton setImage:nil forState:UIControlStateNormal];
            orderInventory=nil;
            [addButton setImage:nil forState:UIControlStateNormal];
            [self setcomponent2];
            [pickerView reloadComponent:2];
            break;
        case 2:
            _selectedInventoryIndex = (int)row;
            orderInventory = [self.inventory objectAtIndex:row];
            [self setcomponent2:row];
            break;
        default:
            break;
    }
    category=nil;
}
- (IBAction)imgClick:(id)sender {
    id <KTPhotoBrowserDataSource> pickDataSource = [[PhotoDataSource alloc] initWithCategory:_categoryId];
    KTPhotoScrollViewController *newController = [[KTPhotoScrollViewController alloc] 
                                                  initWithDataSource:pickDataSource 
                                                  andStartWithPhotoAtIndex:_selectedInventoryIndex];
    [[self navigationController] pushViewController:newController animated:YES];
}
@end
