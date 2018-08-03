//
//  UIButton+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "UIButton+SKUtils.h"

@implementation UIButton (SKUtils)

+(UIButton *_Nullable)initWithFrame:(CGRect)frame Title:(NSString * _Nullable)title TitleColor:(UIColor *_Nullable)tColor BgColor:(UIColor *_Nullable)bgColor Image:(UIImage *_Nullable)image BgImage:(UIImage *_Nullable)bgImage Target:(id _Nullable )target Action:(nonnull SEL)sel ForControlEvents:(UIControlEvents)event Tag:(int)tag
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:tColor forState:UIControlStateNormal];
    btn.backgroundColor = bgColor;
    btn.tag = tag;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:event];
    return btn;
}

+(UIButton *_Nullable)initWithFrame:(CGRect)frame Title:(NSString * _Nullable)title TitleFont:(UIFont *)font TitleColor:(UIColor *_Nullable)tColor BgColor:(UIColor *_Nullable)bgColor Image:(UIImage *_Nullable)image BgImage:(UIImage *_Nullable)bgImage Target:(id _Nullable )target Action:(nonnull SEL)sel ForControlEvents:(UIControlEvents)event Tag:(int)tag
{
    UIButton * btn = [UIButton initWithFrame:frame Title:title TitleColor:tColor BgColor:bgColor Image:image BgImage:bgImage Target:target Action:sel ForControlEvents:event Tag:tag];
    btn.titleLabel.font = font;
    return btn;
}

@end
