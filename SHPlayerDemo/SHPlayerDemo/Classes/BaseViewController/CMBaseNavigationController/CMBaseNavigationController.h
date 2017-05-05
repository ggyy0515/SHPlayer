//
//  CMBaseNavigationController.h
//  TrCommerce
//
//  Created by Tristan on 15/11/4.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBaseNavigationController : UINavigationController

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backBtn;


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated  titleLabel:(NSString *)title;


@end
