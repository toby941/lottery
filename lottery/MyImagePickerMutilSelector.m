//
//  MHMutilImagePickerViewController.m
//  doujiazi
//
//  Created by Shine.Yuan on 12-8-7.
//  Copyright (c) 2012年 mooho.inc. All rights reserved.
//

#import "MyImagePickerMutilSelector.h"
#import <QuartzCore/QuartzCore.h>
#import "PhotoList.h"
#import "ImageHandle.h"

@interface MyImagePickerMutilSelector ()

@end

@implementation MyImagePickerMutilSelector

@synthesize imagePicker;
@synthesize delegate;


-(MyImagePickerMutilSelector*) initWithPhotoList:(PhotoList*) list
{
    self=  [self init];
    photoList=list;
    if(list!=nil){
        pics=list.pics;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        pics=[[NSMutableArray alloc] init];
        //[pics addObject:@""];
        [self.view setBackgroundColor:[UIColor blackColor]];
        
        //if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //}
    }
    return self;
}

+(id)standardSelector
{
    return [[MyImagePickerMutilSelector alloc] init];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    [[viewController.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 320, 568-131)];
    
    selectedPan=[[UIView alloc] initWithFrame:CGRectMake(0, 568-131, 320, 131)];
    UIImageView* imv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 131)];
    [imv setImage:[UIImage imageNamed:@"bg"]];
    [selectedPan addSubview:imv];
    [imv release];
    
    textlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 13, 300, 14)];
    [textlabel setBackgroundColor:[UIColor clearColor]];
    [textlabel setFont:[UIFont systemFontOfSize:16.0f]];
    [textlabel setTextColor:[UIColor whiteColor]];
    [textlabel setText:@"当前选中0张(最多10张)"];
    [selectedPan addSubview:textlabel];
    [textlabel release];
    
    UIButton*   btn_done=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_done setFrame:CGRectMake(530/2, 5, 47, 31)];
    [btn_done setImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    [btn_done addTarget:self action:@selector(doneHandler) forControlEvents:UIControlEventTouchUpInside];
    
    [selectedPan addSubview:btn_done];
    
    
    tbv=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 90, 320) style:UITableViewStylePlain];
    
    tbv.transform=CGAffineTransformMakeRotation(M_PI * -90 / 180);
    tbv.center=CGPointMake(160, 131-90/2);
    [tbv setRowHeight:100];
    [tbv setShowsVerticalScrollIndicator:NO];
    [tbv setPagingEnabled:YES];
    
    tbv.dataSource=self;
    tbv.delegate=self;
    
    //[tbv setContentInset:UIEdgeInsetsMake(10, 0, 0, 0)];
    
    [tbv setBackgroundColor:[UIColor clearColor]];
    
    
    [tbv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [selectedPan addSubview:tbv];
    [tbv release];
    
    [viewController.view addSubview:selectedPan];
    [selectedPan release];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    UITextField *inputText= [alertView textFieldAtIndex:0];
    if(buttonIndex==0){
        return ;
    }else if (inputText.text.length==0){
        return;
    }else if(pics.count==0){
        
    }
    
    if (delegate && [delegate respondsToSelector:@selector(imagePickerMutilSelectorDidGetImages:)]) {
        photoList=[PhotoList alloc];
        
        photoList.pics=pics;
        photoList.name=inputText.text;
        photoList.createTime=[NSDate date];
        
        [delegate performSelector:@selector(imagePickerMutilSelectorDidGetImages:) withObject:photoList];
        
    }
    [self close];
}


-(void)doneHandler
{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertView.delegate = self;
    alertView.title=@"请给个好记的名字吧";
    if(photoList!=nil){
        UITextField *inputText= [alertView textFieldAtIndex:0];
        inputText.text=photoList.name;
    }
    [alertView addButtonWithTitle:@"取消"];
    [alertView addButtonWithTitle:@"确认"];
    [alertView show];
    
    NSLog(@"%@",[alertView textFieldAtIndex:0].text);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pics.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger row=indexPath.row;
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithFrame:CGRectZero];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIView* rotateView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80 , 80)];
        [rotateView setBackgroundColor:[UIColor blueColor]];
        rotateView.transform=CGAffineTransformMakeRotation(M_PI * 90 / 180);
        rotateView.center=CGPointMake(45, 45);
        [cell.contentView addSubview:rotateView];
        [rotateView release];
        
        UIImageView* imv=[[UIImageView alloc] initWithImage:[pics objectAtIndex:row]];
        [imv setFrame:CGRectMake(0, 0, 80, 80)];
        [imv setClipsToBounds:YES];
        [imv setContentMode:UIViewContentModeScaleAspectFill];
        
        [imv.layer setBorderColor:[UIColor whiteColor].CGColor];
        [imv.layer setBorderWidth:2.0f];
        
        [rotateView addSubview:imv];
        [imv release];
        
        UIButton*   btn_delete=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn_delete setFrame:CGRectMake(0, 0, 22, 22)];
        [btn_delete setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        [btn_delete setCenter:CGPointMake(70, 10)];
        [btn_delete addTarget:self action:@selector(deletePicHandler:) forControlEvents:UIControlEventTouchUpInside];
        [btn_delete setTag:row];
        
        [rotateView addSubview:btn_delete];
    }
    
    return cell;
}

-(void)deletePicHandler:(UIButton*)btn
{
    [pics removeObjectAtIndex:btn.tag];
    [self updateTableView];
}

-(void)updateTableView
{
    textlabel.text=[NSString stringWithFormat:@"当前选中%i张(最多10张)",pics.count];
    
    [tbv reloadData];
    
    if (pics.count>3) {
        CGFloat offsetY=tbv.contentSize.height-tbv.frame.size.height-(320-90);
        [tbv setContentOffset:CGPointMake(0, offsetY) animated:YES];
    }else{
        [tbv setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //[btn_addCover.imageView setImage:image forState:UIControlStateNormal];
    
    //[picker dismissModalViewControllerAnimated:YES];
    if (pics.count>=10) {
        return;
    }
    
    UIImage *thumbImage=[ImageHandle createThumbImage:image size:CGSizeMake(160,160)];
    
    [pics addObject:thumbImage];
    [self updateTableView];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self close];
}



-(void)close
{
    [imagePicker dismissModalViewControllerAnimated:YES];
    [self release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)dealloc
{
//    [delegate release];
//    delegate=nil;
//    
//    // [pics release];
//    // pics=nil;
//    
//    
//    [photoList release];
//    photoList=nil;
//    [imagePicker release];
//    imagePicker=nil;
    
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
