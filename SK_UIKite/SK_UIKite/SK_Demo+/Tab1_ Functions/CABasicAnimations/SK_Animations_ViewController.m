//
//  SK_Animations_ViewController.m
//  SK_UIKite
//
//  Created by S&King on 2019/11/20.
//  Copyright © 2019 SKylin. All rights reserved.
//

#import "SK_Animations_ViewController.h"

@interface SK_Animations_ViewController ()

@end

@implementation SK_Animations_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)pingyiAction:(UIButton *)sender {
    //向上移动
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = NO;//默认就是NO，设置成Yes之后下面fillMode就不起作用了
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:-10];     //结束伸缩倍数
    [[sender layer] addAnimation:animation forKey:nil];
}

- (IBAction)zuofangAction:(UIButton *)sender {
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
    [[sender layer] addAnimation:animation forKey:nil];
}

- (IBAction)xuanzhuanAction:(id)sender {
    //z轴旋转360度
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:2*M_PI];     //结束伸缩倍数
    [[sender layer] addAnimation:animation forKey:nil];
}

- (IBAction)zuheAction:(UIButton *)sender
{
    //向上移动
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //速度控制函数，控制动画运行的节奏
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation1.toValue = [NSNumber numberWithFloat:-10];     //结束伸缩倍数
    
    //放大效果，并回到原位
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation2.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation2.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
    
    //z轴旋转360度
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //速度控制函数，控制动画运行的节奏
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation3.toValue = [NSNumber numberWithFloat:2*M_PI];     //结束伸缩倍数
    
    //创建组合
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    //这三行组合起来才有效果
    group.autoreverses = NO;//默认就是NO，设置成Yes之后下面fillMode就不起作用了
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    group.duration = 0.5;//播放时间
    group.repeatCount = 1;//循环次数

    group.animations = [NSArray arrayWithObjects:animation1, animation2, animation3, nil];
    [[sender layer] addAnimation:group forKey:@"move-rotate-scale-layer"];
}


@end
