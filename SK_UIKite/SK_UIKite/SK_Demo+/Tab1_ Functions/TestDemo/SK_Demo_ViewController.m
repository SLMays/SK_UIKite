//
//  SK_Demo_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/25.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_Demo_ViewController.h"


@interface SK_Demo_ViewController ()

@end

@implementation SK_Demo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat btnHeicht = NOHAVE_TABBAR_HEIGHT/2;
    for (int i=0; i<2; i++) {
        UIButton * btn = [UIButton initWithFrame:CGRectMake(0, i*btnHeicht, WIDTH_IPHONE, btnHeicht) title:i==0?@"增":@"删" titleColor:nil titleFont:[UIFont boldSystemFontOfSize:52] bgColor:nil target:self action:@selector(btnClick:) tag:i];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:RandomColor];
        [self.view addSubview:btn];
    }
}
-(void)btnClick:(UIButton *)btn
{
    int tag = (int)btn.tag;
    if (tag==0) {
        [self testLeftDemo];
    }else{
        [self testrRightDemo];
    }
}

#define loginUser   @"I9aq8FrwoAK7qMrbDYP3Eg=="
-(void)testLeftDemo
{
    static int i = 0;
    NSString * gname = [NSString stringWithFormat:@"%d",i++];
    
    NSString * post = [NSString stringWithFormat:@"http://st.lovestockhome.com/st-app/userStockGroup/addUserStockGroup?&version=MM_IOS_V1.0_181211&groupName=%@&order=0&loginUser=%@&alias=Simulator&onlyid=720D03DF-14C8-4CE5-9764-E1B4F25D5081",gname,loginUser];
    
    [SK_HTTPClient post:post
             parameters:nil
                success:^(NSURLSessionDataTask *operation, id responseObject, BOOL isOK) {
                    SKToast(responseObject[@"msg"]);
                    NSLog(@"%@",responseObject);
                    [self loadData_ALl];
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    SKToast_Error(error);
                }];
}
-(void)testrRightDemo
{
    static int i = 507;
    NSString * gid = [NSString stringWithFormat:@"%d",i++];
    
    NSString * post = [NSString stringWithFormat:@"http://st.lovestockhome.com/st-app/userStockGroup/delUserStockGroup?&id=%@&alias=Simulator&loginUser=%@&onlyid=720D03DF-14C8-4CE5-9764-E1B4F25D5081&version=MM_IOS_V1.0_181211",gid,loginUser];
    
    [SK_HTTPClient post:post
             parameters:nil
                success:^(NSURLSessionDataTask *operation, id responseObject, BOOL isOK) {
                    SKToast(responseObject[@"msg"]);
                    [self loadData_ALl];
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    SKToast_Error(error);
                }];
}

-(void)loadData_ALl
{
    NSString * post = [NSString stringWithFormat:@"http://st.lovestockhome.com/st-app/userStockGroup/queryUserStockGroup?&version=MM_IOS_V1.0_181211&groupName=&loginUser=%@&alias=Simulator&queryType=2&onlyid=720D03DF-14C8-4CE5-9764-E1B4F25D5081",loginUser];
    
    [SK_HTTPClient post:post
             parameters:nil
                success:^(NSURLSessionDataTask *operation, id responseObject, BOOL isOK) {
//                    SKToast(responseObject[@"msg"]);
                    NSLog(@"%@",responseObject);
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    SKToast_Error(error);
                }];
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
