//
//  SK_ViewController.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK_ViewController : UIViewController

@property (nonatomic, assign, getter=isCanBack) BOOL  canBack;//是否可以返回
@property (nonatomic, strong) UIImageView * topBgImageView;//顶部背景图片
-(void)BackAction;
@end
