//
//  UIView+BlockGesture.h
//
//
//  Created by Tristan on 15/11/5.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (BlockGesture)

/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(GestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;
/**
 添加拖拽手势
 
 @param block block 代码块
 */
- (void)addPanActionWithBlock:(GestureActionBlock)block;

@end
