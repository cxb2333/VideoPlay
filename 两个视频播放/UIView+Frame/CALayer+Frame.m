//
//  CALayer+Frame.m
//  HereApp
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 Xito Technologies. All rights reserved.
//

#import "CALayer+Frame.h"

@implementation CALayer (Frame)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

//- (void)setCenterX:(CGFloat)centerX
//{
//    CGPoint center = self.center;
//    center.x = centerX;
//    self.center = center;
//}
//
//- (CGFloat)centerX{
//    return self.center.x;
//}
//
//- (void)setCenterY:(CGFloat)centerY
//{
//    CGPoint center = self.center;
//    center.y = centerY;
//    self.center = center;
//}
//
//- (CGFloat)centerY{
//    return self.center.x;
//}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}


@end
