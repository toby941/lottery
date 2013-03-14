//
//  PeopleManageController.h
//  lottery
//
//  Created by toby on 13-2-16.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHImagePickerMutilSelector.h"
#import "PeopleList.h"
@interface PeopleManageController : UIViewController<MHImagePickerMutilSelectorDelegate,UITableViewDataSource,UITableViewDelegate>
{
    }



@property(atomic, retain) IBOutlet UITableView *myTableView;

@property (strong,atomic) NSMutableArray *items;
/*
 编辑选中的cell元素 
 */
@property (strong,atomic) PeopleList *selectedList;
@property(strong,atomic) IBOutlet UIBarButtonItem *addPeople;
@property(strong,atomic) IBOutlet UIBarButtonItem *edit;
@end
