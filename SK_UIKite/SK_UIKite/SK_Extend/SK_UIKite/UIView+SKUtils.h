//
//  UIView+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SKUtils)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.
@property (nonatomic, strong) UIColor * bColor;    ///< Shortcut for layer.borderColor.
@property (nonatomic, assign) NSInteger bRadius;    ///< Shortcut for layer.cornerRadius.

+(UIView*)initWithFrame:(CGRect)frame setBackgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha;
+(UIView*)initWithFrame:(CGRect)frame setBackgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag;
+(UIView*)initWithFrame:(CGRect)frame setBackgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag centerX:(CGFloat)centerX;
+(UIView*)initWithFrame:(CGRect)frame setBackgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag centerY:(CGFloat)centerY;
+(UIView*)initWithFrame:(CGRect)frame setBackgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha tag:(int)tag centerX:(CGFloat)centerX centerY:(CGFloat)centerY;



@end
