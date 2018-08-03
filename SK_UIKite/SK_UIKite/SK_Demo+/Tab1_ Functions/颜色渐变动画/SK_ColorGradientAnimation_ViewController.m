//
//  SK_ColorGradientAnimation_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/27.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_ColorGradientAnimation_ViewController.h"
#import "WHGradientHelper.h"

@interface SK_ColorGradientAnimation_ViewController ()

@end

@implementation SK_ColorGradientAnimation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    CGFloat height = NOHAVE_TABBAR_HEIGHT/4;
    
    for (int i=0; i<4; i++) {
        UIView * animationView = [UIView initWithFrame:CGRectMake(0, height*i, WIDTH_IPHONE, height) setBackgroundColor:RandomColor alpha:1.0];
        [self.view addSubview:animationView];
        [WHGradientHelper addGradientChromatoAnimation:animationView directionType:i];
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
