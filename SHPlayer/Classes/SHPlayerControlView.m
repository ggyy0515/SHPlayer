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
@property (nonatomic, strong) UILabel *currentTimeLabel;
/**
 缩放按钮
 */
@property (nonatomic, strong) UIButton *shrinkBtn;
/**
 变成竖直
 */
@property (nonatomic, strong) UIButton *beupBtn;
/**
 是否正在拖拽进度条
 */
@property (nonatomic, assign) BOOL isDragged;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *bottomImageView;

@end

@implementation SHPlayerControlView

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)dealloc {
}

- (void)createUI {
    self.hidden = YES;
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColorFromHexString(@"#000000") colorWithAlphaComponent:0.3];
    _isDragged = NO;
    
    [self addSubview:self.topImageView];
    [self addSubview:self.bottomImageView];
    [self addSubview:self.backBtn];
    
    [self.topImageView addSubview:self.beupBtn];
    [self.topImageView addSubview:self.titleLabel];
    
    [self.bottomImageView addSubview:self.playBtn];
    [self.bottomImageView addSubview:self.currentTimeLabel];
    [self.bottomImageView addSubview:self.slider];
    [self.bottomImageView addSubview:self.totalTimeLabel];
    [self.bottomImageView addSubview:self.shrinkBtn];
    
    [self addLayout];
    
    [self addGestureRecognizer:self.singleTap];
    [self addGestureRecognizer:self.doubleTap];
    [self.singleTap setDelaysTouchesBegan:YES];
    [self.doubleTap setDelaysTouchesBegan:YES];
    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
}

- (void)addLayout {
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topImageView.mas_leading).offset(10);
        make.top.equalTo(self.topImageView.mas_top).offset(3);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.beupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topImageView.mas_leading).offset(10);
        make.top.equalTo(self.topImageView.mas_top).offset(3);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.beupBtn.mas_trailing).offset(5);
        make.centerY.equalTo(self.beupBtn.mas_centerY);
        make.trailing.equalTo(self.topImageView.mas_trailing).offset(-10);
    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomImageView.mas_leading).offset(5);
        make.bottom.equalTo(self.bottomImageView.mas_bottom).offset(-5);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.playBtn.mas_trailing).offset(-3);
        make.centerY.equalTo(self.playBtn.mas_centerY);
        make.width.mas_equalTo(50);
    }];
    
    [self.shrinkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.trailing.equalTo(self.bottomImageView.mas_trailing).offset(-5);
        make.centerY.equalTo(self.playBtn.mas_centerY);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.shrinkBtn.mas_leading).offset(3);
        make.centerY.equalTo(self.playBtn.mas_centerY);
        make.width.mas_equalTo(50);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.currentTimeLabel.mas_trailing).offset(4);
        make.trailing.equalTo(self.totalTimeLabel.mas_leading).offset(-4);
        make.centerY.equalTo(self.currentTimeLabel.mas_centerY).offset(-1);
        make.height.mas_equalTo(30);
    }];
    
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
        _playBtn.selected = YES;
        @weakify(self)
        [_playBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
            @strongify(self)
            sender.selected = !sender.selected;
            if (IS_NORMAL_RESPONDDELEGATE_FUNC(self.delegate, @selector(playControlViewDidClickPlayBtn:))) {
                [self.delegate playControlViewDidClickPlayBtn:sender];
            }
        }];
    }
    return _playBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setImage:SHPlayerImage(@"SHPlayer_back_full") forState:UIControlStateNormal];
        [_backBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
            
        }];
    }
    return _backBtn;
}

- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [UILabel new];
        _totalTimeLabel.textColor     = [UIColor whiteColor];
        _totalTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}

- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel               = [[UILabel alloc] init];
        _currentTimeLabel.textColor     = [UIColor whiteColor];
        _currentTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView                        = [[UIImageView alloc] init];
        _topImageView.userInteractionEnabled = YES;
//        _topImageView.alpha                  = 0;
        _topImageView.image                  = SHPlayerImage(@"SHPlayer_top_shadow");
    }
    return _topImageView;
}

- (UIButton *)shrinkBtn {
    if (!_shrinkBtn) {
        _shrinkBtn = [UIButton new];
        [_shrinkBtn setImage:SHPlayerImage(@"SHPlayer_fullscreen") forState:UIControlStateNormal];
        [_shrinkBtn setImage:SHPlayerImage(@"SHPlayer_shrinkscreen") forState:UIControlStateSelected];
        @weakify(self)
        [_shrinkBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
            @strongify(self)
            sender.selected = !sender.selected;
            if (self.shrinkBtn.isSelected) {
                self.backBtn.hidden = YES;
                self.beupBtn.hidden = NO;
            } else {
                self.backBtn.hidden = NO;
                self.beupBtn.hidden = YES;
            }
            if (IS_NORMAL_RESPONDDELEGATE_FUNC(self.delegate, @selector(playControlViewDidClickShrinkBtn:))) {
                [self.delegate playControlViewDidClickShrinkBtn:sender];
            }
        }];
    }
    return _shrinkBtn;
}

- (UIButton *)beupBtn {
    if (!_beupBtn) {
        _beupBtn = [UIButton new];
        [_beupBtn setImage:SHPlayerImage(@"SHPlayer_back_full") forState:UIControlStateNormal];
        _beupBtn.hidden = YES;
        @weakify(self)
        [_beupBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
            @strongify(self)
            self.beupBtn.hidden = YES;
            self.backBtn.hidden = NO;
            self.shrinkBtn.selected = !self.shrinkBtn.isSelected;
            if (IS_NORMAL_RESPONDDELEGATE_FUNC(self.delegate, @selector(playControlViewShouldChangeToPortrait))) {
                [self.delegate playControlViewShouldChangeToPortrait];
            }
        }];
    }
    return _beupBtn;
}

- (ASValueTrackingSlider *)slider {
    if (!_slider) {
        _slider                       = [[ASValueTrackingSlider alloc] init];
        _slider.popUpViewCornerRadius = 0.0;
        _slider.popUpViewColor = UIColorFromHexString(@"#131309");
        _slider.popUpViewArrowLength = 8;
        
        [_slider setThumbImage:SHPlayerImage(@"SHPlayer_slider") forState:UIControlStateNormal];
        _slider.maximumValue          = 1;
        _slider.minimumTrackTintColor = [UIColor whiteColor];
        _slider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        
        // slider开始滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_slider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];

        UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
        sliderTap.cancelsTouchesInView = NO;
        [_slider addGestureRecognizer:sliderTap];
        
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)];
        [panRecognizer setCancelsTouchesInView:NO];
        [_slider addGestureRecognizer:panRecognizer];
    }
    return _slider;
}

- (UIImageView *)bottomImageView {
    if (!_bottomImageView) {
        _bottomImageView                        = [[UIImageView alloc] init];
        _bottomImageView.userInteractionEnabled = YES;
//        _bottomImageView.alpha                  = 0;
        _bottomImageView.image                  = SHPlayerImage(@"SHPlayer_bottom_shadow");
    }
    return _bottomImageView;
}

- (UITapGestureRecognizer *)singleTap {
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        _singleTap.numberOfTouchesRequired = 1;
        _singleTap.numberOfTapsRequired = 1;
    }
    return _singleTap;
}

- (UITapGestureRecognizer *)doubleTap {
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapInControlViewWithTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}

#pragma mark - Private

// slider开始滑动
- (void)progressSliderTouchBegan:(ASValueTrackingSlider *)slider {
    _isDragged = YES;
}

// slider滑动中
- (void)progressSliderValueChanged:(ASValueTrackingSlider *)slider {
    _isDragged = YES;
}

// slider结束滑动
- (void)progressSliderTouchEnded:(ASValueTrackingSlider *)slider {
    if (IS_NORMAL_RESPONDDELEGATE_FUNC(_delegate, @selector(playControlViewDidChangeSliderValue:))) {
        [_delegate playControlViewDidChangeSliderValue:slider.value];
    }
    _isDragged = NO;
}

- (void)tapSliderAction:(UITapGestureRecognizer *)tap {
    //点击进度条更改进度
    [self layoutIfNeeded];
    if ([tap.view isKindOfClass:[ASValueTrackingSlider class]]) {
        CGPoint point = [tap locationInView:_slider];
        CGFloat length = _slider.frame.size.width;
        CGFloat value = point.x / length;
        _slider.value = value;
        if (IS_NORMAL_RESPONDDELEGATE_FUNC(_delegate, @selector(playControlViewDidChangeSliderValue:))) {
            [_delegate playControlViewDidChangeSliderValue:value];
        }
    }
}

- (void)panRecognizer:(UIPanGestureRecognizer *)pan {
    //不做操作，手势只为解决冲突
}

- (void)doubleTapInControlViewWithTap:(UITapGestureRecognizer *)sender {
    if (IS_NORMAL_RESPONDDELEGATE_FUNC(_delegate, @selector(playControlViewDoubleTapInside))) {
        [_delegate playControlViewDoubleTapInside];
    }
}

#pragma mark - Public

- (void)setCurrentTime:(NSString *)currentTime totalTime:(NSString *)totalTime sliderValue:(CGFloat)sliderValue {
    self.currentTimeLabel.text = currentTime;
    self.totalTimeLabel.text = totalTime;
    if (!_isDragged) {
        self.slider.value = sliderValue;
    }
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.35f
                     animations:^{
                         self.alpha = 1.f;
    }
                     completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.35f animations:^{
        self.alpha = 0.f;
    }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                     }];
}

- (void)setPlayBtnSelectedState:(BOOL)isSelected {
    self.playBtn.selected = isSelected;
}

@end
