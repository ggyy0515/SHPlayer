//
//  SHFileBrowserViewController.m
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/5.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import "SHFileBrowserViewController.h"
#import "SHPlayerControlView.h"
#import "SHPlayer.h"

@interface SHFileBrowserViewController ()
//<
//    UITableViewDelegate,
//    UITableViewDataSource
//>
//
//@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SHFileBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SHPlayerControlView *view = [[SHPlayerControlView alloc] init];
    [self.navigationController.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, SCREENWIDTH * 9.f / 16.f));
        make.left.right.mas_equalTo(self.navigationController.view);
        make.top.mas_equalTo(20.f);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
