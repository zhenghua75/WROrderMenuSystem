//
//  MLTableAlert.m
//
//  Version 1.3
//
//  Created by Matteo Del Vecchio on 11/12/12.
//  Updated on 03/07/2013.
//
//  Copyright (c) 2012 Matthew Labs. All rights reserved.
//  For the complete copyright notice, read Source Code License.
//

#import "MLAlertView.h"

#define kCODialogAnimationDuration 0.15
#define kAlertViewWidth      284.0
#define kLateralInset         12.0
#define kVerticalInset         8.0
#define kMinAlertHeight      264.0
#define kButtonHeight         44.0
#define kButtonMargin          5.0
#define kLabelMargin          12.0
#define kInputTextFieldMargin  2.0

// Since orientation is managed by view controllers,
// MLTableAlertController is used under the MLTableAlert
// to provide support for orientation and rotation
@interface MLAlertViewController : UIViewController
@end

@implementation MLAlertViewController

// Orientation support
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		return YES;
	else
		return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	MLAlertView *av = [self.view.subviews lastObject];
	if (av != nil && [av isKindOfClass:[MLAlertView class]])
	{
		// Rotate the MLTableAlert if orientation changes
		// when it is visible on screen
		[UIView animateWithDuration:duration animations:^{
			[av sizeToFit];
			
			CGFloat x = CGRectGetMidX(self.view.bounds);
			CGFloat y = CGRectGetMidY(self.view.bounds);
			av.center = CGPointMake(x, y);
			av.frame = CGRectIntegral(av.frame);
		}];
	}
	else
		return;
}

@end


@interface MLAlertView ()
@property (nonatomic, strong) UIView *alertBg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIWindow *appWindow;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *msg;

@property (nonatomic, strong) NSString *okButtonTitle;
@property (nonatomic, strong) NSString *cancelButtonTitle;

//@property (nonatomic) BOOL cellSelected;

//@property (nonatomic, strong) MLTableAlertNumberOfSectionsBlock numberOfSections;
//@property (nonatomic, strong) MLTableAlertTitleForHeadersBlock titleForHeaders;

//@property (nonatomic, strong) MLTableAlertNumberOfRowsBlock numberOfRows;
//@property (nonatomic, strong) MLTableAlertTableCellsBlock cells;

-(void)createBackgroundView;	// Draws and manages the view behind the alert
-(void)animateIn;	 // Animates the alert when it has to be shown
-(void)animateOut;	 // Animates the alert when it has to be dismissed
-(void)dismissAlertView;	// Dismisses the alert
@end



@implementation MLAlertView

#pragma mark - MLTableAlert Class Method

+(MLAlertView *)alertViewWithTitle:(NSString *)title
                           msgTitle:(NSString*)msgTitle
                      okButtonTitle:(NSString*)okBtnTitle
                  cancelButtonTitle:(NSString *)cancelBtnTitle;
{
	return [[self alloc] initWithTitle:title
                              msgTitle:msgTitle
                         okButtonTitle:okBtnTitle
                     cancelButtonTitle:cancelBtnTitle];
}

#pragma mark - MLTableAlert Initialization
- (void) onKeyboardWillShow: (NSNotification*) note
{
	NSValue* v = [note.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey];
	CGRect kbframe = [v CGRectValue];
	kbframe = [self.superview convertRect: kbframe fromView: nil];
	
	if ( CGRectIntersectsRect( self.frame, kbframe) )
	{
		CGPoint c = self.center;
		
		if ( self.frame.size.height > kbframe.origin.y - 20 )
		{
			//self.maxHeight = kbframe.origin.y - 20;
			[self sizeToFit];
			[self layoutSubviews];
		}
		
		c.y = kbframe.origin.y / 2;
		
		[UIView animateWithDuration: 0.2
						 animations: ^{
							 self.center = c;
							 self.frame = CGRectIntegral(self.frame);
						 }];
	}
}

- (void) onKeyboardWillHide: (NSNotification*) note
{
	[UIView animateWithDuration: 0.2
					 animations: ^{
						 self.center = CGPointMake( CGRectGetMidX( self.superview.bounds ), CGRectGetMidY( self.superview.bounds ));
						 self.frame = CGRectIntegral(self.frame);
					 }];
}
-(id)initWithTitle:(NSString *)title
          msgTitle:(NSString*)msgTitle
     okButtonTitle:(NSString*)okBtnTitle
 cancelButtonTitle:(NSString *)cancelBtnTitle;
{
	self = [super init];
	if (self)
	{
		_title = title;
        _msg = msgTitle;
        _okButtonTitle = okBtnTitle;
		_cancelButtonTitle = cancelBtnTitle;
		_height = kMinAlertHeight;	// Defining default (and minimum) alert height
        _inputTextFields = [[NSMutableArray alloc]init];
	}
	
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector( onKeyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector( onKeyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    
	return self;
}

#pragma mark - Actions

-(void)configureCompletionBlock:(MLAlertViewCompletionBlock)comBlock
{
	self.completionBlock = comBlock;
}

-(void)createBackgroundView
{
	// reset cellSelected value
	//self.cellSelected = NO;
	
	// Allocating controller for presenting MLTableAlert
	MLAlertViewController *controller = [[MLAlertViewController alloc] init];
	controller.view.backgroundColor = [UIColor clearColor];
	
	// Creating new UIWindow to manage MLTableAlert and MLTableAlertController
	self.appWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.appWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
	self.appWindow.rootViewController = controller;
	self.appWindow.alpha = 0.0;
	self.appWindow.windowLevel = UIWindowLevelStatusBar;
	self.appWindow.hidden = NO;
	[self.appWindow makeKeyAndVisible];
	
	// Adding MLTableAlert as subview of MLTableAlertController (controller)
	[controller.view addSubview:self];
	
	// setting options to MLTableAlert
	self.frame = self.superview.bounds;
	self.opaque = NO;
	
	// get background color darker
	[UIView animateWithDuration:0.2 animations:^{
		self.appWindow.alpha = 1.0;
	}];
}

-(void)animateIn
{
	// UIAlertView-like pop in animation
	self.alertBg.transform = CGAffineTransformMakeScale(0.6, 0.6);
	[UIView animateWithDuration:0.2 animations:^{
		self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
	} completion:^(BOOL finished){
		[UIView animateWithDuration:1.0/15.0 animations:^{
			self.alertBg.transform = CGAffineTransformMakeScale(0.9, 0.9);
		} completion:^(BOOL finished){
			[UIView animateWithDuration:1.0/7.5 animations:^{
				self.alertBg.transform = CGAffineTransformIdentity;
			}];
		}];
	}];
}

-(void)animateOut
{
	[UIView animateWithDuration:1.0/7.5 animations:^{
		self.alertBg.transform = CGAffineTransformMakeScale(0.9, 0.9);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0/15.0 animations:^{
			self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:0.3 animations:^{
				self.alertBg.transform = CGAffineTransformMakeScale(0.01, 0.01);
				self.appWindow.alpha = 0.3;
			} completion:^(BOOL finished){
				// table alert not shown anymore
				[self removeFromSuperview];
				self.appWindow.hidden = YES;
				[self.appWindow resignKeyWindow];
			}];
		}];
	}];
}
-(void)addInputTextField:(UITextField*)inputTextField{
    [self.inputTextFields addObject:inputTextField];
}
-(void)dismissAlertView
{
	[self animateOut];
}
-(void)okAlertView{
    [self animateOut];
	
	if (self.completionBlock != nil)
        self.completionBlock();
}
-(void)show
{
	[self createBackgroundView];
	
	// alert view creation
	self.alertBg = [[UIView alloc] initWithFrame:CGRectZero];
	[self addSubview:self.alertBg];
	
	// setting alert background image
	UIImageView *alertBgImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"MLTableAlertBackground.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:30]];
	[self.alertBg addSubview:alertBgImage];
	
	// alert title creation
	self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.titleLabel.backgroundColor = [UIColor clearColor];
	self.titleLabel.textColor = [UIColor whiteColor];
	self.titleLabel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
	self.titleLabel.shadowOffset = CGSizeMake(0, -1);
	self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
	self.titleLabel.frame = CGRectMake(kLateralInset, 15, kAlertViewWidth - kLateralInset * 2, 22);
	self.titleLabel.text = self.title;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	[self.alertBg addSubview:self.titleLabel];
    float y=self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+kLabelMargin;
	//msg title creation
    if (self.msg) {
    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.msgLabel.backgroundColor = [UIColor clearColor];
	self.msgLabel.textColor = [UIColor whiteColor];
	self.msgLabel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
	self.msgLabel.shadowOffset = CGSizeMake(0, -1);
	self.msgLabel.font = [UIFont boldSystemFontOfSize:18.0];
	self.msgLabel.frame = CGRectMake(kLateralInset, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+kLabelMargin, kAlertViewWidth - kLateralInset * 2, 22);
	self.msgLabel.text = self.msg;
	self.msgLabel.textAlignment = NSTextAlignmentCenter;
	[self.alertBg addSubview:self.msgLabel];
        y=self.msgLabel.frame.origin.y+self.msgLabel.frame.size.height+kLabelMargin;
    }
    //inputTextFields creation
    
    for (UITextField* inputTextField in self.inputTextFields) {
        
        inputTextField.frame =CGRectMake(kLateralInset,y, kAlertViewWidth - kLateralInset * 2, 22);
        [self.alertBg addSubview:inputTextField];
        y=inputTextField.frame.origin.y+inputTextField.frame.size.height+kInputTextFieldMargin;
    }
    // ok button creation
    if (self.okButtonTitle) {
        self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.okButton.frame = CGRectMake(kLateralInset, y + kButtonMargin, kAlertViewWidth - kLateralInset * 2, kButtonHeight);
		self.okButton.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.okButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
		self.okButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
		self.okButton.titleLabel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
		[self.okButton setTitle:self.okButtonTitle forState:UIControlStateNormal];
		[self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.okButton setBackgroundColor:[UIColor clearColor]];
		[self.okButton setBackgroundImage:[[UIImage imageNamed:@"MLTableAlertButton.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
		[self.okButton setBackgroundImage:[[UIImage imageNamed:@"MLTableAlertButtonPressed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
		self.okButton.opaque = NO;
		self.okButton.layer.cornerRadius = 5.0;
		[self.okButton addTarget:self action:@selector(okAlertView) forControlEvents:UIControlEventTouchUpInside];
		[self.alertBg addSubview:self.okButton];
    }
	// cancel button creation
	if (self.cancelButtonTitle)
	{
		self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.cancelButton.frame = CGRectMake(kLateralInset, self.okButton.frame.origin.y + self.okButton.frame.size.height + kButtonMargin, kAlertViewWidth - kLateralInset * 2, kButtonHeight);
		self.cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
		self.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
		self.cancelButton.titleLabel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
		[self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
		[self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[self.cancelButton setBackgroundColor:[UIColor clearColor]];
		[self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"MLTableAlertButton.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
		[self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"MLTableAlertButtonPressed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
		self.cancelButton.opaque = NO;
		self.cancelButton.layer.cornerRadius = 5.0;
		[self.cancelButton addTarget:self action:@selector(dismissAlertView) forControlEvents:UIControlEventTouchUpInside];
		[self.alertBg addSubview:self.cancelButton];
	}
	
	// setting alert and alert background image frames
	self.alertBg.frame = CGRectMake((self.frame.size.width - kAlertViewWidth) / 2, (self.frame.size.height - self.height) / 2, kAlertViewWidth, self.height - kVerticalInset * 2);
	alertBgImage.frame = CGRectMake(0.0, 0.0, kAlertViewWidth, self.height);
	
	// the alert will be the first responder so any other controls,
	// like the keyboard, will be dismissed before the alert
	[self becomeFirstResponder];
	
	// show the alert with animation
	[self animateIn];
}



// Allows the alert to be first responder
-(BOOL)canBecomeFirstResponder
{
	return YES;
}

// Alert height setter
-(void)setHeight:(CGFloat)height
{
	if (height > kMinAlertHeight)
		_height = height;
	else
		_height = kMinAlertHeight;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
