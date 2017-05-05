//
//  WJTableViewDataSource.h
//  ZhongShanEC
//
//  Created by shuhua on 16/1/5.
//  Copyright © 2016年 com.shuhuasoft.www. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, NSIndexPath *indexPath, id item);

typedef NS_ENUM(NSInteger, TableViewType)
{
    SingleSection_MutipliteRow = 1 << 0,
    MultipliteSection_SingleRow = 1 << 1,
    MultipliteSection_MutipliteRow = 1 << 2,
};

@protocol HJTableViewDelegate <NSObject>

@optional
/*!
 *  tableview 滑动删除代理
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WJTableViewDataSource : NSObject <UITableViewDataSource>
/*!
 *  tableview 滑动删除代理
 */
@property (nonatomic,assign) id<HJTableViewDelegate>delegate;
/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *items;
/**
 *  初始化TableView数据源对象
 *
 *  @param items          数据源
 *  @param cellIdentifier TableViewCell标识符
 *  @param configureBlock 设置TableViewCell的回调代码块
 *  @param tableViewType  TableView的类型(SingleSection_MutipliteRow/MultipliteSection_SingleRow/MultipliteSection_MutipliteRow)
 *
 *  @return WJTableViewDataSource对象
 */
- (instancetype)initWithArray:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
                tableViewType:(TableViewType)tableViewType
               configureBlock:(TableViewCellConfigureBlock)configureBlock;

/**
 *  根据索引值获取数据源中的特定对象
 *
 *  @param indexPath 索引
 *
 *  @return 对象
 */
- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
