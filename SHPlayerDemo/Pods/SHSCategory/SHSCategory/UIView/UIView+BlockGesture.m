//
//  UIView+BlockGesture.m
//
//
//  Created by Tristan on 15/11/5.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "UIView+BlockGesture.h"
#import <objc/runtime.h>
static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;
static char kActionHandlerPanBlockKey;
static char kActionHandlerPanGestureKey;

@implementation UIView (BlockGesture)

#pragma mark ----------------------------------------------------------- tap

- (void)addTapActionWithBlock:(GestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

#pragma mark ----------------------------------------------------------- long press

- (void)addLongPressActionWithBlock:(GestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

#pragma mark ----------------------------------------------------------- pan

- (void)addPanActionWithBlock:(GestureActionBlock)block {
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerPanGestureKey);
    if (!gesture)
    {
        gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForPanGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerPanGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerPanBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForPanGesture:(UIPanGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerPanBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}


@end
