//
//  UILabel+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SKUtils)

+(UILabel *)initWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)tColor BgColor:(UIColor *)bgColor Font:(UIFont *)font TextAlignment:(NSTextAlignment)textAlignment Tag:(int)tag;

@end
