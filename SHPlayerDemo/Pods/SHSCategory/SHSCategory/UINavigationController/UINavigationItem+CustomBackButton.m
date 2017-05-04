//
//  UINavigationItem+CustomBackButton.m
//
//
//  Created by Tristan on 15/11/19.
//  Copyright © 2015年 Tristan. All rights reserved.
//

#import "UINavigationItem+CustomBackButton.h"
#import <objc/runtime.h>

@implementation UINavigationItem (CustomBackButton)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethodImp = class_getInstanceMethod(self, @selector(backBarButtonItem));
        Method destMethodImp = class_getInstanceMethod(self, @selector(customBackButton_backBarbuttonItem));
        method_exchangeImplementations(originalMethodImp, destMethodImp);
    });
}

static char kCustomBackButtonKey;
-(UIBarButtonItem *)customBackButton_backBarbuttonItem{
    UIBarButtonItem *item = [self customBackButton_backBarbuttonItem];
    if (item) {
        return item;
    }
    item = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!item) {
        
        item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:NULL];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

-(UIBarButtonItem *)backBarButtonItem{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:NULL];
    
    return item;
}

- (void)dealloc {
    objc_removeAssociatedObjects(self);
}


@end
