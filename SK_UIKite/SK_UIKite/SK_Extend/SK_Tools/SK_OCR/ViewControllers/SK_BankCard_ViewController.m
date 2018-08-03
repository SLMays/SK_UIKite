//
//  SK_BankCard_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/23.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_BankCard_ViewController.h"
#import "XLScanResultModel.h"
#import "SK_BankScanning_ViewController.h"

@interface SK_BankCard_ViewController ()
{
    UIView * idInfoView;//存放ID信息的view
    BOOL didShowAlert;//记录时候显示过alert提示
}
@property (strong, nonatomic) UIImageView *bankImgView;
@property (strong, nonatomic) UILabel *bankCardInfoLabel;
@property (strong, nonatomic) XLScanResultModel * infoModel;//卡片信息

@end

@implementation SK_BankCard_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(XLScanResultModel *)infoModel
{
    if (!_infoModel) {
        _infoModel = [[XLScanResultModel alloc]init];
    }
    return _infoModel;
}
//初始化UI
-(void)initUI
{
    idInfoView = [[UIView alloc]initWithFrame:self.view.bounds];
    idInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:idInfoView];
    
    
    CGFloat ImgWidth = WIDTH_IPHONE;
    CGFloat ImgHeight = WIDTH_IPHONE/K_CARDRATIO;
    CGFloat left = (WIDTH_IPHONE-ImgWidth)/2;
    
    _bankImgView = [UIImageView initWithFrame:CGRectMake(left, 0, ImgWidth, ImgHeight) Image:nil ContentMode:(UIViewContentModeScaleAspectFit) Tag:1 String:@"银行卡"];
    _bankImgView.backgroundColor = RandomColor;
    _bankImgView.bColor = RandomColor;
    [idInfoView addSubview:_bankImgView];
    
    
    _bankCardInfoLabel = [UILabel initWithFrame:CGRectMake(0, _bankImgView.bottom, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT-_bankImgView.bottom) Title:nil TitleColor:[UIColor blackColor] BgColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:14] TextAlignment:NSTextAlignmentLeft  Tag:0];
    _bankCardInfoLabel.bColor = RandomColor;
    _bankCardInfoLabel.numberOfLines = 0;
    [idInfoView addSubview:_bankCardInfoLabel];
    
    
    UITapGestureRecognizer * bank_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    [_bankImgView addGestureRecognizer:bank_tap];
    
}

#pragma mark - 开始扫描
-(void)tapImageAction:(UITapGestureRecognizer *)tap
{
    if (!didShowAlert) {
        [self showAlert];
    }else{
        [self startScanning];
    }
}

-(void)showAlert
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请将银行卡放于光线适中的环境中扫描，否则会影响扫描结果" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"开始扫描" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self startScanning];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        didShowAlert = YES;
    }];
}

-(void)startScanning
{
    SK_BankScanning_ViewController * scanning = [[SK_BankScanning_ViewController alloc]init];
    [self presentViewController:scanning animated:YES completion:nil];
    
    SK_WEAKSELF
    [scanning setBankInfoblock:^(XLScanResultModel *info) {
        _weakSelf.infoModel.bankName = info.bankName;
        _weakSelf.infoModel.bankNumber = info.bankNumber;
        
        _weakSelf.bankImgView.image = [info.bankImage WaterMarkWithTitle:@"仅限于美美证券开户使用" andMarkFont:[UIFont systemFontOfSize:16] andMarkColor:COLORWITHRGBA(255, 255, 255, 0.5)];
        _weakSelf.bankImgView.Str = @"";
        
        _weakSelf.bankCardInfoLabel.text = [NSString stringWithFormat:@"银行名称：%@\n银行卡号：%@",_weakSelf.infoModel.bankName,_weakSelf.infoModel.bankNumber];
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
