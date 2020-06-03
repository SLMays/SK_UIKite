//
//  SK_LottieAnim_ViewController.m
//  SK_UIKite
//
//  Created by S&King on 2020/1/15.
//  Copyright © 2020 SKylin. All rights reserved.
//

#import "SK_LottieAnim_ViewController.h"
#import <Lottie/Lottie.h>

@interface SK_LottieAnim_ViewController ()
@property (nonatomic, strong) LOTAnimationView * anim;
@property (nonatomic, strong) LOTAnimationView * lottieAnim;
@end

@implementation SK_LottieAnim_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}
-(void)initNavigation
{
    [super initNavigation];
    
    UIButton * refBtn = [UIButton initWithFrame:CGRectMake(0, 0, 44, 44) target:self action:@selector(refreshLottieLogoAnim) forControlEvents:(UIControlEventTouchUpInside) tag:0];
    [refBtn setImage:SK_IconImageMake_Hex(k_IconFont_Refresh, 22, Color_FFFFFF_FFFFFF) forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:refBtn];
}
-(void)refreshLottieLogoAnim
{
    [_lottieAnim playWithCompletion:^(BOOL animationFinished) {
        
    }];
}
-(void)initUI
{
    _lottieAnim = [LOTAnimationView animationNamed:@"LottieLogo"];
    _lottieAnim.contentMode = UIViewContentModeScaleAspectFill;
    _lottieAnim.frame = CGRectMake(0, 0, WIDTH_IPHONE, HAVE_TABBAR_HEIGHT);
    [self.view addSubview:_lottieAnim];
    [_lottieAnim playWithCompletion:^(BOOL animationFinished) {
        
    }];
    
    
    UIView * tabBarView = [UIView initWithFrame:CGRectMake(0, HAVE_TABBAR_HEIGHT, WIDTH_IPHONE, Height_TabBar) backgroundColor:nil alpha:1.0];
    tabBarView.lee_theme.LeeConfigBackgroundColor(Color_Radom);
    [self.view addSubview:tabBarView];
    
    _anim = [LOTAnimationView animationNamed:@"shouye"];
    _anim.contentMode = UIViewContentModeScaleAspectFit;
    _anim.tintColor = [UIColor blackColor];
    _anim.frame = CGRectMake((WIDTH_IPHONE/3), 0, (WIDTH_IPHONE/3), Height_TabBar);
    [tabBarView addSubview:_anim];
    UITapGestureRecognizer *play = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playAnim)];
    [_anim addGestureRecognizer:play];
}

-(void)playAnim
{
    [_anim playWithCompletion:^(BOOL animationFinished) {
        NSLog(@"完成");
    }];
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
