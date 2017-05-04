//
//  UIAlertView+CallbackBlock.h
//
//
//  Created by Tristan on 15/11/3.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (CallbackBlock)


/**
 a init method with a callback block

 @param title title
 @param message message
 @param btnClickBlock callback block
 @param cancelButtonTitle cancle title
 @param otherButtonTitle other...
 @return instancetype
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                callbackBlock:(void(^)(UIAlertView * alertView, NSInteger buttonIndex))btnClickBlock
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitle, ... NS_REQUIRES_NIL_TERMINATION;




@end
