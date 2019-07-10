//
//  SK_BankScanning_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/25.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_BankScanning_ViewController.h"
#import "BankOverlayView.h"
#import "XLScanManager.h"
#import "XLScanResultModel.h"

@interface SK_BankScanning_ViewController ()
@property (strong, nonatomic) XLScanResultModel * infoModel;//身份证信息
@property (nonatomic, strong) XLScanManager *cameraManager;//相机
@property (nonatomic, strong) BankOverlayView *BankOverlayView;//扫描动画
@end

@implementation SK_BankScanning_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //返回按钮
    [self initUI];
    
    //开始扫描
    [self startScanning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.cameraManager doSomethingWhenWillAppear];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.cameraManager doSomethingWhenWillDisappear];
}

//懒加载
- (XLScanManager *)cameraManager {
    if (!_cameraManager) {
        _cameraManager = [[XLScanManager alloc] init];
    }
    return _cameraManager;
}

-(BankOverlayView *)BankOverlayView {
    if(!_BankOverlayView) {
        CGRect rect = [BankOverlayView getOverlayFrame:[UIScreen mainScreen].bounds];
        _BankOverlayView = [[BankOverlayView alloc] initWithFrame:rect];
        [self.view addSubview:_BankOverlayView];
    }
    return _BankOverlayView;
}
-(XLScanResultModel *)infoModel
{
    if (!_infoModel) {
        _infoModel = [[XLScanResultModel alloc]init];
    }
    return _infoModel;
}

-(void)initUI
{
    UIButton * backBtn = [UIButton initWithFrame:CGRectMake(0, Height_StatusBar, 44, 44) Title:@"" TitleColor:[UIColor whiteColor] BgColor:nil Image:SK_IconImageMake(K_IconFont_Back, 24, [UIColor whiteColor]) BgImage:nil Target:self Action:@selector(BackAction) ForControlEvents:(UIControlEventTouchUpInside) Tag:0];
    [self.view addSubview:backBtn];
}
-(void)BackAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)startScanning
{
    [self.view bringSubviewToFront:self.BankOverlayView];
    
    self.cameraManager.sessionPreset = AVCaptureSessionPresetHigh;
    
    if ([self.cameraManager configBankScanManager]) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:view atIndex:0];
        AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.cameraManager.captureSession];
        preLayer.frame = [UIScreen mainScreen].bounds;
        
        preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [view.layer addSublayer:preLayer];
        
        [self.cameraManager startSession];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
        SKToast(@"打开相机失败");
    }
    
    SK_WEAKSELF
    [self.cameraManager.bankScanSuccess subscribeNext:^(id x) {
        _weakSelf.bankInfoblock(x);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.cameraManager.scanError subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
        SKToast(@"扫描出错了-.-");
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
