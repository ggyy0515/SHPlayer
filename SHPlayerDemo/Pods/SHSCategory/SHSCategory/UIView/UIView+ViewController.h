//
//  UIView+ViewController.h
//
//
//  Created by Tristan on 15/11/5.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)

/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *viewController;


@end
