//
//  ImageHandle.m
//  lottery
//
//  Created by toby on 13-2-22.
//  Copyright (c) 2013年 toby. All rights reserved.
//

#import "ImageHandle.h"

@implementation ImageHandle

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}


+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        UIGraphicsBeginImageContext(asize);
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

/*
 合并多张图片为一张 只取前9张合并
 */
+(UIImage *)mergeThumbImage:(NSMutableArray *)pics size:(CGSize)thumbSize{
    
    
    UIGraphicsBeginImageContext(thumbSize);
    
    
    
    UIImage *image=[pics objectAtIndex:0];
   // NSLog(@"pic count :%d",pics.count);
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    
    //每张图按缩略图宽高的三分之一进行转换
    CGFloat widthFactor=thumbSize.width/3/width;
    CGFloat heightFactor=thumbSize.height/3/height;
    
    
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    }
    else {
        scaleFactor = heightFactor;
    }
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
    {
        thumbPoint.y = (thumbSize.height/3 - scaledHeight) * 0.5;
    }
    else if (widthFactor < heightFactor)
    {
        thumbPoint.x = (thumbSize.width/3 - scaledWidth) * 0.5;
    }
    
    
    int index=1;
    for (int i=0;i<3&&pics.count>=i*3;i++) {
        
        for(int j=0;j<3&&index<=pics.count;j++){
            CGRect thumbRect = CGRectZero;
            thumbRect.origin = CGPointMake(thumbSize.width/3*(j%3),thumbSize.height/3*(i%3));
            thumbRect.size.width  = scaledWidth;
            thumbRect.size.height = scaledHeight;
            UIImage *imageEach=[pics objectAtIndex:index-1];
            index=index+1;
            [imageEach drawInRect:thumbRect];
            
        }
        
    }
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage;
}





+ (UIImage *)createThumbImage:(UIImage *)image size:(CGSize)thumbSize
{
    
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    
    
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    }
    else {
        scaleFactor = heightFactor;
    }
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
    {
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    }
    else if (widthFactor < heightFactor)
    {
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    
    UIGraphicsBeginImageContext(thumbSize);
    
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    
    [image drawInRect:thumbRect];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage;
}

@end
