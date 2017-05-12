//
//  SHPlayerControlView.m
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/9.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import "SHPlayerControlView.h"
#import "SHPlayer.h"
#import "ASValueTrackingSlider.h"
#import "MMMaterialDesignSpinner.h"

@interface SHPlayerControlView ()

/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 播放按钮
 */
@property (nonatomic, strong) UIButton *playBtn;
/**
 返回
 */
@property (nonatomic, strong) UIButton *backBtn;
/**
 总时长
 */
@property (nonatomic, strong) UILabel *totalTimeLabel;
/**
 当前时间
 */
@property (nonatomic, strong) UILabel *currtenTimeLabel;
/**
 滑块
 */
@property (nonatomic, strong) ASValueTrackingSlider *slider;

@end

@implementation SHPlayerControlView

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {

}

#pragma mark - Lazy Loading

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton new];
        [_playBtn setImage:SHPlayerImage(@"SHPlayer_play") forState:UIControlStateNormal];
        [_playBtn setImage:SHPlayerImage(@"SHPlayer_pause") forState:UIControlStateSelected];
        [_playBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
            
        }];
    }
    return _playBtn;
}

@end
