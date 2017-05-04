//
//  NSString+GetURLScheme.m
//  RMPayDemo
//
//  Created by KOLee on 2017/3/31.
//  Copyright © 2017年 menglong. All rights reserved.
//

#import "NSString+GetURLScheme.h"

@implementation NSString (GetURLScheme)

+(BOOL )getInfoPlistSchemeWithWXScheme:(NSString *)str{
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSMutableArray *mutArr = [dict objectForKey:@"CFBundleURLTypes"];
    for (NSDictionary *finallDic in mutArr)
    {
        NSArray *urlSchemes = finallDic[@"CFBundleURLSchemes"];
        for (NSString *urlScheme in urlSchemes)
        {
            
            if ([str isEqualToString:urlScheme])
            {
                return YES;
            }
        }
 
    }
    return NO;
}




@end
