//
//  UIImage+Compress.m
//  TestCompressImage
//
//  Created by iSouBu on 16/7/22.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import "UIImage+Compress.h"
#import "UIImage+YYAdd.h"

static const CGFloat kMaxImageWidth = 1000.f; // 这个值越大，得到的图片分辨率越高

@implementation UIImage (Compress)

- (NSData *)sc_dataWithCompressRate:(CGFloat)compressRate {
    return UIImageJPEGRepresentation(self, compressRate);
}

- (UIImage *)sc_imageWithResizeWithWidth:(CGFloat)width {
    if (width <= 0) {
        return nil;
    }
    CGFloat height = width / self.size.width * self.size.height;
    CGSize size = CGSizeMake((NSInteger)width, (NSInteger)height); // 宽度高度强转为整形，是为了解决切割后的底部白边
    
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSData *)sc_compressImageWithRate:(CGFloat)rate {
    CGSize currentSize = self.size;
    
    if (currentSize.width <= kMaxImageWidth) {
        UIImage *newImage = [self sc_imageWithResizeWithWidth:currentSize.width];
        return [newImage sc_dataWithCompressRate:rate];
    } else {
        UIImage *newImage = [self sc_imageWithResizeWithWidth:kMaxImageWidth];
        return [newImage sc_dataWithCompressRate:rate];
    }
}

@end
