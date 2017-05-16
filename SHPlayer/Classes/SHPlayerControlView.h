//
//  SHPlayerControlView.h
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/9.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHPlayControlViewDelegate <NSObject>

- (void)playControlViewDidChangeSliderValue:(CGFloat)sliderValue;

@end


@interface SHPlayerControlView : UIView

@property (nonatomic, weak) id <SHPlayControlViewDelegate> delegate;

- (void)setCurrentTime:(NSString *)currentTime totalTime:(NSString *)totalTime sliderValue:(CGFloat)sliderValue;

@end
