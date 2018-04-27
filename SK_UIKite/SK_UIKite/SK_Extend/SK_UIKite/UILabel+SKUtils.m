//
//  UILabel+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "UILabel+SKUtils.h"

@implementation UILabel (SKUtils)

+(UILabel *)initWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)tColor BgColor:(UIColor *)bgColor Font:(UIFont *)font TextAlignment:(NSTextAlignment)textAlignment Tag:(int)tag
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = tColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = bgColor;
    label.font = font;
    label.tag = tag;
    
    return label;
}

@end
