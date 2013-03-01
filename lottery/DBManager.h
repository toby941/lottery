//
//  DBManager.h
//  lottery
//
//  Created by toby on 13-2-20.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface DBManager : NSObject
{
   
}
@property(nonatomic,retain) FMDatabase *db;
+ (FMDatabase*) getDb;
@end

