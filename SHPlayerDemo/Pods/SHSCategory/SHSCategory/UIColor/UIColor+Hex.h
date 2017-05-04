//
//  UIColor+Hex.h
//
//
//  Created by Tristan on 15/11/3.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 返回随机颜色
 */
+ (instancetype)randColor;

/**
 *  将16进制字符串转换成UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
