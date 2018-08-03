//
//  SK_WebNavigation_ViewController.h
//  SK_UIKite
//
//  Created by Skylin on 2018/5/11.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_ViewController.h"

@interface SK_WebNavigation_ViewController : SK_ViewController

@property (nonatomic, copy) NSURL * url;//链接
@property (nonatomic, copy) NSString * titleText;//标题
@property (nonatomic, assign) BOOL  navAlpha;//导航是否透明
@property (nonatomic, strong) UIColor * navBgColor;//导航背景颜色
@property (nonatomic, strong) UIImage * navBgImage;//导航背景图片


@end
