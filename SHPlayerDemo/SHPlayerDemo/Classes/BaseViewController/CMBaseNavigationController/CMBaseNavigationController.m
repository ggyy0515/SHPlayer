//
//  CMBaseNavigationController.m
//  
//
//  Created by Tristan on 15/11/4.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "CMBaseNavigationController.h"


@interface CMBaseNavigationController ()
<
 UIGestureRecognizerDelegate
>

@end

@implementation CMBaseNavigationController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    [self createUI];
}

-(void)createUI {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setTintColor:MainColor];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           MainColor, NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20], NSFontAttributeName, nil]];
    self.navigationBar.translucent = NO;
    if (SYS_VERSION < 7.f) {
        self.navigationBar.tintColor = [UIColor whiteColor];
    }else{
        self.navigationBar.barTintColor = [UIColor whiteColor];
    }
}



- (UIView*)createTitleView:(NSString*)str {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 100, 44)];
    _titleLabel.text = str;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = FONT_B_36;
    _titleLabel.textColor = MainColor;
    self.navigationItem.titleView = _titleLabel;
    
    return self.navigationItem.titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated titleLabel:(NSString *)title {
    if (viewController.navigationItem.leftBarButtonItem == nil) {
        viewController.navigationItem.leftBarButtonItem = [self createBackButton];
    }
    if (viewController.navigationItem.titleView== nil){
        viewController.navigationItem.titleView = [self createTitleView:title];
    }
    [self pushViewController:viewController animated:animated];
}

- (UIBarButtonItem*)createBackButton
{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.selected = NO;
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    _backBtn.backgroundColor = [UIColor clearColor];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [_backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    [_backBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    return self.navigationItem.backBarButtonItem = someBarButtonItem;
}

- (void)leftAction:(id)sender {
    UIButton *leftBtn = (UIButton *)sender;
    if (leftBtn.selected) return;
    
    if ([self.viewControllers count] > 1) {
        leftBtn.selected = YES;
        [self popViewControllerAnimated:YES];
        [self performSelector:@selector(timeEnough) withObject:nil afterDelay:0.5];
    }
}


- (void)timeEnough {
    _backBtn.selected = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
