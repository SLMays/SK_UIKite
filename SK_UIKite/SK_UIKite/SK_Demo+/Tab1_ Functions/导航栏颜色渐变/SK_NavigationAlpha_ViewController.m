//
//  SK_NavigationAlpha_ViewController.m
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/4/11.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_NavigationAlpha_ViewController.h"

#define HeadViewHeight  (170+Height_NavigationBar+Height_StatusBar)
@interface SK_NavigationAlpha_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIImageView * navigationBgView;//导航栏背景
    UITableView * mainTableView;
    UIImageView * headImageView;
    UILabel * titleLabel;
    
}
@end

@implementation SK_NavigationAlpha_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    [self.navigationController setNavigationBarHidden:[viewController isKindOfClass:[self class]] animated:YES];
}

-(void)initUI
{
    //自定义导航栏
    UIView * navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, Height_NavigationBar)];
    navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navigationView];
    
    navigationBgView = [[UIImageView alloc]initWithFrame:navigationView.bounds];
    navigationBgView.image = [UIImage GradientImageFromColors:@[COLORWITHRGBA(171, 0, 166, 1),COLORWITHRGBA(70, 0, 180, 1)] ByGradientType:(SK_GradientType_leftToRight) frame:navigationBgView.bounds];
    navigationBgView.alpha = 0.0;
    [navigationView addSubview:navigationBgView];
    
    
    //返回按钮
    UIButton * backBtn = [UIButton initWithFrame:CGRectMake(0, Height_StatusBar, 44, 44) Title:@"" TitleColor:nil BgColor:nil Image:SK_IconImageMake(K_IconFont_Back, 24, [UIColor whiteColor]) BgImage:nil Target:self Action:@selector(BackAction) ForControlEvents:UIControlEventTouchUpInside Tag:0];
    [navigationView addSubview:backBtn];
    titleLabel = [UILabel initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE/2, 44) Title:@"渐变导航栏" TitleColor:[UIColor whiteColor] BgColor:nil Font:[UIFont boldSystemFontOfSize:18] TextAlignment:NSTextAlignmentCenter  Tag:1];
    titleLabel.center = CGPointMake(WIDTH_IPHONE/2, Height_NavigationBar-22);
    titleLabel.alpha = 0.0;
    [navigationView addSubview:titleLabel];
    
    //头部背景图片
    /**
     *CIGaussianBlur ---> 高斯模糊
     *CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
     *CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
     *CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
     *CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
     */
    headImageView = [UIImageView initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, HeadViewHeight) Image:[[UIImage imageNamed:@"timg.jpeg"] blurImage] ContentMode:(UIViewContentModeScaleAspectFill) Tag:0 String:@""];
    headImageView.clipsToBounds = YES;//截掉多余的部分
    [self.view addSubview:headImageView];
    

    //TableView的HeadView
    UIView * headView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, HeadViewHeight)];
    headView.backgroundColor = [UIColor clearColor];
    
    //头像
    CGFloat headWidth = 100;
    UIImageView * headImgView = [UIImageView initWithFrame:CGRectMake(0, 0, headWidth, headWidth) Image:[UIImage imageNamed:@"timg.jpeg"] ContentMode:UIViewContentModeScaleAspectFill Tag:1 String:@""];
    headImgView.bRadius = headWidth/2;
    headImgView.center = CGPointMake(WIDTH_IPHONE/2, headView.height/2);
    [headView addSubview:headImgView];
    
    //列表内容
    mainTableView = [UITableView initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, HEIGHT_IPHONE) Style:UITableViewStylePlain Delegate:self SeparatorStyle:SK_TableViewCellSeparatorStyle_Full];
    mainTableView.backgroundColor = [UIColor clearColor];
     mainTableView.tableHeaderView = headView;
     [self.view addSubview:mainTableView];
    
    //确保图层显示顺序 
    [self.view bringSubviewToFront:navigationView];

}

-(void)BackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第 %d 行",(int)indexPath.row+1];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    
    if (y<0) {
        headImageView.height = HeadViewHeight - y;
        headImageView.top = 0;
    }else{
        headImageView.frame = CGRectMake(0, -y, WIDTH_IPHONE, HeadViewHeight);
    }
    
    if (y<HeadViewHeight-Height_NavigationBar) {
        float alp = y/HeadViewHeight;
        navigationBgView.alpha = alp;
        titleLabel.alpha = alp;
    }else{
        navigationBgView.alpha = 1.0;
        titleLabel.alpha = 1.0;
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
