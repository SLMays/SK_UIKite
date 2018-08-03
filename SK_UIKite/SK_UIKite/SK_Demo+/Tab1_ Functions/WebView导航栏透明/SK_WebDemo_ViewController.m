//
//  SK_WebDemo_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/28.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_WebDemo_ViewController.h"


@interface SK_WebDemo_ViewController ()<UIScrollViewDelegate>
{
    UILabel * titleLabel;
}

@end

@implementation SK_WebDemo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    [self.navigationController setNavigationBarHidden:[viewController isKindOfClass:[self class]] animated:YES];
}
-(void)initUI
{
    //自定义导航栏
    UIView * navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, Height_NavigationBar)];
    navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navigationView];
    
    self.topBgImageView.image = [UIImage imageWithColor:RandomColor];
    
    //返回按钮
    UIButton * backBtn = [UIButton initWithFrame:CGRectMake(20, Height_NavigationBar-44, 44, 44) Title:@"" TitleColor:nil BgColor:nil Image:SK_IconImageMake(K_IconFont_Back, 24, [UIColor whiteColor]) BgImage:nil Target:self Action:@selector(BackAction) ForControlEvents:UIControlEventTouchUpInside Tag:0];
    [navigationView addSubview:backBtn];
    titleLabel = [UILabel initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE/2, 44) Title:@"渐变导航栏" TitleColor:[UIColor whiteColor] BgColor:nil Font:[UIFont boldSystemFontOfSize:18] TextAlignment:NSTextAlignmentCenter  Tag:1];
    titleLabel.center = CGPointMake(WIDTH_IPHONE/2, Height_NavigationBar-22);
    titleLabel.alpha = 0.0;
    [navigationView addSubview:titleLabel];
    
    
    //确保图层显示顺序
    [self.view bringSubviewToFront:navigationView];
}
-(void)BackAction
{
    
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
