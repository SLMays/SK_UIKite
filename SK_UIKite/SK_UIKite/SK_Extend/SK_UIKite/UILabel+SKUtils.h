//
//  UILabel+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SKUtils)
//是否可以复制
@property (nonatomic, assign) BOOL  canCopy;

+(UILabel *)initWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)tColor BgColor:(UIColor *)bgColor Font:(UIFont *)font TextAlignment:(NSTextAlignment)textAlignment Tag:(int)tag;
+(UILabel*)initWithFrame:(CGRect)frame Font:(UIFont*)font numberOfLines:(int)numberOfLine Text:(NSString*)text setColor:(UIColor*)textColor  textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor*)bgColor adjustsFontSizeToFitWidth:(BOOL)yesOrNo;
+(UILabel*)initWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text setColor:(UIColor *)textColor numberOfLines:(int)numberOfLine textAlignment:(NSTextAlignment)textAlignment;
@end
