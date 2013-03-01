//
//  ImageHandle.h
//  lottery
//
//  Created by toby on 13-2-22.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHandle : NSObject

+(UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

+ (UIImage *)createThumbImage:(UIImage *)image size:(CGSize)thumbSize;
+(UIImage *)mergeThumbImage:(NSMutableArray *)pics size:(CGSize)thumbSize;

@end
