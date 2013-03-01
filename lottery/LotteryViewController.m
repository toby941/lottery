//
//  LotteryViewController.m
//  lottery
//
//  Created by toby on 13-2-16.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import "LotteryViewController.h"
#import "PickerView.h"

@interface LotteryViewController ()

@end


@implementation LotteryViewController
@synthesize peopleButton;
@synthesize peopleName;
@synthesize prizeButton;
@synthesize prizeName;
@synthesize action;
@synthesize currentTag;

@synthesize peopleList;
@synthesize prizeList;
@synthesize peopleImageView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [peopleButton addTarget:self action:@selector(pick:) forControlEvents:UIControlEventTouchDown];
    [prizeButton addTarget:self action:@selector(pick:) forControlEvents:UIControlEventTouchDown];
    
    [action addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchDown];
}
-(IBAction) pick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag= button.tag;
    currentTag=button.tag;
    //[[PickerView alloc] initWithNibName:@"SubPickerView" bundle:nil]
    PickerView* subPickView=[[PickerView alloc] initWithTag:tag];//自动释放
    subPickView.delegate=self;//设置代理
    
    [self presentModalViewController:subPickView animated:YES];
    [subPickView release];
}

-(void)getPhoto:(PhotoList*)photoList
{
    if(currentTag==0){
        peopleName.text=photoList.name;
        peopleList=photoList;
    }else{
        prizeName.text=photoList.name;
        prizeList=photoList;
    }
}


-(void) action
{
    NSInteger count=peopleList.pics.count;
    int i = arc4random() % count;
    peopleImageView.image=[peopleList.pics objectAtIndex:i];
 }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
