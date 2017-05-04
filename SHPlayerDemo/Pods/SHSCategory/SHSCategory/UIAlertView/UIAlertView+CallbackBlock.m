//
//  UIAlertView+CallbackBlock.m
//
//
//  Created by Tristan on 15/11/3.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "UIAlertView+CallbackBlock.h"
#import <objc/runtime.h>


@interface UIAlertView ()
<
    UIAlertViewDelegate
>

@property (copy, nonatomic) void (^callbackBlock) (UIAlertView *, NSInteger);

@end

@implementation UIAlertView (CallbackBlock)


- (void (^)())callbackBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCallbackBlock:(void (^)())callbackBlock{
    objc_setAssociatedObject(self, @selector(callbackBlock), callbackBlock, OBJC_ASSOCIATION_COPY);
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                callbackBlock:(void(^)(UIAlertView * alertView, NSInteger buttonIndex))btnClickBlock
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitle, ... NS_REQUIRES_NIL_TERMINATION {
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil]) {
        va_list args;
        va_start(args, otherButtonTitle);
        NSString *str = va_arg(args, NSString *);
        while(str) {
            [self addButtonWithTitle:str];
            str = va_arg(args, NSString *);
        }
        self.callbackBlock = [btnClickBlock copy];
    }
    return self;
}

#pragma mark - uialertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.callbackBlock) {
        self.callbackBlock(alertView,buttonIndex);
    }
}

@end
