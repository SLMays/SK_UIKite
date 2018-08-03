//
//  UIButton+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SKUtils)

+(UIButton *_Nullable)initWithFrame:(CGRect)frame Title:(NSString * _Nullable)title TitleColor:(UIColor *_Nullable)tColor BgColor:(UIColor *_Nullable)bgColor Image:(UIImage *_Nullable)image BgImage:(UIImage *_Nullable)bgImage Target:(id _Nullable )target Action:(nonnull SEL)sel ForControlEvents:(UIControlEvents)event Tag:(int)tag;
+(UIButton *_Nullable)initWithFrame:(CGRect)frame Title:(NSString * _Nullable)title TitleFont:(UIFont *)font TitleColor:(UIColor *_Nullable)tColor BgColor:(UIColor *_Nullable)bgColor Image:(UIImage *_Nullable)image BgImage:(UIImage *_Nullable)bgImage Target:(id _Nullable )target Action:(nonnull SEL)sel ForControlEvents:(UIControlEvents)event Tag:(int)tag;
@end
