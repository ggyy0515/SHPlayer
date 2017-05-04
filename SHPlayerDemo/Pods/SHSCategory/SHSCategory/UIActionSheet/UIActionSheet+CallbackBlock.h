//
//  UIActionSheet+CallbackBlock.h
//  SHSCategoryDemo
//
//  Created by Tristan on 2017/4/26.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (CallbackBlock)

- (instancetype)initWithTitle:(NSString *)title
                  actionBlock:(void(^)(UIActionSheet *sender, NSInteger buttonIndex))block
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;


@end
