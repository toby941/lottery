//
//  SubPickerView.m
//  lottery
//
//  Created by toby on 13-2-26.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import "PickerView.h"
#import "FMDatabase.h"
#import "DBManager.h"
@implementation PickerView

@synthesize delegate;
@synthesize type;


- (id)initWithTag:(NSInteger)tag
{
    self = [super init];
    self.type=tag;
    if (self) {
        items=[[NSMutableArray alloc] init];
        [self initDataSource];
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        selectedPan=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
        
        UINavigationBar *bar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UINavigationItem * item =[[UINavigationItem alloc]initWithTitle:@"选择" ];
        UIBarButtonItem *cancelItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(closeView)];
        item.rightBarButtonItem=cancelItem;
        [bar pushNavigationItem:item animated:YES];
        //  [bar.topItem setRightBarButtonItem:cancelItem];
        [cancelItem release];
        
        
        [selectedPan addSubview:bar];
        [bar release];
        
        
        tbv=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 640) style:UITableViewStylePlain];
        
        
        //  [tbv setRowHeight:100];
        [tbv setShowsVerticalScrollIndicator:YES];
        [tbv setPagingEnabled:YES];
        
        tbv.dataSource=self;
        tbv.delegate=self;
        
        //[tbv setContentInset:UIEdgeInsetsMake(10, 0, 0, 0)];
        
        //[tbv setBackgroundColor:[UIColor redColor]];
        
        
        [tbv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [tbv reloadData];
        [selectedPan addSubview:tbv];
        [tbv release];
        
        [ self.view addSubview:selectedPan];
        [selectedPan release];
        
    }
    return self;
}

-(void)initDataSource
{
    NSString *tableName=nil;
       if(self.type==0){
        tableName=@"peoples";
    }else{
        tableName=@"prize";
    }
    NSString *sql=[NSString stringWithFormat:@"SELECT uid,name, count,pics FROM %@",tableName];
    FMDatabase *db=[DBManager getDb];
    [db open];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        int uid=[rs intForColumn:@"uid"];
        NSString *name = [rs stringForColumn:@"name"];
        NSData *picsData= [rs dataForColumn:@"pics"];
        NSMutableArray *pics=[NSKeyedUnarchiver unarchiveObjectWithData:picsData];
        PhotoList *p=[[PhotoList alloc] initWithName:name];
        p.uid=uid;
        p.pics=pics;
        [items addObject:p];
    }
    [rs close];
    [db close];
    
}

-(void)close
{
    [self dismissModalViewControllerAnimated:YES];
    // [self release];
}

-(IBAction)closeView{
    [items removeAllObjects];
	[self close];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"enter subView cellForRowAtIndexPath");
    NSInteger row=indexPath.row;
    PhotoList *p=[items objectAtIndex:row];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] init] autorelease];
    }
    cell.textLabel.text= p.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"lable text :%@",cellView.textLabel.text);
    
    if (delegate && [delegate respondsToSelector:@selector(getPhoto:)]) {
         PhotoList *p=[items objectAtIndex:indexPath.row];
        [delegate performSelector:@selector(getPhoto:) withObject:p];
        
    }
    [self close];

    
    
}



@end
