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

@class MLAlertView;


// Blocks definition for table view management
typedef void (^MLAlertViewCompletionBlock)(void);

@interface MLAlertView : UIView

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSMutableArray *inputTextFields;
@property (nonatomic, strong) MLAlertViewCompletionBlock completionBlock;	// Called when Cancel button pressed

+(MLAlertView *)alertViewWithTitle:(NSString *)title
                          msgTitle:(NSString*)msgTitle
                       okButtonTitle:(NSString*)okBtnTitle
                   cancelButtonTitle:(NSString *)cancelBtnTitle;

// Initialization method; rowsBlock and cellsBlock MUST NOT be nil
// Pass NIL to cancelButtonTitle to show an alert without cancel button
-(id)initWithTitle:(NSString *)title
          msgTitle:(NSString*)msgTitle
     okButtonTitle:(NSString*)okBtnTitle
 cancelButtonTitle:(NSString *)cancelBtnTitle;

// Allows you to perform custom actions when a row is selected or the cancel button is pressed
-(void)configureCompletionBlock:(MLAlertViewCompletionBlock)comBlock;
-(void)addInputTextField:(UITextField*)inputTextField;
// Show the alert
-(void)show;

@end

