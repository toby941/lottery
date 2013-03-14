//
//  MyImagePickerMutilSelector.h
//  lottery
//
//  Created by toby on 13-3-4.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoList.h"
@protocol MyImagePickerMutilSelectorDelegate <NSObject>

@optional
-(void)imagePickerMutilSelectorDidGetImages:(PhotoList*)photoList;

@end
@interface MyImagePickerMutilSelector  : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UIView* selectedPan;
    UIView* footPan;
    UILabel* textlabel;
    UIImagePickerController*    imagePicker;
    NSMutableArray* pics;
    UITableView*    tbv;
    PhotoList* photoList;
    //id<MHImagePickerMutilSelectorDelegate>  delegate;
}

@property (nonatomic,retain)UIImagePickerController*    imagePicker;
@property(nonatomic,retain)id<MyImagePickerMutilSelectorDelegate>   delegate;


+(id)standardSelector;

-(MyImagePickerMutilSelector*) initWithPhotoList:(PhotoList*) list;

@end