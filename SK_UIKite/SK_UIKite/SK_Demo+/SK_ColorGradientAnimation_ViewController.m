//
//  SK_ColorGradientAnimation_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/27.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_ColorGradientAnimation_ViewController.h"

@interface SK_ColorGradientAnimation_ViewController ()
{
    UIImageView * bgView;
}

@end

@implementation SK_ColorGradientAnimation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, WIDTH_IPHONE, 45)];
    bgView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:bgView];
    
    UIButton * btn = [UIButton initWithFrame:CGRectMake(0, bgView.bottom+75, 100, 100) Title:@"开始" TitleColor:[UIColor whiteColor] BgColor:RandomColor Image:nil BgImage:nil Target:self Action:@selector(Action) ForControlEvents:(UIControlEventTouchUpInside) Tag:0];
    btn.centerX = WIDTH_IPHONE/2;
    btn.bRadius = 50;
    [self.view addSubview:btn];
}

-(void)Action{
  //还未实现
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
