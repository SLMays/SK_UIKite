//
//  Screenshot_ViewController.m
//  
//
//  Created by Skylin on 2018/8/3.
//

#import "Screenshot_ViewController.h"
#import <Social/Social.h>

@interface Screenshot_ViewController ()
@property (nonatomic, strong) UIImage *mainScreenshot;
@property (weak, nonatomic) IBOutlet UIImageView *shareImgView;

@end

@implementation Screenshot_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavigation
{
    [super initNavigation];
    
    UIButton * shareBtn = [UIButton initWithFrame:CGRectMake(0, 0, 44, 44) Title:@"" TitleColor:[UIColor whiteColor] BgColor:nil Image:SK_IconImageMake(k_IconFont_Share, 22, [UIColor whiteColor]) BgImage:nil Target:self Action:@selector(shareBtnClick) ForControlEvents:UIControlEventTouchUpInside Tag:0];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];

    self.navigationItem.rightBarButtonItem = item;
}

-(void)viewWillAppear:(BOOL)animated
{
    Notification_ADD(self, userDidTakeScreenshot:, UIApplicationUserDidTakeScreenshotNotification, nil);
}
-(void)viewWillDisappear:(BOOL)animated
{
    Notification_REMOVEAll(self);
}
#pragma mark - 用户截屏通知事件
- (void)userDidTakeScreenshot:(NSNotification *)notification {
    /*
     自定义处理方法的代码,随意吧
     */
    [self shareBtnClick];
}
- (UIImage *)processShareImage
{
    self.canBack = NO;
    self.navigationItem.rightBarButtonItem = nil;
    
//    UIImage * img = [UIImage shotWithView:self.view];   //除去导航栏
    UIImage * img = [UIImage shotScreen];                 //全屏幕
    UIImage * bottomImg = [UIImage imageNamed:@"ShareBottom"];
    img = [UIImage addSlaveImage:bottomImg toMasterImage:img directionType:(SK_DirectionType_TopToBottom)];
    
    self.canBack = YES;
    [self initNavigation];
    
    return img;
}
- (void)shareScreenshot
{
    //在这里呢 如果想分享图片 就把图片添加进去 【分享内容可以是 文字、图片、链接】
    NSArray *activityItems = @[_mainScreenshot];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}
-(void)shareBtnClick
{
    _mainScreenshot = [self processShareImage];
    
    CGFloat imgWidth = Width_Alert-20;
    CGFloat imgHeigth = imgWidth/ScreenRatio_WH;
    UIView * imgBgView = [UIView initWithFrame:CGRectMake(0, 0, Width_Alert, imgHeigth+20) backgroundColor:[UIColor whiteColor] alpha:1.0];
    UIImageView * imgView = [UIImageView initWithFrame:CGRectMake(10, 10, imgWidth, imgHeigth) Image:_mainScreenshot ContentMode:(UIViewContentModeScaleAspectFit) Tag:0 String:nil];
    [imgBgView addSubview:imgView];
    
    SK_AlertView * alertView = [[SK_AlertView alloc]init];
    [alertView setContainerView:imgBgView];
    [alertView setButtonTitles:@[@"分享", @"取消"]];
    [alertView setButtonTags:@[@(1),@(0)]];
    [alertView setButtonBgColors:@[AlertBtnBgColor_Confirm,AlertBtnBgColor_Cancel]];
    [alertView setOnButtonTouchUpInside:^(SK_AlertView *alertView, int buttonIndex) {
        [alertView close];
        if (buttonIndex) {
            [self shareScreenshot];
        }else{
            _mainScreenshot = nil;
        }
    }];
    [alertView setUseMotionEffects:true];
    [alertView show];
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
