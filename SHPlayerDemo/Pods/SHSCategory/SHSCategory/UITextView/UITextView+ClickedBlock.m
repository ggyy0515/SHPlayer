//
//  UITextView+ClickedBlock.m
//  Tristan
//
//  Created by Tristan on 16/6/2.
//  Copyright © 2016年 Tristan All rights reserved.
//

#import "UITextView+ClickedBlock.h"
#import <objc/runtime.h>

static NSString *kTxtViewTextChangeIdentify = @"kTxtViewTextChangeIdentify";


@interface UITextView ()
<
    UITextViewDelegate
>

@property (nonatomic, copy) void(^textChangeBlock)(UITextView *);

@end



@implementation UITextView (ClickedBlock)

#pragma mark - uialertView delegate

- (void)setTextChangeBlock:(void (^)(UITextView *))textChangeBlock {
    
    objc_setAssociatedObject(self, (__bridge const void *)(kTxtViewTextChangeIdentify), textChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (void (^)(UITextView *))textChangeBlock {
    
    return objc_getAssociatedObject(self, (__bridge const void *)(kTxtViewTextChangeIdentify));
}

- (instancetype)initWithFrame:(CGRect)frame textChangeBlock:(void (^)(UITextView *))textChangeBlock {
    if (self = [self initWithFrame:frame]) {
        self.textChangeBlock = textChangeBlock;
        self.delegate = self;
    }
    return self;
}


- (void)textViewDidChange:(UITextView *)textView{
    if (self.textChangeBlock) {
        self.textChangeBlock(textView);
    }
}

@end
