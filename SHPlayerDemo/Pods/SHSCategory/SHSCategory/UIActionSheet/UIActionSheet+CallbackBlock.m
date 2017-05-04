//
//  UIActionSheet+CallbackBlock.m
//  SHSCategoryDemo
//
//  Created by Tristan on 2017/4/26.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import "UIActionSheet+CallbackBlock.h"
#import <objc/runtime.h>

static NSString * const kUIActionSheetBlockIdentify = @"kUIActionSheetBlockIdentify";

@interface UIActionSheet ()
<
    UIActionSheetDelegate
>

@property (nonatomic, copy) void(^callbackBlock)(UIActionSheet *, NSInteger);

@end

@implementation UIActionSheet (CallbackBlock)

- (void (^)(UIActionSheet *, NSInteger))callbackBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(kUIActionSheetBlockIdentify));
}

- (void)setCallbackBlock:(void (^)(UIActionSheet *, NSInteger))callbackBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(kUIActionSheetBlockIdentify), callbackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (instancetype)initWithTitle:(NSString *)title
                  actionBlock:(void(^)(UIActionSheet *sender, NSInteger buttonIndex))block
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    if (self = [self initWithTitle:title
                          delegate:self
                 cancelButtonTitle:cancelButtonTitle
            destructiveButtonTitle:destructiveButtonTitle
                 otherButtonTitles:otherButtonTitles, nil]) {
        va_list args;
        va_start(args, otherButtonTitles);
        NSString *str = va_arg(args, NSString *);
        while (str) {
            [self addButtonWithTitle:str];
            str = va_arg(args, NSString *);
        }
        self.callbackBlock = block;
    }
    return self;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.callbackBlock) {
        self.callbackBlock(actionSheet, buttonIndex);
    }
}

@end
