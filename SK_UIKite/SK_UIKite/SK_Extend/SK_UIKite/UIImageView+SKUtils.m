//
//  UIImageView+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "UIImageView+SKUtils.h"

@implementation UIImageView (SKUtils)
@dynamic Str;

+(UIImageView *)initWithFrame:(CGRect)frame Image:(UIImage *)image ContentMode:(UIViewContentMode)contentMode Tag:(int)tag String:(NSString *)str
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = image;
    imageView.tag = tag;
    imageView.contentMode = contentMode;
    imageView.userInteractionEnabled = YES;
    
    UILabel * label = [UILabel initWithFrame:imageView.bounds Title:str TitleColor:[UIColor whiteColor] BgColor:[UIColor clearColor] Font:[UIFont boldSystemFontOfSize:25] TextAlignment:NSTextAlignmentCenter Tag:15379];
    label.userInteractionEnabled = YES;
    [imageView addSubview:label];
    
    return imageView;
}

-(void)setStr:(NSString *)Str
{
    UILabel * lab = (UILabel *)[self viewWithTag:15379];
    lab.text = Str;
}

@end
