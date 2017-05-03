//
//  PlayerBgView.h
//  两个视频播放
//
//  Created by mac on 17/4/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayerBgView;
@protocol AVPlayerBgViewDelegate <NSObject>
@optional
- (void)avPlayerBgView:(AVPlayerBgView *)avPlayerBgView distanceFromCenter:(float)distance;
@end

@interface AVPlayerBgView : UIView

@property (nonatomic, weak) id<AVPlayerBgViewDelegate> delegate;

@end
