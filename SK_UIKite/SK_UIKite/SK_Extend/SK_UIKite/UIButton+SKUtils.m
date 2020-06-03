//
//  UIButton+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by 石磊 on 2017/11/1.
//  Copyright © 2017年 ShiLei. All rights reserved.
//

#import "UIButton+SKUtils.h"


@implementation UIButton (SKUtils)


+(UIButton * _Nullable)initWithFrame:(CGRect)frame Title:(NSString * _Nullable)title TitleColor:(UIColor *)titleColor BgColor:(UIColor *)bgColor Image:(UIImage *)img BgImage:(NSString *)bgImgName Target:(id _Nullable )target Action:(_Nullable SEL)sel ForControlEvents:(UIControlEvents)events Tag:(int)tag
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.backgroundColor = bgColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.tag = tag;
    [btn addTarget:target action:sel forControlEvents:events];
    
    return btn;
}

+(UIButton *_Nullable)initWithFrame:(CGRect)frame title:(NSString * _Nullable)title titleColor:(NSString *_Nullable)tColor titleFont:(UIFont*_Nullable)font bgColor:(NSString *_Nullable)bgColor target:(id _Nullable )target action:(_Nullable SEL)sel  tag:(int)tag
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    if (STRING_IS_NOT_EMPTY(tColor)) {
        btn.lee_theme.LeeConfigButtonTitleColor(tColor, UIControlStateNormal);
    } else {
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
    if (STRING_IS_NOT_EMPTY(bgColor)) {
        btn.lee_theme.LeeConfigBackgroundColor(bgColor);
    } else {
        btn.backgroundColor = [UIColor clearColor];
    }
    btn.titleLabel.font = font;
    btn.tag = tag;
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+(UIButton* _Nullable)initWithFrame:(CGRect)frame imageName:(NSString* _Nullable)imageName btnBgImage:(NSString* _Nullable)bgImage target:(id _Nullable)target action:(SEL)action bgColor:(NSString *_Nullable)bgColor tag:(int)tag
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    //设置背景图片，可以使文字与图片共存
    [button setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (STRING_IS_NOT_EMPTY(bgColor)) {//给button设置背景颜色（系统）
        button.lee_theme.LeeConfigBackgroundColor(bgColor);
    } else {
        button.backgroundColor = [UIColor clearColor];
    }
    //设置Tag
    button.tag = tag;
    
    return button;
}

+(UIButton* _Nullable)initWithFrame:(CGRect)frame imageName:(NSString* _Nullable)imageName btnBgImage:(NSString* _Nullable)bgImage target:(id _Nullable)target action:(_Nullable SEL)action title:(NSString*_Nullable)title bgColor:(NSString *_Nullable)bgColor titleColor:(NSString *_Nullable)titleColor titleFont:(UIFont*_Nullable)font tag:(int)tag
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (STRING_IS_NOT_EMPTY(bgColor)) {//给button设置背景颜色（系统）
        button.lee_theme.LeeConfigBackgroundColor(bgColor);
    } else {
        button.backgroundColor = [UIColor clearColor];
    }
    if (STRING_IS_NOT_EMPTY(titleColor)) {//给button文字设置颜色
        button.lee_theme.LeeConfigButtonTitleColor(titleColor, UIControlStateNormal);
    } else {
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
    
    //设置字体大小
    button.titleLabel.font = font;
    //设置Tag
    button.tag = tag;
    
    return button;
}

+(UIButton *_Nullable)initWithFrame:(CGRect)frame target:(nonnull id)target action:(nonnull SEL)sel forControlEvents:(UIControlEvents)event tag:(int)tag
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn addTarget:target action:sel forControlEvents:event];
    btn.tag = tag;
    
    return btn;
}

//设置按钮的图片和文字的位置
- (void)layoutButtonWithEdgeInsetsStyle:(SK_ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    if (imageWith==0 && (style==SK_ButtonEdgeInsetsStyle_labelMostLeft || style==SK_ButtonEdgeInsetsStyle_labelMostRight)) {
        imageWith = self.width-labelWidth-space;
    }
    
    //左右空白间隔
    CGFloat blankWidth = (self.width-labelWidth-imageWith-space)/2;
    //    CGFloat blankHeight = (self.height-labelHeight-imageHeight)/2;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case SK_ButtonEdgeInsetsStyle_imgTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space, 0);
        }
            break;
        case SK_ButtonEdgeInsetsStyle_imgLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space, 0, space);
            labelEdgeInsets = UIEdgeInsetsMake(0, space, 0, -space);
        }
            break;
        case SK_ButtonEdgeInsetsStyle_imgBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space, -imageWith, 0, 0);
        }
            break;
        case SK_ButtonEdgeInsetsStyle_imgRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space, 0, -labelWidth-space);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space, 0, imageWith+space);
        }
            break;
        case SK_ButtonEdgeInsetsStyle_imgMostLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -blankWidth, 0, blankWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -blankWidth+space, 0, blankWidth-space);
        }
            break;
        case SK_ButtonEdgeInsetsStyle_imgMostRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, self.width-imageWith, 0, 0);
            labelEdgeInsets = UIEdgeInsetsMake(0, blankWidth-imageWith-space, 0, -blankWidth+space+imageWith);
        }
            break;
        case SK_ButtonEdgeInsetsStyle_labelMostLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, self.width-imageWith, 0, 0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space-blankWidth, 0, 0);
        }
            break;
        case SK_ButtonEdgeInsetsStyle_labelMostRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -blankWidth, 0, blankWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, self.width-labelWidth, 0, 0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
