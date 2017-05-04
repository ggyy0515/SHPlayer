//
//  NSDictionary+dicWithGetParameter.h
//  RMPayDemo
//
//  Created by KOLee on 2017/4/27.
//  Copyright © 2017年 menglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (dicWithGetParameter)

/**
 字典准换get 参数类型
 
 @param parmeter 上传字典
 @return return 转换后的类型
 */
+ (NSString *)filterParameterValue:(NSDictionary *)parmeter;


@end
