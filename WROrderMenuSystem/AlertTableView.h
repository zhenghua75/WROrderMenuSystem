#import "MyButton.h"
@protocol AlertTableViewDelegate

-(void)didSelectRowAtIndex:(NSInteger)row
               withContext:(id)context
                 tableView:(UITableView*)tableView
                      data:(NSArray*)data
                   invName:(NSString*)packageName
                       btn:(MyButton*)btn;
@end

@interface AlertTableView : UIAlertView <UITableViewDelegate, UITableViewDataSource>{
    UITableView *myTableView;
    id<AlertTableViewDelegate> caller;
    id context;
    NSArray *data;
	int tableHeight;
    MyButton* _btn;
}

-(id)initWithCaller:(id<AlertTableViewDelegate>)_caller data:(NSArray*)_data title:(NSString*)_title andContext:(id)_context invName:(NSString*)packageName btn:(UIButton*)btn;

@property(nonatomic, retain) id<AlertTableViewDelegate> caller;
@property(nonatomic, retain) id context;
@property(nonatomic, retain) NSArray *data;
@property (nonatomic,strong) NSMutableArray *dict;
@property (nonatomic,strong) NSString *pkgName;
@end

@interface AlertTableView(HIDDEN)
-(void)prepare;
@end
