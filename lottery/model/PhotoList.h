//
//  PhotoList.h
//  lottery
//
//  Created by toby on 13-2-25.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoList : NSObject<NSCoding>{}

@property(atomic) int uid;
@property(strong,atomic)  NSMutableArray* pics;
@property (strong,atomic)NSString* name;
@property(strong,atomic) NSData* createTime;
@property (strong,atomic)NSData* updateTime;
-(PhotoList* )initWithName:(NSString*) n;



@end
