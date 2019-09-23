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
    self.window.rootViewController = [[SK_TabBarController alloc] init];
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
    [self loadNetGif];
    [self start];
}
//加载网络GIF
-(void)loadNetGif{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.lunchV.bounds];
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554358521337&di=786503e1b451f9335e18ca75b2259414&imgtype=0&src=http%3A%2F%2Ftheiphonewalls.com%2Fwp-content%2Fuploads%2F2013%2F02%2FFinal-Fantasy.jpg"];
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LaunchImage"]];
    [self.lunchV addSubview:imageView];
}
//加载本地GIF
-(void)loadNativeGif{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.lunchV.bounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = [UIImage imageNamed:@"LaunchImage"];
    [self.lunchV addSubview:imgView];
}

-(void)start{
    __block NSInteger second = 3;//加载时长
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%ld",(long)second);
            if (second == 0) {
                [self.lunchV removeFromSuperview];
                [self setRootView];
                dispatch_cancel(timer);
            } else {
                second--;
            }
        });
    });
    dispatch_resume(timer);
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

