//
//  UIImage+Compress.h
//  TestCompressImage
//
//  Created by iSouBu on 16/7/22.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)


/**
 *  图片压
 *
 *  @param rate 压缩比例0-1
 *
 *  @return data
 */
- (NSData *)sc_dataWithCompressRate:(CGFloat)compressRate;

/**
 *  图片缩小到一定宽度
 *
 *  @param width 宽度
 *
 *  @return 图片
 */
- (UIImage *)sc_imageWithResizeWithWidth:(CGFloat)width;

/**
 *  搜布压缩图片规则
 *
 *  @param rate rate在0.3-0.7比较好
 *
 *  @return data
 */
- (NSData *)sc_compressImageWithRate:(CGFloat)rate;
@end
