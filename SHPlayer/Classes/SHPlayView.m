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
    VLCMediaPlayerDelegate
>

@property (nonatomic, strong) VLCMediaPlayer *player;
@property (nonatomic, strong) SHPlayerControlView *controlView;

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
    }
    return _controlView;
}

#pragma mark - Private

- (void)setupPlayeView {
    self.backgroundColor = UIColorFromHexString(@"#000000");
    [self addSubview:self.controlView];
}

- (void)setupPlayer {
    [self.player setDrawable:self];
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


@end
