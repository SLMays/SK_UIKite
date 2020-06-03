//
//  UIButton+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by 石磊 on 2017/11/1.
//  Copyright © 2017年 ShiLei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    SK_ButtonEdgeInsetsStyle_imgTop = 0,
    SK_ButtonEdgeInsetsStyle_imgBottom,
    SK_ButtonEdgeInsetsStyle_imgLeft,
    SK_ButtonEdgeInsetsStyle_imgRight,
    SK_ButtonEdgeInsetsStyle_imgMostLeft,
    SK_ButtonEdgeInsetsStyle_imgMostRight,
    SK_ButtonEdgeInsetsStyle_labelMostLeft,
    SK_ButtonEdgeInsetsStyle_labelMostRight,
    
}SK_ButtonEdgeInsetsStyle;

@interface UIButton (SKUtils)

+(UIButton * _Nullable)initWithFrame:(CGRect)frame Title:(NSString * _Nullable)title TitleColor:(UIColor *_Nullable)titleColor BgColor:(UIColor *_Nullable)bgColor Image:(UIImage *_Nullable)img BgImage:(NSString *_Nullable)bgImgName Target:(id _Nullable )target Action:(_Nullable SEL)sel ForControlEvents:(UIControlEvents)events Tag:(int)tag;

//纯文本
+(UIButton *_Nullable)initWithFrame:(CGRect)frame title:(NSString * _Nullable)title titleColor:(NSString *_Nullable)tColor titleFont:(UIFont*_Nullable)font bgColor:(NSString *_Nullable)bgColor target:(id _Nullable )target action:(_Nullable SEL)sel  tag:(int)tag;

//纯图片
+(UIButton* _Nullable)initWithFrame:(CGRect)frame imageName:(NSString* _Nullable)imageName btnBgImage:(NSString* _Nullable)bgImage target:(id _Nullable )target action:(SEL _Nullable )action bgColor:(NSString *_Nullable)bgColor tag:(int)tag;

//文本+图片
+(UIButton* _Nullable)initWithFrame:(CGRect)frame imageName:(NSString* _Nullable)imageName btnBgImage:(NSString* _Nullable)bgImage target:(id _Nullable)target action:(_Nullable SEL)action title:(NSString*_Nullable)title bgColor:(NSString *_Nullable)bgColor titleColor:(NSString *_Nullable)titleColor titleFont:(UIFont*_Nullable)font tag:(int)tag;

//没有文本图片，只有点击事件
+(UIButton *_Nullable)initWithFrame:(CGRect)frame target:(nonnull id)target action:(nonnull SEL)sel forControlEvents:(UIControlEvents)event tag:(int)tag;

- (void)layoutButtonWithEdgeInsetsStyle:(SK_ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
