//
//  UITextField+ActionBlock.h
//  Tristan
//
//  Created by Tristan on 16/1/7.
//  Copyright © 2016年 Tristan All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UITextFieldActionBlock)(UITextField *sender);

@interface UITextField (ActionBlock)

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(UITextFieldActionBlock)actionBlock;

@end
