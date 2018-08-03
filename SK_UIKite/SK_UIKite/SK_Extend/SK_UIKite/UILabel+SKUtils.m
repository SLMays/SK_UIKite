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
+(UILabel*)initWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text setColor:(UIColor *)textColor numberOfLines:(int)numberOfLine textAlignment:(NSTextAlignment)textAlignment
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines = numberOfLine;
    //对齐方式
    label.textAlignment=textAlignment;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=textColor;
    label.text=text;
    
    return label;
}

//工厂模式   +方法
+(UILabel*)initWithFrame:(CGRect)frame Font:(UIFont*)font numberOfLines:(int)numberOfLine Text:(NSString*)text setColor:(UIColor*)textColor  textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor*)bgColor adjustsFontSizeToFitWidth:(BOOL)yesOrNo
{
    UILabel * label = [self initWithFrame:frame Font:0 Text:text setColor:textColor numberOfLines:numberOfLine textAlignment:textAlignment];
    
    label.font = font;
    if (textColor) {
        label.textColor = textColor;
    }else{
        label.textColor = [UIColor blackColor];
    }
    
    if (bgColor) {
        label.backgroundColor = bgColor;
    }else{
        label.backgroundColor = [UIColor clearColor];
    }
    
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth = yesOrNo;
    
    return label;
}
#pragma mark - 复制功能
@dynamic canCopy;

-(BOOL)canBecomeFirstResponder {
    return YES;
}
// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:));
}
//针对于响应方法的实现
-(void)copy:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}
//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)AddCopyHand
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}
//长按手势响应事件
-(void)handleTap:(UIGestureRecognizer*) recognizer {
    [self becomeFirstResponder];
    [[UIMenuController sharedMenuController] setMenuItems:nil];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
}

-(void)setCanCopy:(BOOL)canCopy
{
    if (canCopy) {
        [self AddCopyHand];
    }
}
@end
