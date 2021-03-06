//
//  UIView+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "UIView+SKUtils.h"

@implementation UIView (SKUtils)

@dynamic bColor;
@dynamic bRadius;

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setBColor:(UIColor *)bColor
{
    self.layer.borderColor = bColor.CGColor;
    self.layer.borderWidth = 1.f;
}
-(void)setBRadius:(NSInteger)bRadius
{
    self.layer.cornerRadius = bRadius;
    self.layer.masksToBounds = YES;
}


/**
 *  初始化
 */
+(UIView*)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha
{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    [view setBackgroundColor:bgColor];
    view.alpha = alpha;
    return view;
}
+(UIView*)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag
{
    UIView * view = [UIView initWithFrame:frame backgroundColor:bgColor alpha:alpha];
    view.tag = tag;
    return view;
}
+(UIView*)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag centerX:(CGFloat)centerX
{
    UIView * view = [UIView initWithFrame:frame backgroundColor:bgColor alpha:alpha tag:tag];
    view.centerX = centerX;
    return view;
}
+(UIView*)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag centerY:(CGFloat)centerY
{
    UIView * view = [UIView initWithFrame:frame backgroundColor:bgColor alpha:alpha tag:tag];
    view.centerY = centerY;
    return view;
}
+(UIView*)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag centerX:(CGFloat)centerX centerY:(CGFloat)centerY
{
    UIView * view = [UIView initWithFrame:frame backgroundColor:bgColor alpha:alpha tag:tag];
    view.centerX = centerX;
    view.centerY = centerY;
    return view;
}
@end
