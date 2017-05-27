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
@property (nonatomic, assign) CGFloat sumTime;
@property (nonatomic, strong) UIView *fastView;
@property (nonatomic, strong) UIImageView *fastImageView;
@property (nonatomic, strong) UILabel *fastTimeLabel;
@property (nonatomic, strong) UIProgressView *fastProgressView;

@end


@implementation SHPlayView

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        _sumTime = 0.f;
        [self setupPlayeView];
        [self addLayout];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setupPlayer];
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

- (UIView *)fastView {
    if (!_fastView) {
        _fastView                     = [[UIView alloc] init];
        _fastView.backgroundColor     = [UIColorFromHexString(@"#000000") colorWithAlphaComponent:0.8];
        _fastView.layer.cornerRadius  = 4;
        _fastView.layer.masksToBounds = YES;
    }
    return _fastView;
}

- (UIImageView *)fastImageView {
    if (!_fastImageView) {
        _fastImageView = [[UIImageView alloc] init];
    }
    return _fastImageView;
}

- (UILabel *)fastTimeLabel {
    if (!_fastTimeLabel) {
        _fastTimeLabel               = [[UILabel alloc] init];
        _fastTimeLabel.textColor     = [UIColor whiteColor];
        _fastTimeLabel.textAlignment = NSTextAlignmentCenter;
        _fastTimeLabel.font          = [UIFont systemFontOfSize:14.0];
    }
    return _fastTimeLabel;
}

- (UIProgressView *)fastProgressView {
    if (!_fastProgressView) {
        _fastProgressView                   = [[UIProgressView alloc] init];
        _fastProgressView.progressTintColor = [UIColor whiteColor];
        _fastProgressView.trackTintColor    = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    return _fastProgressView;
}

#pragma mark - Private

- (void)setupPlayeView {
    self.backgroundColor = UIColorFromHexString(@"#000000");
    [self addSubview:self.controlView];
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.fastView];
    [self.fastView addSubview:self.fastImageView];
    [self.fastView addSubview:self.fastTimeLabel];
    [self.fastView addSubview:self.fastProgressView];
    self.fastView.hidden = YES;
    
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

- (void)addLayout {
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
    [self.fastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(80);
        make.center.equalTo(self);
    }];
    
    [self.fastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(32);
        make.height.mas_offset(32);
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(self.fastView.mas_centerX);
    }];
    
    [self.fastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.fastImageView.mas_bottom).offset(2);
    }];
    
    [self.fastProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.fastTimeLabel.mas_bottom).offset(10);
    }];
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
                NSLog(@"s--%lf", veloctyPoint.x);
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
                    NSLog(@"i--%lf", veloctyPoint.x);
                    [self horizonMoveWithValue:veloctyPoint.x];
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

- (void)horizonMoveWithValue:(CGFloat)value {
    self.sumTime += value / 200.f;
    CGFloat mediaLengh = self.player.media.length.value.doubleValue / 1000.f;
    CGFloat currentTime = self.player.time.value.doubleValue / 1000.f;
    if (self.sumTime > 0) {
        if (self.sumTime > mediaLengh - currentTime) {
            self.sumTime = mediaLengh - currentTime;
        }
    } else if (self.sumTime < 0) {
        if (self.sumTime < (-currentTime)) {
            self.sumTime = (-currentTime);
        }
    } else {
        return;
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
