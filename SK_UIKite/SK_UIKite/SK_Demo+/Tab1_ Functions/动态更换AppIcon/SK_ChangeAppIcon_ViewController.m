//
//  SK_ChangeAppIcon_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2019/4/11.
//  Copyright © 2019 SKylin. All rights reserved.
//

#import "SK_ChangeAppIcon_ViewController.h"

@interface SK_ChangeAppIcon_ViewController ()

@end

@implementation SK_ChangeAppIcon_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self makeUI];
}
-(void)makeUI
{
    UIImageView * bgImgView = [[UIImageView alloc]initWithImage:[UIImage GradientImageFromColors:@[RandomColor,RandomColor,RandomColor] ByGradientType:(SK_GradientType_upleftTolowRight) frame:self.view.bounds]];
    [self.view addSubview:bgImgView];
    
    
    CGFloat imgSize = 120;
    CGFloat interval = 60;
    CGFloat left = (WIDTH_IPHONE-imgSize*2-interval)/2;
    for (int i=0; i<5; i++) {
        NSString * iconName = [NSString stringWithFormat:@"icon_%d",i+1];
        NSString * suffix = @"iPhoneApp_60pt";
        UIButton * btn = [UIButton initWithFrame:CGRectMake(left+i%2*(imgSize+interval), Height_NavigationBar+i*75, imgSize, imgSize) imageName:nil btnBgImage:[NSString stringWithFormat:@"%@%@",iconName,suffix] target:self action:@selector(changeAppIconWithName:) bgColor:nil tag:i];
        [btn setTitle:iconName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        btn.bRadius = 4;
        [self.view addSubview:btn];
    }
    
    UIButton * restoreBtn = [UIButton initWithFrame:CGRectMake(0, NOHAVE_TABBAR_HEIGHT-45, WIDTH_IPHONE, 45) title:@"还原" titleColor:@"btnTitColor" titleFont:[UIFont boldSystemFontOfSize:20] bgColor:@"btnBgColor" target:self action:@selector(restoreAppIcon) tag:10];
    [self.view addSubview:restoreBtn];
}

- (void)changeAppIconWithName:(UIButton *)btn {
    
    NSString * iconName = btn.currentTitle;
    
    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
            return;
        }
        
        if ([iconName isEqualToString:@""]) {
            iconName = nil;
        }
        
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"更换app图标发生错误了 ： %@",error);
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}
-(void)restoreAppIcon
{
    if (@available(iOS 10.3, *)) {
        if ([UIApplication sharedApplication].alternateIconName != nil) {//已经被替换掉了图标
            [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"成功还原图标");
                }else{
                    NSLog(@"error:%@",error);
                }
            }];
        }
    } else {
        // Fallback on earlier versions
    }
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
