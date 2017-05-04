//
//  UIImage+Redraw.h
//
//
//  Created by Tristan on 15/11/25.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Redraw)

- (UIImage *)redrawImageWithSize:(CGSize)size;

- (UIImage *)redrawImageWithColor:(UIColor *)color;

@end
