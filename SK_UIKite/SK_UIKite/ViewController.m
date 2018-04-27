//
//  ViewController.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "ViewController.h"
#import "SK_DemoMenuClass_Header.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) NSArray * DemoMenuListArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    self.canBack = NO;
    self.title = @"功能列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableView];
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    [self.navigationController setNavigationBarHidden:![viewController isKindOfClass:[self class]] animated:YES];
}
-(NSArray *)DemoMenuListArr
{
    if (!_DemoMenuListArr) {
        _DemoMenuListArr = @[@{K_MenuTitle:@"自定义导航栏颜色渐变",K_MenuClass:@"SK_NavigationAlpha_ViewController"},
                             @{K_MenuTitle:@"IconFont主题",K_MenuClass:@"SK_IconFont_ViewController"},
                             @{K_MenuTitle:@"制作GIF",K_MenuClass:@"SK_MakeGIF_ViewController"},
                             @{K_MenuTitle:@"图像识别技术",K_MenuClass:@"SK_OCR_ViewController"},
                             @{K_MenuTitle:@"语音识别",K_MenuClass:@"SK_SpeechRecognition_ViewController"},
                             @{K_MenuTitle:@"颜色渐变动画",K_MenuClass:@"SK_ColorGradientAnimation_ViewController"}];
    }
    return _DemoMenuListArr;
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [UITableView initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, HEIGHT_IPHONE) Style:UITableViewStylePlain Delegate:self SeparatorStyle:SK_TableViewCellSeparatorStyle_Full];
    }
    return _mainTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DemoMenuListArr.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * Identifier = @"Demo";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:Identifier];
    }
    
    cell.textLabel.text = [self.DemoMenuListArr[indexPath.row] objectForKey:K_MenuTitle];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class class = NSClassFromString([self.DemoMenuListArr[indexPath.row] objectForKey:K_MenuClass]);
    if (class) {
        UIViewController * vc = [[class alloc]init];
        vc.navigationItem.title = [self.DemoMenuListArr[indexPath.row] objectForKey:K_MenuTitle];
        [self.navigationController pushViewController:vc animated:YES];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
