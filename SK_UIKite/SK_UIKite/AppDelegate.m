//
//  AppDelegate.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "AppDelegate.h"
#import "SK_TabBarController.h"

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
    
    //启动主题
    [LEETheme startTheme:Theme_Day];
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


//可以用来做测试方法用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    if ([touches.anyObject locationInView:nil].y > Height_StatusBar) return;
    [self testDemo];
}
-(void)testDemo
{

}

@end

