//
//  UIView+GetPropertyMethod.m
//
//
//  Created by Tristan on 15/11/5.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#define kMainScreen_RATIO           ([UIScreen mainScreen].bounds.size.width / 320.f)

#import "UIView+GetPropertyMethod.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

static NSString * kTapCompletionBlockKey = @"kTapCompletionBlockKey";

@interface UIView ()

@property (strong, nonatomic) void(^tapCompletionBlock)();

@end

@implementation UIView (GetPropertyMethod)

@dynamic cornerRadius;
@dynamic borderColor;
@dynamic borderWidth;
@dynamic rightBorderWidth;
@dynamic leftBorderWidth;
@dynamic bottomBorderWidth;
@dynamic topBorderWidth;


- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}
- (CGFloat)srm_height{
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)maxY {
    return self.y + self.height;
}

- (void)setCornerRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}
- (void)setBorderWith:(CGFloat)width color:(UIColor *)color{
    self.layer.borderWidth = width;
    UIColor *borderColor = color;
    if (!borderColor) {
        borderColor = [UIColor lightGrayColor];
    }
    self.layer.borderColor = [borderColor CGColor];
}
- (void)setBorderWidth:(CGFloat)width{
    self.layer.borderWidth = width;
}

- (void)setRightBorderWidth:(CGFloat)rightBorderWidth{
    if (rightBorderWidth > 0) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - rightBorderWidth, 0, rightBorderWidth, self.frame.size.height - 0);
        if (self.borderColor) {
            layer.backgroundColor = self.borderColor.CGColor;
        }else
            layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:layer];
        layer.opacity = 0.4;
    }
}
- (void)setBottomBorderWidth:(CGFloat)bottomBorderWidth{
    if (bottomBorderWidth > 0) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.layer.frame.size.height-bottomBorderWidth, self.layer.frame.size.width * kMainScreen_RATIO,bottomBorderWidth);
        
        if (self.borderColor) {
            layer.backgroundColor = self.borderColor.CGColor;
        }else
            layer.backgroundColor = self.layer.borderColor;
        [self.layer addSublayer:layer];
        layer.opacity = 0.4;
    }
}
- (void)setTopBorderWidth:(CGFloat)topBorderWidth{
    if (topBorderWidth > 0) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0,0, self.layer.frame.size.width * kMainScreen_RATIO,topBorderWidth);
        
        if (self.borderColor) {
            layer.backgroundColor = self.borderColor.CGColor;
        }else
            layer.backgroundColor = self.layer.borderColor;
        [self.layer addSublayer:layer];
        layer.opacity = 0.4;
    }
}

- (UIColor *)borderColor{
    UIColor * color =  [UIColor colorWithCGColor: self.layer.borderColor];
    return color;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = [borderColor CGColor];
}

- (void (^)())tapCompletionBlock{
    return objc_getAssociatedObject(self, (__bridge const void *)(kTapCompletionBlockKey));
}

- (void)setTapCompletionBlock:(void (^)())tapCompletionBlock{
    objc_setAssociatedObject(self, (__bridge const void *)(kTapCompletionBlockKey), tapCompletionBlock, OBJC_ASSOCIATION_RETAIN);
}
- (void)singleTapDetect:(void (^)())tapCompletionBlock{
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapSelector)];
    [self addGestureRecognizer:tapGestureRecognizer];
    self.tapCompletionBlock = [tapCompletionBlock copy];
}

- (void)singleTapSelector{
    self.userInteractionEnabled = YES;
    [self tapCompletionBlock]();
}

@end
