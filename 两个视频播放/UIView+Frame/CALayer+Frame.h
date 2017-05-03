//
//  CALayer+Frame.h
//  HereApp
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 Xito Technologies. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Frame)

// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性和方法的实现
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@end
