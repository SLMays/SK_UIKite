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



#pragma mark - 【键盘弹起回收问题】
/**
 *  是否支持视图上移
 */
@property (nonatomic, assign) BOOL canMove;
/**
 *  点击回收键盘、移动的视图，默认是当前控制器的view
 */
@property (nonatomic, strong) UIView * _Nullable moveView;
/**
 *  textfield底部距离键盘顶部的距离
 */
@property (nonatomic, assign) CGFloat heightToKeyboard;

@property (nonatomic, assign, readonly) CGFloat keyboardY;
@property (nonatomic, assign, readonly) CGFloat keyboardHeight;
@property (nonatomic, assign, readonly) CGFloat initialY;
@property (nonatomic, assign, readonly) CGFloat totalHeight;
@property (nonatomic, strong, readonly) UITapGestureRecognizer * _Nullable tapGesture;
@property (nonatomic, assign, readonly) BOOL hasContentOffset;



@end
