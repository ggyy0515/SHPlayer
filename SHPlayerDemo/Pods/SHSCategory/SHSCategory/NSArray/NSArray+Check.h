//
//  NSArray+Check.h
//
//
//  Created by Tristan on 15/11/3.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Check)

/**
 *  通过数组索引获取对象，同时会规避数组为空、索引越界等异常。
 *
 *  @param index 数组索引
 *
 *  @return 返回数组索引位置处的对象。
 */
- (id)objectAtIndexWithCheck:(NSUInteger)index;


@end
