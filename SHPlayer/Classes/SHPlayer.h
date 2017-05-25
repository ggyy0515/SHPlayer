//
//  SHPlayer.h
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/10.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#ifndef SHPlayer_h
#define SHPlayer_h

#import "Masonry.h"


#define SHPlayerSrcName(file)               [@"SHPlayer.bundle" stringByAppendingPathComponent:file]

#define SHPlayerFrameworkSrcName(file)      [@"Frameworks/SHPlayer.framework/SHPlayer.bundle" stringByAppendingPathComponent:file]

#define SHPlayerImage(file)                 [UIImage imageNamed:SHPlayerSrcName(file)] ? :[UIImage imageNamed:SHPlayerFrameworkSrcName(file)]

#define IS_NORMAL_RESPONDDELEGATE_FUNC(id,SEL) (id && [id respondsToSelector:SEL])

//add notifition
#define POST_NOTIFICATION(NotifationName,obj) [[NSNotificationCenter defaultCenter] postNotificationName: NotifationName object:obj]

//add observer
#define ADD_OBSERVER_NOTIFICATION(id,SEL,Name,obj) [[NSNotificationCenter defaultCenter] addObserver:id selector:SEL name:Name object:obj]

//remove observe
#define REMOVE_NOTIFICATION(id,Name,obj)  [[NSNotificationCenter defaultCenter] removeObserver:id name:Name object:obj]

#endif /* SHPlayer_h */
