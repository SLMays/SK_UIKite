//
//  AppDelegate.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "AppDelegate.h"
#import "SK_TabBarController.h"
#import "Tab1_ViewController.h"
#import "SK_WebViewController.h"
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>

#define K_GCDTimer_LunchVTime  @"LunchVTime"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置主页面
    [self setRootView];

    //设置主题
    [self configTheme];
    
    //设置启动页
    [self setLaunchScreenImg];
    
    return YES;
}

-(UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

#pragma mark - 设置主题

- (void)configTheme{
    
    NSString *dayJsonPath   = [[NSBundle mainBundle] pathForResource:@"theme_day" ofType:@"json"];
    NSString *nightJsonPath = [[NSBundle mainBundle] pathForResource:@"theme_night" ofType:@"json"];
    NSString *dayJson = [NSString stringWithContentsOfFile:dayJsonPath encoding:NSUTF8StringEncoding error:nil];
    NSString *nightJson = [NSString stringWithContentsOfFile:nightJsonPath encoding:NSUTF8StringEncoding error:nil];
    [LEETheme addThemeConfigWithJson:dayJson Tag:Theme_Day ResourcesPath:nil];
    [LEETheme addThemeConfigWithJson:nightJson Tag:Theme_Night ResourcesPath:nil];

    [LEETheme defaultTheme:Theme_Day];
    
    //启动主题
    [LEETheme startTheme:Theme_Day];
}

-(void)setRootView
{
    Tab1_ViewController * vc1 = [[Tab1_ViewController alloc] init];
    SK_NavigationController * nav1 = [[SK_NavigationController alloc]initWithRootViewController:vc1];
    self.window.rootViewController = nav1;
    [self.window makeKeyAndVisible];
}

#pragma mark - 设置启动页
-(void)setLaunchScreenImg
{
    UIViewController *vc=[[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil]instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    self.lunchV=vc.view;
    self.lunchV.frame =[UIScreen mainScreen].bounds;
    [self.window addSubview:self.lunchV];
    [self.window bringSubviewToFront:self.lunchV];
    [self.window addSubview:self.clickBtn];
    [self.window addSubview:self.passBtn];
//    [self loadNetGif];//加载网络图片
    [self loadNativeGif];//加载本地图片
    [self start];
}
//加载网络GIF
-(void)loadNetGif
{
    FLAnimatedImageView * gifImgView = [[FLAnimatedImageView alloc]initWithFrame:self.lunchV.bounds];
    gifImgView.contentMode = UIViewContentModeScaleAspectFill;
    NSURL *url = [NSURL URLWithString:@"https://i.loli.net/2020/07/08/1cyr7S5Bmsxf4NR.gif"];
    [gifImgView sd_setImageWithURL:url];
    [self.lunchV addSubview:gifImgView];
    
}
//加载本地GIF
-(void)loadNativeGif
{
    FLAnimatedImageView * gifImgView = [[FLAnimatedImageView alloc]initWithFrame:self.lunchV.bounds];
    gifImgView.contentMode = UIViewContentModeScaleAspectFill;
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"gifLaunchScreen" ofType:@"gif"];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    [gifImgView setAnimatedImage:[FLAnimatedImage animatedImageWithGIFData:imageData]];
    [self.lunchV addSubview:gifImgView];
}
-(UIButton *)clickBtn
{
    if (!_clickBtn) {
        _clickBtn = [UIButton initWithFrame:self.lunchV.bounds target:self action:@selector(goToDetail) forControlEvents:UIControlEventTouchUpInside tag:0];
    }
    return _clickBtn;
}
-(void)goToDetail
{
    [self passAction];
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
    SK_WebViewController * web = [[SK_WebViewController alloc]initWithURL:url];
    web.hidesBottomBarWhenPushed = YES;
    [[UIViewController currentViewController].navigationController pushViewController:web animated:YES];
}
-(UIButton *)passBtn
{
    if (!_passBtn) {
        _passBtn = [UIButton initWithFrame:CGRectMake(0, 0, 60, 25) title:@"跳过" titleColor:Color_333333_333333 titleFont:[UIFont systemFontOfSize:14] bgColor:Color_FFFFFF_FFFFFF target:self action:@selector(passAction) tag:0];
        _passBtn.center = CGPointMake(WIDTH_IPHONE-40, Height_StatusBar+20);
        _passBtn.bRadius = 12.5;
    }
    return _passBtn;
}
-(void)passAction
{
    [[SK_GCDTimer sharedInstance] cancelTimerWithName:K_GCDTimer_LunchVTime];
    [self.lunchV removeFromSuperview];
    [self setRootView];
}
-(void)start{
    __block NSInteger second = 5;//加载时长
    
    SK_WEAKSELF
    [[SK_GCDTimer sharedInstance]checkExistTimer:K_GCDTimer_LunchVTime completion:^(BOOL doExist) {
        if (!doExist) {
            [[SK_GCDTimer sharedInstance]startDispatchTimerWithName:K_GCDTimer_LunchVTime timeInterval:1 queue:nil repeats:YES fireInstantly:NO action:^{
                if (second==0) {
                    [[SK_GCDTimer sharedInstance] cancelTimerWithName:K_GCDTimer_LunchVTime];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 追加在主线程中执行的任务
                        [_weakSelf.lunchV removeFromSuperview];
                        [_weakSelf setRootView];
                    });
                }else{
                    second--;
                }
            }];
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIApplication* app = [UIApplication sharedApplication];
    __block  UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



//可以用来做测试方法用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    if ([touches.anyObject locationInView:nil].y > Height_StatusBar) return;
    
    if ([touches.anyObject locationInView:nil].x<=(WIDTH_IPHONE/2)) {
        [self testLeftDemo];
    }else{
        [self testrRightDemo];
    }
}

-(void)testLeftDemo
{
   
}
-(void)testrRightDemo
{

}

@end

