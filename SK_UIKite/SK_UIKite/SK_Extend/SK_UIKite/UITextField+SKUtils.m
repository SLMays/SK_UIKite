//
//  UITextField+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "UITextField+SKUtils.h"

@implementation UITextField (SKUtils)

+ (UITextField*_Nullable)initWithFrame:(CGRect)frame placeholder:(NSString*_Nullable)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*_Nullable)imageView rightImageView:(UIImageView*_Nullable)rightImageView font:(float)font backgRoundImageName:(UIImage *_Nullable)bgImg text:(NSString *_Nullable)textStr textBorderStyle:(UITextBorderStyle)textBorderStyle keyboardType:(UIKeyboardType)keyboardType textAlignment:(NSTextAlignment)textAlignment bgColor:(NSString *_Nullable)bgColor borderColor:(NSString *_Nullable)borderColor tag:(NSInteger)tag
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //密码状态
    textField.secureTextEntry=YESorNO;
    //关闭首字母大写
    textField.autocapitalizationType= UITextAutocapitalizationTypeNone;//(UITextAutocapitalizationType) NO;
    //清除按钮
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //修改textfield的clearbtn颜色
//    UIButton *cleanBtn = [textField valueForKey:@"_clearButton"]; //key是固定的
//    cleanBtn.lee_theme.LeeConfigButtonImage(IconF_ClearBtn, UIControlStateNormal);
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    textField.rightViewMode=UITextFieldViewModeAlways;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
//    textField.lee_theme.LeeConfigTextColor(TextFieldMainTextColor);
    //placeholder颜色
//    textField.lee_theme.LeeConfigPlaceholderColor(TextFieldPlaceHolderColor);
    //背景颜色
    if (STRING_IS_NOT_EMPTY(bgColor)) {
        textField.lee_theme.LeeConfigBackgroundColor(bgColor);
    }else{
        textField.backgroundColor = [UIColor clearColor];
    }
    if (STRING_IS_NOT_EMPTY(borderColor)) {
//        textField.bThemeColor = borderColor;
    }
    //背景图片
    textField.background = bgImg;
    //默认文字
    textField.text = textStr;
    //tag值
    textField.tag = tag;
    //输入框类型
    /*
     UITextBorderStyleNone,         //无
     UITextBorderStyleLine,         //线
     UITextBorderStyleBezel,        //3D
     UITextBorderStyleRoundedRect   //圆角
     */
    textField.borderStyle = textBorderStyle;
    
    //键盘类型
    /*
     UIKeyboardTypeDefault;               //字母+数字（全）（小地球）
     UIKeyboardTypeASCIICapable;          //字母+数字（全）（密码）
     UIKeyboardTypeNumbersAndPunctuation; //数字+字母（全）
     UIKeyboardTypeURL;                   //URL地址（全）（小地球）
     UIKeyboardTypeNumberPad;             //数字（九）
     UIKeyboardTypePhonePad;              //数字+*#（九）（电话号码）
     UIKeyboardTypeDecimalPad;            //数字+.（九）
     */
    textField.keyboardType = keyboardType;
    
    //对齐方式
    /*
     NSTextAlignmentLeft;              //居左
     NSTextAlignmentCenter;            //居中
     NSTextAlignmentRight;             //居右
     */
    textField.textAlignment = textAlignment;
    
    return textField;
}
//placeholder颜色
-(void)placeholderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}
//左边距
-(void)leftSpacing:(CGFloat)left
{
    self.leftView = [UIView initWithFrame:CGRectMake(0, 0, left, self.height) backgroundColor:nil alpha:0.0];
    self.leftViewMode = UITextFieldViewModeAlways;
}
//右边距
-(void)rightSpacing:(CGFloat)right
{
    self.rightView = [UIView initWithFrame:CGRectMake(0, 0, right, self.height) backgroundColor:nil alpha:0.0];
    self.rightViewMode = UITextFieldViewModeAlways;
}
//左图片
-(void)LeftImg:(UIImage *)leftImg
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, leftImg.size.width+5, leftImg.size.height)];
    imgView.image = leftImg;
    imgView.contentMode = UIViewContentModeCenter;
    self.leftView = imgView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
//右图片
-(void)RightImg:(UIImage *)rightImg
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rightImg.size.width+5, rightImg.size.height)];
    imgView.image = rightImg;
    imgView.contentMode = UIViewContentModeCenter;
    self.rightView = imgView;
    self.rightViewMode = UITextFieldViewModeAlways;
}
-(void)LeftIconFontImg:(NSString *_Nullable)leftImg  Size:(int)size
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
    imgView.lee_theme.LeeConfigImage(leftImg);
    imgView.contentMode = UIViewContentModeCenter;
    self.leftView = imgView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
-(void)RightIconFontImg:(NSString *_Nullable)rightImg  Size:(int)size
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
    imgView.lee_theme.LeeConfigImage(rightImg);
    imgView.contentMode = UIViewContentModeCenter;
    self.rightView = imgView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
