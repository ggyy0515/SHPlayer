//
//  WJTableViewDataSource.m
//  ZhongShanEC
//
//  Created by shuhua on 16/1/5.
//  Copyright © 2016年 com.shuhuasoft.www. All rights reserved.
//

#import "WJTableViewDataSource.h"

@interface WJTableViewDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureBlock;
@property (nonatomic, assign) TableViewType tableViewType;

@end

@implementation WJTableViewDataSource

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithArray:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
                tableViewType:(TableViewType)tableViewType
               configureBlock:(TableViewCellConfigureBlock)configureBlock
{
    if ((self = [super init])) {
        _items = items;
        _cellIdentifier = cellIdentifier;
        _configureBlock = [configureBlock copy];
        _tableViewType = tableViewType;
    }
    return self;
}

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_tableViewType) {
        case SingleSection_MutipliteRow:
        {
            return self.items[indexPath.row];
        }
            break;
        case MultipliteSection_MutipliteRow:
        {
            return self.items[indexPath.section][indexPath.row];
        }
            break;
        case MultipliteSection_SingleRow:
        {
            return self.items[indexPath.section];
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_tableViewType) {
        case SingleSection_MutipliteRow:
        {
            return 1;
        }
            break;
        case MultipliteSection_MutipliteRow:
        case MultipliteSection_SingleRow:
        {
            return _items.count;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_tableViewType) {
        case SingleSection_MutipliteRow:
        {
            return _items.count;
        }
            break;
        case MultipliteSection_MutipliteRow:
        {
            return [_items[section] count];
        }
            break;
        case MultipliteSection_SingleRow:
        {
            return 1;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    id item;
    switch (_tableViewType) {
        case SingleSection_MutipliteRow:
        {
            item = _items[indexPath.row];
        }
            break;
        case MultipliteSection_MutipliteRow:
        {
            item = _items[indexPath.section][indexPath.row];
        }
            break;
        case MultipliteSection_SingleRow:
        {
            item = _items[indexPath.section];
        }
            break;
        default:
        {
            item = nil;
        }
            break;
    }
    
    if (_configureBlock) {
        _configureBlock(cell, indexPath, item);
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_tableViewType) {
        case SingleSection_MutipliteRow:
            if ([self.delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
                [self.delegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
            }
            break;
        default:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_tableViewType) {
        case SingleSection_MutipliteRow:
            return YES;
            break;
        default:
            break;
    }
    return NO;
}

@end
