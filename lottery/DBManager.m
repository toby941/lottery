//
//  DBManager.m
//  lottery
//
//  Created by toby on 13-2-20.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
@synthesize db;
+ (FMDatabase*) getDb
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"lottery.db"];
    //创建数据库实例 db  这里说明下:如果路径中不存在"lottery.db"的文件,sqlite会自动创建"lottery.db"
    FMDatabase  *singletonDb= [FMDatabase databaseWithPath:dbPath];
    return singletonDb;
}
@end
