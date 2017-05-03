//
//  PlayerBgView.m
//  两个视频播放
//
//  Created by mac on 17/4/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AVPlayerBgView.h"

@implementation AVPlayerBgView

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint prePoint = [touch previousLocationInView:self];
    CGPoint currentPoint = [touch locationInView:self];
    self.x += currentPoint.x - prePoint.x;
    float value = 100;
    if(self.tag == 0){
        if(self.width + self.x <= value) self.x = value - self.width;
        if (self.x >= kScreenW/4) self.x = kScreenW/4;
        if ([self.delegate respondsToSelector:@selector(avPlayerBgView:distanceFromCenter:)]) {
            [self.delegate avPlayerBgView:self distanceFromCenter:-self.x];
        }
    }else{
        if (self.x <= kScreenW/4) self.x = kScreenW/4;
        if (kScreenW-self.x <= value) self.x = kScreenW - value;
        if ([self.delegate respondsToSelector:@selector(avPlayerBgView:distanceFromCenter:)]) {
            [self.delegate avPlayerBgView:self distanceFromCenter:self.x-kScreenW/2];
        }
    }
    
}

@end
