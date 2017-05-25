//
//  SHPlayView.h
//  SHPlayerDemo
//
//  Created by Tristan on 2017/5/12.
//  Copyright © 2017年 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHPlayView;

@protocol SHPlayViewDelegate <NSObject>

- (void)didClickBackBtnInPlayView:(SHPlayView *)playView;

@end

@interface SHPlayView : UIView

@property (nonatomic, weak) id <SHPlayViewDelegate> delegate;

- (void)playWithUrl:(NSURL *)url;

@end
