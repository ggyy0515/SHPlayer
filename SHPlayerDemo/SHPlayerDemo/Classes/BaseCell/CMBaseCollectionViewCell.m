//
//  CMBaseCollectionViewCell.m
//  ZhongShanEC
//
//  Created by Tristan on 16/1/5.
//  Copyright © 2016年 com.shuhuasoft.www. All rights reserved.
//

#import "CMBaseCollectionViewCell.h"

@implementation CMBaseCollectionViewCell

+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (NSIndexPath *)indexPath {
    UICollectionView *collectionView = [self superCollectionView];
    NSIndexPath * indexPath = [collectionView indexPathForCell:self];
    return indexPath;
}
- (UICollectionView *)superCollectionView {
    return (UICollectionView *)[self findSuperViewWithClass:[UICollectionView class]];
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
