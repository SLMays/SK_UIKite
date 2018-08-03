//
//  SK_Landscape_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/7/4.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_Landscape_ViewController.h"
#import "SK_Vertical_ViewController.h"

@interface SK_Landscape_ViewController ()

@end

@implementation SK_Landscape_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"横屏";
//    [self rotationLandscape];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self rotationLandscape];
}

-(void)BackAction
{
//    [self rotationPortrait];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SK_Vertical_ViewController * ver = [[SK_Vertical_ViewController alloc]init];
    [self.navigationController pushViewController:ver animated:YES];
}
#pragma mark - 竖屏
- (void)rotationPortrait
{
    [SupportedInterfaceOrientations sharedInstance].orientationMask = UIInterfaceOrientationMaskPortrait;
    
    NSNumber *orientationValue = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationValue forKey:@"orientation"];
}

#pragma mark - 横屏
- (void)rotationLandscape
{
    [SupportedInterfaceOrientations sharedInstance].orientationMask = UIInterfaceOrientationMaskLandscape;
    
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationValue = [NSNumber numberWithInt:UIInterfaceOrientationMaskLandscape];
    [[UIDevice currentDevice] setValue:orientationValue forKey:@"orientation"];
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
