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
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
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

- (UITapGestureRecognizer *)singleTap {
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        _doubleTap.numberOfTapsRequired = 1;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _singleTap;
}

- (UITapGestureRecognizer *)doubleTap {
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}

#pragma mark - Private

- (void)setupPlayeView {
    self.backgroundColor = UIColorFromHexString(@"#000000");
    [self addSubview:self.controlView];
    self.userInteractionEnabled = YES;
    
    [self addGestureRecognizer:self.singleTap];
    [self addGestureRecognizer:self.doubleTap];
    [self.singleTap setDelaysTouchesBegan:YES];
    [self.doubleTap setDelaysTouchesBegan:YES];
    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
}

- (void)setupPlayer {
    [self.player setDrawable:self];
}


/**
 强制改变屏幕方向

 @param orientation 方向
 */
- (void)forceChangeOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        [self.superview layoutIfNeeded];
        self.exFrame = self.frame;
        self.exSuperView = self.superview;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.superview).insets(UIEdgeInsetsZero);
        }];
    } else {
        [self.exSuperView addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.exFrame.size);
            make.left.mas_equalTo(self.exFrame.origin.x);
            make.top.mas_equalTo(self.exFrame.origin.y);
        }];
        self.frame = self.exFrame;
    }
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

- (void)singleTapAction:(UITapGestureRecognizer *)sender {
    [self bringSubviewToFront:self.controlView];
    [self.controlView show];
}

- (void)doubleTapAction:( UITapGestureRecognizer * _Nullable )sender {
    switch (self.player.state) {
        case VLCMediaPlayerStatePlaying:
        case VLCMediaPlayerStateBuffering:
        {
            [self.player pause];
            [self.controlView setPlayBtnSelectedState:NO];
        }
            break;
        case VLCMediaPlayerStatePaused:
        {
            [self.player play];
            [self.controlView setPlayBtnSelectedState:YES];
        }
            break;
        default:
            break;
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
        [self forceChangeOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)playControlViewShouldChangeToPortrait {
    [self forceChangeOrientation:UIInterfaceOrientationPortrait];
}

- (void)playControlViewDoubleTapInside {
    [self doubleTapAction:nil];
}

@end
