//
//  CMBaseTableViewController.h
//  TrCommerce
//
//  Created by Tristan on 15/11/5.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseTableViewController : CMBaseViewController
<
    UITableViewDelegate,
    UITableViewDataSource
>
/**
 *  tableView
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  tableViewStyle
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
/**
 *  dataSource
 */
@property (nonatomic, strong) NSMutableArray *dataSource;


/*!
 *  为空时显示的图片
 */
@property (nonatomic, strong) UIImage *emptyImage;
/*!
 *  为空时显示的内容
 */
@property (nonatomic, copy) NSString *emptyTitle;
/*!
 *  为空时显示的内容颜色
 */
@property (nonatomic, strong) UIColor *emptyTitleColor;
/*!
 *  为空时显示的内容描述
 */
@property (nonatomic, copy) NSString *emptyDetail;
/*!
 *  为空时显示的内容描述颜色
 */
@property (nonatomic, strong) UIColor *emptyDetailColor;


/**
 *  使tableView的分割线变成iOS6的样式
 */
- (void)configuraTableViewNormalSeparatorInset;
/**
 *  配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
 *
 *  @param tableView 目标tableView
 */
- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;
/**
 *  loadData
 */
- (void)loadDataSource;
/**
 *  隐藏多余的分割线
 *
 *  @param tableView
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView;


@end
