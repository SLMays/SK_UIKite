//
//  UIWebView+SKUtils.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/11.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "UIWebView+SKUtils.h"

@implementation UIWebView (SKUtils)

+(UIWebView *)initWithFrame:(CGRect)frame Delegate:(id)delegate
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:frame];
    webView.delegate = delegate;
    
    
    return webView;
}

@end
