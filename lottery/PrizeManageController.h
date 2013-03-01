//
//  PrizeManageController.h
//  lottery
//
//  Created by toby on 13-2-25.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHImagePickerMutilSelector.h"
@interface PrizeManageController : UIViewController<MHImagePickerMutilSelectorDelegate,UITableViewDataSource,UITableViewDelegate>



@property(atomic, retain) IBOutlet UITableView *myTableView;
@property (strong,atomic) NSMutableArray *items;
@property(strong,atomic) IBOutlet UIBarButtonItem *add;
@property(strong,atomic) IBOutlet UIBarButtonItem *editPrize;

@end