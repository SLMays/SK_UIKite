//
//  UIViewController+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SKUtils)

//获取当前显示的控制器
+(UIViewController*) currentViewController;
//获取当前Window
+ (UIWindow *)MainWindow;

@end
