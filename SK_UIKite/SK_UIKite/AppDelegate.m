//
//  AppDelegate.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "AppDelegate.h"
#import "SK_TabBarController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"  //微信SDK头文件

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    sleep(1.5f);
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[SK_TabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    
    //设置主题
    [self configTheme];
    
    //启动主题
    [LEETheme startTheme:Theme_Day];
    
    //配置shareSDK
    [self configShare];
    
    return YES;
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
}

#pragma mark - 配置微信分享
- (void)configShare
{
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat)]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {

         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             default:
                 break;
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


@end

