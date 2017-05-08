//
//  CMBaseTableViewCell.h
//  ZhongShanEC
//
//  Created by Tristan on 16/1/5.
//  Copyright © 2016年 com.shuhuasoft.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBaseTableViewCell : UITableViewCell

+ (UINib *)nib;

- (void)configueCellContext:(id)model;

- (void)setDelegate:(id)obj;

- (CGFloat)cellHeight:(id)model;

- (NSIndexPath *)indexPath;
- (UITableView *)superTableView;

- (void)defineCellStyle:(id)model;

@end
