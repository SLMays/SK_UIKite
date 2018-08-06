//
//  SK_ViewController.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "SK_ViewController.h"

@interface SK_ViewController ()<UINavigationControllerDelegate>

@end

@implementation SK_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self initNavigation];
    [self initTopBgImageView];
}
-(void)setCanBack:(BOOL)canBack
{
    if (!canBack) {
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = item;
    }
}

-(void)initNavigation
{
    //自定义返回按钮
    UIButton * backBtn = [UIButton initWithFrame:CGRectMake(0, 0, 44, 44) Title:@"" TitleColor:[UIColor whiteColor] BgColor:nil Image:SK_IconImageMake(K_IconFont_Back, 24, [UIColor whiteColor]) BgImage:nil Target:self Action:@selector(BackAction) ForControlEvents:UIControlEventTouchUpInside Tag:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //去掉系统导航栏返回按钮中的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}
-(void)BackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initTopBgImageView
{
    _topBgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_topBgImageView];
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
