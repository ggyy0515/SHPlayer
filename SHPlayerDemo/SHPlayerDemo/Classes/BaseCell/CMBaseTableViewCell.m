//
//  CMBaseTableViewCell.m
//  ZhongShanEC
//
//  Created by Tristan on 16/1/5.
//  Copyright © 2016年 com.shuhuasoft.www. All rights reserved.
//

#import "CMBaseTableViewCell.h"

@implementation CMBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)configueCellContext:(id)model{
    
}
- (void)defineCellStyle:(id)model{
    
}
- (CGFloat)cellHeight:(id)model{
    return 44;
}

- (void)setDelegate:(id)obj{
    
}

- (NSIndexPath *)indexPath{
    UITableView * tableView = [self superTableView];
    NSIndexPath * indexPath = [tableView indexPathForCell:self];
    return indexPath;
}
- (UITableView *)superTableView{
    return (UITableView *)[self findSuperViewWithClass:[UITableView class]];
}

- (UIView *)findSuperViewWithClass:(Class)superViewClass {
    UIView *superView = self.superview;
    UIView *foundSuperView = nil;
    while (nil != superView && nil == foundSuperView) {
        if ([superView isKindOfClass:superViewClass]) {
            foundSuperView = superView;
        } else {
            superView = superView.superview;
        }
    }
    return foundSuperView;
}

@end
