//
//  SHPlayerControlView.h
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/9.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ASValueTrackingSlider;

@protocol SHPlayControlViewDelegate <NSObject>

@required

- (void)playControlViewDidChangeSliderValue:(CGFloat)sliderValue;

- (void)playControlViewDidClickPlayBtn:(UIButton *)playBtn;

- (void)playControlViewDidClickShrinkBtn:(UIButton *)shrinkBtn;

- (void)playControlViewShouldChangeToPortrait;

- (void)playControlViewDoubleTapInside;

@end


@interface SHPlayerControlView : UIView

@property (nonatomic, weak) id <SHPlayControlViewDelegate> delegate;
/**
 滑块
 */
@property (nonatomic, strong) ASValueTrackingSlider *slider;

- (void)setCurrentTime:(NSString *)currentTime totalTime:(NSString *)totalTime sliderValue:(CGFloat)sliderValue;

- (void)show;

- (void)hide;

- (void)setPlayBtnSelectedState:(BOOL)isSelected;


@end
