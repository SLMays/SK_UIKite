//
//  UIImageView+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SKUtils)

@property (nonatomic,strong) NSString * Str;
+(UIImageView *)initWithFrame:(CGRect)frame Image:(UIImage *)image ContentMode:(UIViewContentMode)contentMode Tag:(int)tag String:(NSString *)str;


@end
