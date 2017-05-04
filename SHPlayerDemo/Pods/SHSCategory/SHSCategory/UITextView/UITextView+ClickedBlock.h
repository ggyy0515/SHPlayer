//
//  UITextView+ClickedBlock.h
//  Tristan
//
//  Created by Tristan on 16/6/2.
//  Copyright © 2016年 Tristan All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ClickedBlock)

- (instancetype)initWithFrame:(CGRect)frame
              textChangeBlock:(void(^)(UITextView * textView))textChangeBlock;

@end
