//
//  PeopleList.m
//  lottery
//
//  Created by toby on 13-2-17.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import "PeopleList.h"

@implementation PeopleList
@synthesize pics;
@synthesize name;
@synthesize createTime;
@synthesize updateTime;
@synthesize uid;
- (PeopleList *)initWithName:(NSString *) n{
    self =[super init];
    self.name=n;
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:
            @"{\n    name =%@\n pics count = %d\n}",
            name, pics.count];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:pics forKey:@"pics"];
    [aCoder encodeObject:createTime forKey:@"createTime"];
    [aCoder encodeObject:updateTime forKey:@"updateTime"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setPics:[aDecoder decodeObjectForKey:@"pics"]];
        [self setCreateTime:[aDecoder decodeObjectForKey:@"createTime"]];
        [self setUpdateTime:[aDecoder decodeObjectForKey:@"updateTime"]];
        
    }
    return self;
}


@end
