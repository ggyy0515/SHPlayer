//
//  CMBaseCollectionViewCell.h
//  ZhongShanEC
//
//  Created by Tristan on 16/1/5.
//  Copyright © 2016年 com.shuhuasoft.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBaseCollectionViewCell : UICollectionViewCell

+ (UINib *)nib;

- (NSIndexPath *)indexPath;

- (UICollectionView *)superCollectionView;

@end
