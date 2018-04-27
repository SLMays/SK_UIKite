//
//  SK_IconFont_ViewController.m
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/4/12.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_IconFont_ViewController.h"

@interface SK_IconFont_ViewController ()

@end

@implementation SK_IconFont_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initMainView];
}
-(void)initUI
{
    SK_IconInfoMake(k_IconFont_Tab1, 24, RandomColor);
    UIButton * searchBtn = [UIButton initWithFrame:CGRectMake(0, 0, 44, 44) Title:nil TitleColor:nil BgColor:nil Image:SK_IconImageMake(k_IconFont_Search, 24, [UIColor whiteColor]) BgImage:nil Target:self Action:@selector(SearchAction) ForControlEvents:UIControlEventTouchUpInside Tag:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    //假的tabbar
    UIView * tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, HAVE_TABBAR_HEIGHT, WIDTH_IPHONE, Height_TabBar)];
    tabbarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tabbarView];
    NSArray * iconArr = @[k_IconFont_Tab1,k_IconFont_Tab2,k_IconFont_Tab3,k_IconFont_Tab4];
    CGFloat btnWidth = WIDTH_IPHONE/4;
    for (int i=0; i<4; i++) {
        UIButton * btn = [UIButton initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, Height_TabBar) Title:iconArr[i] TitleColor:RandomColor BgColor:nil Image:nil BgImage:nil Target:self Action:@selector(tabBarChange:) ForControlEvents:UIControlEventTouchUpInside Tag:100+i];
        btn.titleLabel.font = [UIFont fontWithName:@"iconFont" size:24];
        [tabbarView addSubview:btn];
    }
}
-(void)initMainView
{
    NSArray * dayArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSArray * WeatherArr = @[k_IconFont_Weather_1,k_IconFont_Weather_2,k_IconFont_Weather_3,k_IconFont_Weather_4,
                             k_IconFont_Weather_5,k_IconFont_Weather_6,k_IconFont_Weather_7,k_IconFont_Weather_8,
                             k_IconFont_Weather_9,k_IconFont_Weather_10,k_IconFont_Weather_11,k_IconFont_Weather_12,
                             k_IconFont_Weather_13,k_IconFont_Weather_14,k_IconFont_Weather_15,k_IconFont_Weather_16,
                             k_IconFont_Weather_17,k_IconFont_Weather_8,k_IconFont_Weather_9,k_IconFont_Weather_20];
    
    
    UILabel * title = [UILabel initWithFrame:CGRectMake(0, 50, WIDTH_IPHONE, 35) Title:@"一周天气预报(Label形式)" TitleColor:[UIColor whiteColor] BgColor:nil Font:[UIFont boldSystemFontOfSize:20] TextAlignment:NSTextAlignmentCenter  Tag:1];
    [self.view addSubview:title];
    
    CGFloat width = (WIDTH_IPHONE-20)/2;
    CGFloat height = 35;
    CGFloat top = title.bottom+35;
    for (int i=0; i<7; i++) {
        UILabel * day = [UILabel initWithFrame:CGRectMake(0, top+i*height, width, height) Title:dayArr[i] TitleColor:[UIColor whiteColor] BgColor:nil Font:[UIFont systemFontOfSize:20] TextAlignment:NSTextAlignmentRight  Tag:2];
        [self.view addSubview:day];
        
        int n = [RandomNumber((int)WeatherArr.count) intValue];
        NSString * wstr = WeatherArr[n];
        UILabel * weather = [UILabel initWithFrame:CGRectMake(width+20, top+i*height, width, height) Title:wstr TitleColor:RandomColor BgColor:[UIColor clearColor] Font:[UIFont fontWithName:@"iconfont" size:25] TextAlignment:NSTextAlignmentLeft Tag:3];
        [self.view addSubview:weather];
    }
}

-(void)SearchAction
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你点击了【图片】形式的搜索按钮" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)tabBarChange:(UIButton *)btn
{
    self.view.backgroundColor = btn.titleLabel.textColor;
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
