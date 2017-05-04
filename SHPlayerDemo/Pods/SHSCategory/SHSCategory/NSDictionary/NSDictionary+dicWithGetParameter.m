//
//  NSDictionary+dicWithGetParameter.m
//  RMPayDemo
//
//  Created by KOLee on 2017/4/27.
//  Copyright © 2017年 menglong. All rights reserved.
//

#import "NSDictionary+dicWithGetParameter.h"

#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


@implementation NSDictionary (dicWithGetParameter)

+ (NSString *)filterParameterValue:(NSDictionary *)parmeter{
    if (parmeter!=nil) {
        NSMutableString *getRequestString = [[NSMutableString alloc] init];
        for (NSString *key in [parmeter allKeys]) {
            NSString *value = [NSString stringWithFormat:@"%@",[parmeter objectForKey:key]];
            if (kObjectIsEmpty(getRequestString)) {
                [getRequestString appendString:[NSString stringWithFormat:@"?%@=%@",key,value]];
            }else{
                [getRequestString appendString:[NSString stringWithFormat:@"&%@=%@",key,value]];
            }
        }
        NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)getRequestString, NULL, NULL,  kCFStringEncodingUTF8 ));
        
        return encodedString;
    }
    return nil;
}


@end
