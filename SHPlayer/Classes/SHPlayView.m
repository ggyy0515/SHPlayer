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


/**
 滑动方向

 - PanDirectionHorizon: 水平
 - PanDirectionVertical: 竖直
 */
typedef NS_ENUM(NSInteger, PanDirection) {
    PanDirectionHorizon,
    PanDirectionVertical
};

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
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) PanDirection panDirection;

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

- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    }
    return _pan;
}

#pragma mark - Private

- (void)setupPlayeView {
    self.backgroundColor = UIColorFromHexString(@"#000000");
    [self addSubview:self.controlView];
    self.userInteractionEnabled = YES;
    
    //添加单机和双击事件
    [self addGestureRecognizer:self.singleTap];
    [self addGestureRecognizer:self.doubleTap];
    [self.singleTap setDelaysTouchesBegan:YES];
    [self.doubleTap setDelaysTouchesBegan:YES];
    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
    //添加滑动事件
    [self addGestureRecognizer:self.pan];
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

- (void)panAction:(UIPanGestureRecognizer *)sender {
    CGPoint locationPoint = [sender locationInView:self];
    CGPoint veloctyPoint = [sender velocityInView:self];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan://开始滑动
        {
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) {
                self.panDirection = PanDirectionHorizon;
                NSLog(@"水平滑动开始");
            } else if (x <y) {
                self.panDirection = PanDirectionVertical;
                NSLog(@"竖直滑动开始");
                if (locationPoint.x > SCREENWIDTH / 2.f) {
                    NSLog(@"控制音量");
                } else {
                    NSLog(@"控制亮度");
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged://正在滑动
        {
            switch (self.panDirection) {
                case PanDirectionHorizon://水平方向移动
                {
                    NSLog(@"水平滑动ing");
                }
                    break;
                case PanDirectionVertical://竖直滑动
                {
                    NSLog(@"竖直滑动ing");
                }
                    break;
                    
                default:
                    break;
            }
        }
            
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
