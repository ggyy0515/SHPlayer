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


#endif /* SHPlayer_h */
