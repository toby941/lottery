//
//  SubPickerView.h
//  lottery
//
//  Created by toby on 13-2-26.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoList.h"
@protocol SubPickerViewDelegate <NSObject>

@optional
-(void)getPhoto:(PhotoList*)photoList;

@end


@interface PickerView : UIViewController<UITableViewDataSource,UITableViewDelegate>{
     UIView* selectedPan;
    UITableView*    tbv;
    NSMutableArray* items;
    
}

- (id)initWithTag:(NSInteger)tag;
@property(nonatomic,retain)id<SubPickerViewDelegate>   delegate;
@property NSInteger type;

@end
