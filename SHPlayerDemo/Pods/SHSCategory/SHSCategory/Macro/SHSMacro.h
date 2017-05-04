//
//  SHSMacro.h
//  SHSCategoryDemo
//
//  Created by Tristan on 2017/5/3.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#ifndef SHSMacro_h
#define SHSMacro_h

/////////////////////////////////////// color ///////////////////////////////////////////////////
#define UIColorFromRGB(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define UIColorFromRGBA(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromHexString(value)   [UIColor colorWithHexString:value alpha:1.0f]
#define ClearColor              [UIColor clearColor]

/////////////////////////////////////// image ///////////////////////////////////////////////////
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

/////////////////////////////////////// placeholder ///////////////////////////////////////////////////
#define TEXTFIELD_PLACEHORDER_TEXTCOLOR   @"_placeholderLabel.textColor"
#define TEXTFIELD_PLACEHORDER_FONT        @"_placeholderLabel.font"

/////////////////////////////////////// screen ///////////////////////////////////////////////////
#define SCREENHEIGHT                [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH                 [UIScreen mainScreen].bounds.size.width


/////////////////////////////////////// WEAK_SELF STRONG_SELF ///////////////////////////////////////////////////
#define WEAK_SELF                   typeof(self) __weak weakSelf = self;
#define STRONG_SELF                 typeof(weakSelf) __strong strongSelf = weakSelf;


/////////////////////////////////////// sys ///////////////////////////////////////////////////
#define APP_DELEGATE                ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define USERDEFAULT                 [NSUserDefaults standardUserDefaults]


#endif /* SHSMacro_h */
