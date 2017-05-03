//
//  UIView+Frame.h
//  北辰微博
//
//  Created by CXB on 15/8/5.
//  Copyright (c) 2015年 曹显宝. All rights reserved.
//

#import <UIKit/UIKit.h>

// 屏幕宽高
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

// 头部和底部高度
#define kHeadHeight (self.navigationController.navigationBar.height + 20)
#define kFootHeight self.tabBarController.tabBar.height

@interface UIView (Frame)

// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性和方法的实现
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;

@end
