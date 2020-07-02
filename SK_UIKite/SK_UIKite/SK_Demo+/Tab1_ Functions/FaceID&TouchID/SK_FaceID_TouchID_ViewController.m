//
//  SK_FaceID_TouchID_ViewController.m
//  SK_UIKite
//
//  Created by S&King on 2020/6/29.
//  Copyright © 2020 SKylin. All rights reserved.
//

#import "SK_FaceID_TouchID_ViewController.h"
#import "YZAuthID.h"

#define iPhoneXAfter (UIScreen.mainScreen.bounds.size.width == 375.f && UIScreen.mainScreen.bounds.size.height == 812.f)


@interface SK_FaceID_TouchID_ViewController ()
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *btnTitle;
@property (nonatomic, strong) YZAuthID *authID;
@end

@implementation SK_FaceID_TouchID_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(iPhoneXAfter){
        self.imgName = @"img_FaceID";
        self.btnTitle = @"面容";
    }else{
        self.imgName = @"img_TouchID";
        self.btnTitle = @"指纹";
    }
    
    self.authID = [[YZAuthID alloc] init];
    
    UIButton * verifyBtn = [UIButton initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE/2, WIDTH_IPHONE/2) imageName:self.imgName btnBgImage:nil target:self action:@selector(startVerify) title:self.btnTitle bgColor:nil titleColor:Color_Random titleFont:[UIFont systemFontOfSize:15] tag:0];
    verifyBtn.center = self.view.center;
    [verifyBtn layoutButtonWithEdgeInsetsStyle:(SK_ButtonEdgeInsetsStyle_imgTop) imageTitleSpace:20];
    [self.view addSubview:verifyBtn];
    
}

-(void)startVerify
{
    [self.authID yz_showAuthIDWithDescribe:nil block:^(YZAuthIDState state, NSError *error) {
        
        if (state == YZAuthIDStateNotSupport) { // 不支持TouchID/FaceID
            SKToast(@"对不起，当前设备不支持指纹/面容ID");
        } else if(state == YZAuthIDStateFail) { // 认证失败
            NSString * str = [NSString stringWithFormat:@"%@ID不正确，认证失败",self.btnTitle];
            SKToast(str);
        } else if(state == YZAuthIDStateTouchIDLockout) {   // 多次错误，已被锁定
            NSString * str = [NSString stringWithFormat:@"多次错误，%@ID已被锁定，请到手机解锁界面输入密码",self.btnTitle];
            SKToast(str);
        } else if (state == YZAuthIDStateSuccess) { // TouchID/FaceID验证成功
            SKToast(@"认证成功！");
        }
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
