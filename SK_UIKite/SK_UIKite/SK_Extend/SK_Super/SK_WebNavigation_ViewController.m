//
//  SK_WebNavigation_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/11.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_WebNavigation_ViewController.h"

@interface SK_WebNavigation_ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIImageView * navigationView;
@property (nonatomic, strong) UIWebView * webView;

@end

@implementation SK_WebNavigation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    if (_navAlpha) {
        [self.navigationController setNavigationBarHidden:[viewController isKindOfClass:[self class]] animated:YES];
    }
}
-(void)initUI
{
    if (self.navAlpha) {
        [self navigationView];
    }
    
}
#pragma mark - 自定义导航栏
-(UIView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, Height_NavigationBar)];
        _navigationView.backgroundColor = _navBgColor;
        _navigationView.image = _navBgImage;
        
        UILabel * title = [UILabel initWithFrame:CGRectMake(0, Height_StatusBar, 0, 44) Title:_titleText TitleColor:[UIColor whiteColor] BgColor:nil Font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentCenter Tag:0];
        [title sizeToFit];
        title.centerX = WIDTH_IPHONE/2;
        [_navigationView addSubview:title];
        
        if (self.isCanBack) {
            UIButton * backBtn = [UIButton initWithFrame:CGRectMake(20, Height_StatusBar, 44, 44) Title:nil TitleColor:nil BgColor:[UIColor whiteColor] Image:SK_IconImageMake(K_IconFont_Back, 24, [UIColor whiteColor]) BgImage:nil Target:self Action:@selector(BackAction) ForControlEvents:UIControlEventTouchUpInside Tag:1];
            [_navigationView addSubview:backBtn];
        }
    }
    return _navigationView;
}

#pragma mark - WebView
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
        _webView.opaque = YES;
        _webView.delegate =self;
        _webView.scalesPageToFit = YES;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _webView.contentMode = UIViewContentModeRedraw;
        if (self.navAlpha) _webView.frame = CGRectMake(0, -20, WIDTH_IPHONE, self.view.height+20);
        
    }
    return _webView;
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
