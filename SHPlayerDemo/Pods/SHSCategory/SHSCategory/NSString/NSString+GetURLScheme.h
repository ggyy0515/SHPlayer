//
//  NSString+GetURLScheme.h
//  RMPayDemo
//
//  Created by KOLee on 2017/3/31.
//  Copyright © 2017年 menglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GetURLScheme)

/**
 比较Scheme中是否有此标识符

 @param str 标识符
 @return return value description
 */
+ (BOOL )getInfoPlistSchemeWithWXScheme:(NSString *)str;


@end
