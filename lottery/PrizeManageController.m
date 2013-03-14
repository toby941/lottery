//
//  PrizeManageController.m
//  lottery
//
//  Created by toby on 13-2-25.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import "PrizeManageController.h"
#import "MHImagePickerMutilSelector.h"
#import "PrizeList.h"
#import "FMDatabase.h"
#import "DBManager.h"
#import "ImageHandle.h"
@interface PrizeManageController ()

@end



@implementation PrizeManageController

@synthesize myTableView;
@synthesize items;
@synthesize add;
@synthesize editPrize;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.items=[[NSMutableArray alloc] init];
        //[pics addObject:@""];
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    myTableView.delegate=self;
    myTableView.dataSource=self;
    
    [add setTarget:self];
    add.action=@selector(pickMutilImage:);
    
    [editPrize setTarget:self];
    editPrize.action=@selector(editCell:);
    
    [self refreshItems];
    
  }

/*
 重置列表cell
 */
-(void) refreshItems
{
    if(!self.items){
        self.items=[[NSMutableArray alloc] init];
    }
    FMDatabase *db=[DBManager getDb];
    [db open];
    FMResultSet *rs = [db executeQuery:@"SELECT uid,name, count,pics FROM prize"];
    while ([rs next]) {
        int uid=[rs intForColumn:@"uid"];
        NSString *name = [rs stringForColumn:@"name"];
        NSData *picsData= [rs dataForColumn:@"pics"];
        NSMutableArray *pics=[NSKeyedUnarchiver unarchiveObjectWithData:picsData];
        PrizeList *p=[[PrizeList alloc] initWithName:name];
        p.uid=uid;
        p.pics=pics;
        [items addObject:p];
    }
    [rs close];
    [db close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)editCell:(id)sender
{
    [self.myTableView setEditing:!self.myTableView.editing];
}


-(IBAction) pickMutilImage:(id)sender
{
    
    MHImagePickerMutilSelector* imagePickerMutilSelector= [[MHImagePickerMutilSelector alloc] init];//自动释放
    imagePickerMutilSelector.delegate=self;//设置代理
    
    UIImagePickerController* picker=[[UIImagePickerController alloc] init];
    picker.delegate=imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
    [picker setAllowsEditing:NO];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    picker.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
    
    imagePickerMutilSelector.imagePicker=picker;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。
    
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

-(void)imagePickerMutilSelectorDidGetImages:(PrizeList*)prizeList;
{
    PrizeList* importList=prizeList;
    NSLog(@" count photo :%u",importList.pics.count);
    if(items==nil){
        self.items=[[NSMutableArray alloc] init];
    }
    [items addObject:importList];
    [self addRecord:importList];
    [myTableView reloadData];
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return items.count;
    
}

-(BOOL) addRecord:(PrizeList *)prize
{
    
    FMDatabase *db=[DBManager getDb];
    
    if(db==nil){
        NSLog(@"db is null.");
    }
    if (![db open]) {
        NSLog(@"Could not open db.");
        return false;
    }
    if(![db executeUpdate:@"CREATE TABLE IF NOT EXISTS prize (uid integer primary key asc autoincrement, name text, count INTEGER, pics blob)"])
    {
        NSLog(@"Could not create table: %@", [db lastErrorMessage]);
    }
    
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:prize.pics];
    
    if(![db executeUpdate:@"INSERT INTO prize (name, count,pics) VALUES (?,?,?)", prize.name,[NSNumber numberWithInt:prize.pics.count],data]);
    {
        NSLog(@"Could not insert data: %@", [db lastErrorMessage]);
    }
    [db commit];
    [db close];
    return true;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"prizeTableCell%d", indexPath.row];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
    NSInteger row=indexPath.row;
    
    if(cell==nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        //        cell=[[UITableViewCell alloc] initWithFrame:CGRectZero];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    PrizeList *p=[items objectAtIndex:row];
    //  UIImage *img=[p.pics objectAtIndex:0];
    if(p.pics&&p.pics.count>0){
        
        UIImage *img=[ImageHandle mergeThumbImage:p.pics size:CGSizeMake(100,100)];
        cell.imageView.image=img;
    }
    NSString *str= [NSString stringWithFormat:@"%@",p.name];
    
    cell.textLabel.text = str;
    cell.imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    cell.accessoryType= UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        PrizeList *delList=[items objectAtIndex:row];
        [items removeObjectAtIndex:row];
        
        FMDatabase *db=[DBManager getDb];
        [db open];
        
        [db executeUpdate:@"delete FROM prize where uid=?",[NSNumber numberWithInt:delList.uid]];
        
        [db close];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellView = [tableView cellForRowAtIndexPath:indexPath];
    if (cellView.accessoryType == UITableViewCellAccessoryNone) {
        cellView.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    else {
        cellView.accessoryType = UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }  }

@end

