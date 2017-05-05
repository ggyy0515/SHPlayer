//
//  CMBaseViewController.m
//  TrCommerce
//
//  Created by Tristan on 15/11/4.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()

@end

@implementation CMBaseViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.navigationItem.backBarButtonItem = self.navigationItem.customBackButton_backBarbuttonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

UIView * TitleWithWhiteColor(NSString *titleMessage){
    return ({
        UILabel *title = [[UILabel alloc] init];
        title.text = titleMessage;
        title.textColor = UIColorFromHexString(@"#1c1c1c");
        title.font = [UIFont boldSystemFontOfSize:17];
        [title sizeToFit];
        title;
    });
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
