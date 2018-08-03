//
//  Tab2_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/7/4.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "Tab2_ViewController.h"

@interface Tab2_ViewController ()
@property (nonatomic, strong) UIButton *themeButton;

@end

@implementation Tab2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.canBack = NO;
    [self initRightItem];
    [self makeUI];
}
- (void)makeUI {
    
    UIView * view = [UIView initWithFrame:CGRectMake(0, 20, WIDTH_IPHONE/2, 100) setBackgroundColor:RandomColor alpha:1.0 tag:1 centerX:WIDTH_IPHONE/2];
    [self.view addSubview:view];

    view.lee_theme.LeeConfigBackgroundColor(@"viewBgColor");
    
    UIButton * button = [UIButton initWithFrame:CGRectMake(40, view.bottom+20, WIDTH_IPHONE-80, 100) Title:@"" TitleColor:nil BgColor:nil Image:nil BgImage:nil Target:self Action:@selector(buttonClick:) ForControlEvents:UIControlEventTouchDown Tag:2];
    [button setTitle:@"有本事你点我啊！" forState:UIControlStateNormal];
    [button setTitle:@"哎呀！你还真敢点啊！" forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    
    button.lee_theme
    .LeeConfigBackgroundColor(@"btnBgColor")
    .LeeConfigButtonTitleColor(@"btnTitColor", UIControlStateNormal)
    .LeeConfigButtonTitleColor(@"btnTitHightColor", UIControlStateHighlighted);
    
    
    UILabel * label = [UILabel initWithFrame:CGRectMake(0, button.bottom+20, WIDTH_IPHONE, 30) Title:@"我是一个 Label 啊" TitleColor:nil BgColor:nil Font:[UIFont boldSystemFontOfSize:20] TextAlignment:NSTextAlignmentCenter Tag:3];
    [self.view addSubview:label];
    
    label.lee_theme.LeeConfigTextColor(@"labTextColor");
    
}

-(void)buttonClick:(UIButton *)btn
{
    
}



-(void)initRightItem
{
    UIButton * themeBtn = [UIButton initWithFrame:CGRectMake(0, 0, 44, 44) Title:@"" TitleColor:[UIColor grayColor] BgColor:nil Image:nil BgImage:nil Target:self Action:@selector(ThemeChangeClick:) ForControlEvents:UIControlEventTouchUpInside Tag:100];
    [themeBtn setTitle:@"夜晚" forState:UIControlStateNormal];
    [themeBtn setTitle:@"白天" forState:UIControlStateSelected];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:themeBtn];
    self.navigationItem.rightBarButtonItem = item;
}
-(void)ThemeChangeClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [LEETheme startTheme:Theme_Night];
    }else{
        [LEETheme startTheme:Theme_Day];
    }
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
