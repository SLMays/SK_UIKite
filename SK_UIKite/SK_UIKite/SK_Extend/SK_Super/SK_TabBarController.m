//
//  SK_TabBarController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/27.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_TabBarController.h"
#import "Tab1_ViewController.h"
#import "Tab2_ViewController.h"

@interface SK_TabBarController ()

@end

@implementation SK_TabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configRootViewControllers];
    
    //修改tabbar背景颜色
    [UITabBar appearance].translucent = NO;
    UIImageView * tabbarBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, Height_TabBar)];
    tabbarBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tabBar insertSubview:tabbarBgView atIndex:0];
}

- (void)configRootViewControllers
{
    
    Tab1_ViewController * vc1 = [[Tab1_ViewController alloc] init];
    SK_NavigationController * nav1 = [[SK_NavigationController alloc]initWithRootViewController:vc1];

    Tab2_ViewController * vc2 = [[Tab2_ViewController alloc] init];
    SK_NavigationController * nav2 = [[SK_NavigationController alloc]initWithRootViewController:vc2];

    //设置tabbar
    [self addChildVC:vc1 titile:@"功能" iconFontName:k_IconFont_Tab1 selectIconFontName:k_IconFont_Tab1];
    [self addChildVC:vc2 titile:@"主题" iconFontName:k_IconFont_Tab2 selectIconFontName:k_IconFont_Tab2];
    
    
    self.viewControllers =  @[nav1,nav2];
}

/**
 *  添加子控制器
 *
 *  @param viewController VC
 *  @param title          标题
 *  @param imageName      图片名称
 *  @param selectImgName  选中图片名称
 */
- (void)addChildVC:(UIViewController *)viewController titile:(NSString *)title imageName:(NSString *)imageName selectImg:(NSString *)selectImgName
{
    
    //同时设置TabBar,Nav 标题
    viewController.title = title;

    //设置tabbar的文字颜色 , 没有图片没有效果
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor purpleColor];
    NSMutableDictionary *normalTestAtts = [NSMutableDictionary dictionary];
    normalTestAtts[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [viewController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:normalTestAtts forState:UIControlStateNormal];
    
    //设置图片 , 并且不渲染
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置选中图片 , 并且不渲染
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImgName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)addChildVC:(UIViewController *)viewController titile:(NSString *)title iconFontName:(NSString *)iconFontName selectIconFontName:(NSString *)selectIconFontName
{
    
    //同时设置TabBar,Nav 标题
    viewController.title = title;
    
    //设置tabbar的文字颜色 , 没有图片没有效果
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    NSMutableDictionary *normalTestAtts = [NSMutableDictionary dictionary];
    normalTestAtts[NSForegroundColorAttributeName] = [UIColor grayColor];
    [viewController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:normalTestAtts forState:UIControlStateNormal];
    
    //设置图片 , 并且不渲染
    viewController.tabBarItem.image = SK_IconImageMake(iconFontName, 24, [UIColor whiteColor]);
    
    //设置选中图片 , 并且不渲染
    viewController.tabBarItem.selectedImage = SK_IconImageMake(selectIconFontName, 24, [UIColor whiteColor]);
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
