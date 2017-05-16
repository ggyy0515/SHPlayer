//
//  SHPlayerControlView.h
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/9.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SHPlayerControlView : UIView

- (void)setCurrentTime:(NSString *)currentTime totalTime:(NSString *)totalTime sliderValue:(CGFloat)sliderValue;

@end
