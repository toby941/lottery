//
//  LotteryViewController.h
//  lottery
//
//  Created by toby on 13-2-16.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoList.h"
@interface LotteryViewController : UIViewController

@property(strong,atomic) IBOutlet UIButton *peopleButton;
@property(strong,atomic) IBOutlet UIButton *prizeButton;

@property(strong,atomic) IBOutlet UILabel *peopleName;
@property(strong,atomic) IBOutlet UILabel *prizeName;
@property(strong,atomic) IBOutlet UIButton *action;

@property NSInteger currentTag;

@property(strong,atomic) PhotoList *peopleList;
@property(strong,atomic) PhotoList *prizeList;
@property(strong,atomic) IBOutlet UIImageView *peopleImageView;

@end

