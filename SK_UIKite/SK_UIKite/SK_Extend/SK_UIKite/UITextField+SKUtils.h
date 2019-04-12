//
//  UITextField+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SKUtils)

+ (UITextField*_Nullable)initWithFrame:(CGRect)frame placeholder:(NSString*_Nullable)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*_Nullable)imageView rightImageView:(UIImageView*_Nullable)rightImageView font:(float)font backgRoundImageName:(UIImage *_Nullable)bgImg text:(NSString *_Nullable)textStr textBorderStyle:(UITextBorderStyle)textBorderStyle keyboardType:(UIKeyboardType)keyboardType textAlignment:(NSTextAlignment)textAlignment bgColor:(NSString *_Nullable)bgColor borderColor:(NSString *_Nullable)borderColor tag:(NSInteger)tag;

-(void)placeholderColor:(UIColor *_Nullable)color;
-(void)leftSpacing:(CGFloat)left;
-(void)rightSpacing:(CGFloat)right;
-(void)LeftImg:(UIImage *_Nullable)leftImg;
-(void)RightImg:(UIImage *_Nullable)rightImg;
-(void)LeftIconFontImg:(NSString *_Nullable)leftImg Size:(int)size;
-(void)RightIconFontImg:(NSString *_Nullable)rightImg Size:(int)size;

@end
