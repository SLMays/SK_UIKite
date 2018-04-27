//
//  SK_NavigationController.m
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/4/12.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_NavigationController.h"

@interface SK_NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SK_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //自定义UI
    [self initNavigation];
    
    //解决自定义返回按钮导致的不能拖·拖拽返回
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

-(void)initNavigation
{
    //修改导航栏颜色
    self.navigationBar.barTintColor = RandomColor;
    
    //修改导航栏字体颜色
    self.navigationBar.barStyle = UIBarStyleBlack;//白色
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RandomColor}];//其他自定义颜色
    
    //修改导航栏字体大小
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    
    //修改背景为图片
//    [self.navigationBar setBackgroundImage:[UIImage GradientImageFromColors:@[RandomColor,RandomColor] ByGradientType:(GradientType_leftToRight) addSuperView:self.navigationBar] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBackgroundImage:[UIImage GradientImageFromColors:@[COLORWITHRGBA(171, 0, 166, 1),COLORWITHRGBA(70, 0, 180, 1)] ByGradientType:(GradientType_leftToRight) addSuperView:self.navigationBar] forBarMetrics:UIBarMetricsDefault];

}
-(void)BackAction
{
    [self popViewControllerAnimated:YES];
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
