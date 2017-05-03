//
//  VideoInfo.h
//  HereApp
//
//  Created by mac on 17/1/4.
//  Copyright © 2017年 Xito Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoInfo : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) long long size; //Bytes
@property(nonatomic, assign) int duration;
@property(nonatomic, copy) NSString *format;
@property(nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, assign) CGFloat width; // 视频宽度
@property (nonatomic, assign) CGFloat height;

@end
