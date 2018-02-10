#import "AlertTableView.h"
#import "PackageInfo.h"

@implementation AlertTableView

@synthesize  caller, context, data,dict,pkgName;

-(id)initWithCaller:(id)_caller data:(NSArray*)_data title:(NSString*)_title andContext:(id)_context invName:(NSString *)packageName btn:(MyButton *)btn{
    NSMutableString *messageString = [NSMutableString stringWithString:@"\n"];
    tableHeight = 0;
    int icount = 0;
    for (int i=0; i<[_data count]; i++) {
        icount=icount+1;
        NSDictionary *dictionary = [_data objectAtIndex:i];
        NSString *did = [[dictionary.keyEnumerator allObjects] objectAtIndex:0];
        NSArray *array = [dictionary objectForKey:did];
        for (int j=0; j<[array count]; j++) {
            icount=icount+1;
        }
    }
    if(icount < 5){
        for(int i = 0; i < icount; i++){
            [messageString appendString:@"\n\n"];
            //[messageString appendString:@"\n\n"];
            tableHeight += 44;
        }
    }else{
        for(int i = 0; i < 5; i++){
            [messageString appendString:@"\n\n"];
            //[messageString appendString:@"\n\n"];
            tableHeight += 44;
        }
        //tableHeight = 207;
    }
    [messageString appendString:@"\n"];
    if(self = [super initWithTitle:_title message:messageString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]){
        self.caller = _caller;
        self.context = _context;
        self.data = _data;
        self.pkgName=packageName;
        _btn=btn;
        [self prepare];
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.caller didSelectRowAtIndex:-1 withContext:self.context tableView:myTableView data:data invName:pkgName btn:_btn];
}

-(void)show{
    self.hidden = YES;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimer:) userInfo:nil repeats:NO];
    [super show];
}

-(void)myTimer:(NSTimer*)_timer{
    self.hidden = NO;
    [myTableView flashScrollIndicators];
}

-(void)prepare{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(11, 50, 261, tableHeight) style:UITableViewStylePlain];
    myTableView.allowsMultipleSelectionDuringEditing = YES;
    //myTableView.allowsMultipleSelection=YES;
    [myTableView setEditing:YES];
    //    if([data count] < 5){
    //        myTableView.scrollEnabled = NO;
    //    }
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self addSubview:myTableView];
    
    //    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 50, 261, 4)];
    //    imgView.image = [UIImage imageNamed:@"top.png"];
    //    [self addSubview:imgView];
    //
    //    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(11, tableHeight+46, 261, 4)];
    //    imgView.image = [UIImage imageNamed:@"bottom.png"];
    //    [self addSubview:imgView];
    
    
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 10);
    [self setTransform:myTransform];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = [data objectAtIndex:indexPath.section];
    NSString *did = [[dictionary.keyEnumerator allObjects] objectAtIndex:0];
    NSArray *array = [dictionary objectForKey:did];
    PackageInfo *pi = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = pi.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self dismissWithClickedButtonIndex:0 animated:YES];
    [self.caller didSelectRowAtIndex:indexPath.row withContext:self.context tableView:myTableView data:data invName:pkgName btn:_btn];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSDictionary *dictionary = [data objectAtIndex:section];
    NSString *did = [[dictionary.keyEnumerator allObjects] objectAtIndex:0];
	return did;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [data count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [data count];
    NSDictionary *dictionary = [data objectAtIndex:section];
    NSString *did = [[dictionary.keyEnumerator allObjects] objectAtIndex:0];
    NSArray *array = [dictionary objectForKey:did];
    return [array count];
}

-(void)dealloc{
    self.data = nil;
    self.caller = nil;
    self.context = nil;
    myTableView=nil;
}

@end
