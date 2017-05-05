//
//  CMBasePullTableVIewViewController.m
//  TrCommerce
//
//  Created by Tristan on 15/11/6.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "CMBasePullTableVIewViewController.h"

@interface CMBasePullTableVIewViewController ()

@end

@implementation CMBasePullTableVIewViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    
    WEAK_SELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf loadDataSource];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNum ++;
        [weakSelf loadDataSource];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
