//
//  UIView+GetPropertyMethod.h
//
//
//  Created by Tristan on 15/11/5.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GetPropertyMethod)

@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) CGFloat rightBorderWidth;
@property (assign, nonatomic) CGFloat bottomBorderWidth;
@property (assign, nonatomic) CGFloat topBorderWidth;
@property (assign, nonatomic) CGFloat leftBorderWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (nonatomic, assign) CGFloat maxY;
- (CGFloat)x;
- (void)setX:(CGFloat)x;
- (CGFloat)y;
- (void)setY:(CGFloat)y;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGSize)size;
- (void)setSize:(CGSize)size;
- (CGFloat)maxY;


- (CGFloat)srm_height;
- (void)setCornerRadius:(CGFloat)radius;
- (void)setBorderWith:(CGFloat)width color:(UIColor *)color;
- (void)setBorderWidth:(CGFloat)width;
- (void)setBorderColor:(UIColor *)borderColor;

- (void)setRightBorderWidth:(CGFloat)rightBorderWidth;
- (void)setBottomBorderWidth:(CGFloat)bottomBorderWidth;
- (void)setTopBorderWidth:(CGFloat)topBorderWidth;

- (void)singleTapDetect:(void(^)())tapCompletionBlock;

@end
