//
//  SHPlayView.m
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/12.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import "SHPlayView.h"
#import <MobileVLCKit/MobileVLCKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "SHPlayerControlView.h"

@interface SHPlayView ()
<
    VLCMediaPlayerDelegate,
    SHPlayControlViewDelegate
>

@property (nonatomic, strong) VLCMediaPlayer *player;
@property (nonatomic, strong) SHPlayerControlView *controlView;
@property (nonatomic, strong) UIView *exSuperView;
@property (nonatomic, assign) CGRect exFrame;
@end


@implementation SHPlayView

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setupPlayer];
    [self setupPlayeView];
    [self addLayout];
}

- (void)addLayout {
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - Lazy Loading

- (VLCMediaPlayer *)player {
    if (!_player) {
        _player = [[VLCMediaPlayer alloc] init];
        _player.delegate = self;
    }
    return _player;
}

- (SHPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[SHPlayerControlView alloc] init];
        _controlView.delegate = self;
    }
    return _controlView;
}

#pragma mark - Private

- (void)setupPlayeView {
    self.backgroundColor = UIColorFromHexString(@"#000000");
    [self addSubview:self.controlView];
    self.userInteractionEnabled = YES;
    @weakify(self)
    [self addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self)
        [self bringSubviewToFront:self.controlView];
        [self.controlView show];
    }];
}

- (void)setupPlayer {
    [self.player setDrawable:self];
}

/**
 *    强制横屏
 *
 *    @param orientation 横屏方向
 */
- (void)forceChangeOrientation:(UIInterfaceOrientation)orientation
{
    [self.superview layoutIfNeeded];
    self.exFrame = self.frame;
    self.exSuperView = self.superview;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.superview).insets(UIEdgeInsetsZero);
    }];
    int val = orientation;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - Public

- (void)playWithUrl:(NSURL *)url {
    if ([self.player isPlaying]) {
        [_player stop];
    }
    self.player.media = [[VLCMedia alloc] initWithURL:url];
    [self.player play];
}

#pragma mark - VLCMediaPlayerDelegate

- (void)mediaPlayerStateChanged:(NSNotification *)aNotification {
    [self bringSubviewToFront:self.controlView];
}

- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification {
    CGFloat sliderValue = self.player.time.value.floatValue / self.player.media.length.value.floatValue;
    [self.controlView setCurrentTime:self.player.time.stringValue totalTime:self.player.media.length.stringValue sliderValue:sliderValue];
}

#pragma mark - SHPlayControlViewDelegate

- (void)playControlViewDidChangeSliderValue:(CGFloat)sliderValue {
    int time = self.player.media.length.intValue * sliderValue;
    VLCTime *targetTime = [VLCTime timeWithInt:time];
    [self.player setTime:targetTime];
}

- (void)playControlViewDidClickPlayBtn:(UIButton *)playBtn {
    if (playBtn.isSelected) {
        //开始播放
        [self.player play];
    } else {
        //暂停播放
        [self.player pause];
    }
}

- (void)playControlViewDidClickShrinkBtn:(UIButton *)shrinkBtn {
    if (shrinkBtn.isSelected) {
        //进入全屏
        [self forceChangeOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
        //退出全屏
    }
}

@end
