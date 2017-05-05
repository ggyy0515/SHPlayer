//
//  CMMultipleSectionTableViewController.m
//  TrCommerce
//
//  Created by Tristan on 15/11/6.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "CMMultipleSectionTableViewController.h"

@interface CMMultipleSectionTableViewController ()

@end

@implementation CMMultipleSectionTableViewController

#pragma mark - life cycle
-(instancetype)init{
    if (self = [super init]) {
        self.dataSource = [NSMutableArray array];
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (!self.dataSource.count) {
//        [self loadDataSource];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - UITabelView method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSource objectAtIndexWithCheck:section] count];
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
