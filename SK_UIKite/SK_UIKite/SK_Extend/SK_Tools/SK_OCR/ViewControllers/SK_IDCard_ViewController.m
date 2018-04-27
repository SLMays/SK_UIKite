//
//  SK_IDCard_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/23.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_IDCard_ViewController.h"
#import "XLScanResultModel.h"
#import "SK_IDScanning_ViewController.h"

@interface SK_IDCard_ViewController ()
{
    UIView * idInfoView;//存放ID信息的view
    BOOL didShowAlert;//记录时候显示过alert提示
}

@property (strong, nonatomic) UIImageView *faceImgView;
@property (strong, nonatomic) UIImageView *backImgView;
@property (strong, nonatomic) UILabel *idCardInfoLabel;
@property (strong, nonatomic) XLScanResultModel * infoModel;//卡片信息

@end

@implementation SK_IDCard_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    _faceImgView = [UIImageView initWithFrame:CGRectMake(left, 0, ImgWidth, ImgHeight) Image:nil ContentMode:(UIViewContentModeScaleAspectFill) Tag:1 String:@"正面"];
    _faceImgView.backgroundColor = RandomColor;
    _faceImgView.bColor = RandomColor;
    [idInfoView addSubview:_faceImgView];
    
    
    _backImgView = [UIImageView initWithFrame:CGRectMake(left, _faceImgView.bottom, ImgWidth, ImgHeight) Image:nil ContentMode:(UIViewContentModeScaleAspectFill) Tag:2 String:@"背面"];
    _backImgView.backgroundColor = RandomColor;
    _backImgView.bColor = RandomColor;
    [idInfoView addSubview:_backImgView];
    
    
    _idCardInfoLabel = [UILabel initWithFrame:CGRectMake(0, _backImgView.bottom, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT-_backImgView.bottom) Title:nil TitleColor:[UIColor blackColor] BgColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:14] TextAlignment:NSTextAlignmentLeft  Tag:0];
    _idCardInfoLabel.bColor = RandomColor;
    _idCardInfoLabel.numberOfLines = 0;
    [idInfoView addSubview:_idCardInfoLabel];
    
    
    UITapGestureRecognizer * face_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    [_faceImgView addGestureRecognizer:face_tap];

    UITapGestureRecognizer * back_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    [_backImgView addGestureRecognizer:back_tap];

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
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请将身份证放于光线适中的环境中扫描，否则会影响扫描结果" preferredStyle:(UIAlertControllerStyleAlert)];
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
    SK_IDScanning_ViewController * scanning = [[SK_IDScanning_ViewController alloc]init];
    [self presentViewController:scanning animated:YES completion:nil];
    
    SK_WEAKSELF
    [scanning setIdInfoblock:^(XLScanResultModel *info) {
        if (info.type == 1) {
            _weakSelf.infoModel.code = info.code;
            _weakSelf.infoModel.name = info.name;
            _weakSelf.infoModel.nation = info.nation;
            _weakSelf.infoModel.gender = info.gender;
            _weakSelf.infoModel.address = info.address;
            
            UIImage * faceImg = info.idImage;
            faceImg = [faceImg imageWaterMarkWithString:@"仅限美美证券开户用" point:CGPointMake(_weakSelf.faceImgView.width/2, faceImg.size.height/2) attribute:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:50],NSForegroundColorAttributeName:COLORWITHRGBA(255, 255, 255, 0.5)}];
            _weakSelf.faceImgView.image = faceImg;
            _weakSelf.faceImgView.Str = @"";
            
        }else{
            _weakSelf.infoModel.issue = info.issue;
            _weakSelf.infoModel.valid = info.valid;
            UIImage * backImg = info.idImage;
            backImg = [backImg imageWaterMarkWithString:@"仅限美美证券开户用" point:CGPointMake(_weakSelf.backImgView.width/2, backImg.size.height/2) attribute:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:50],NSForegroundColorAttributeName:COLORWITHRGBA(255, 255, 255, 0.5)}];
            _weakSelf.backImgView.image = backImg;
            _weakSelf.backImgView.Str = @"";
        }
        
        _weakSelf.idCardInfoLabel.text = [_weakSelf.infoModel toString];
        
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
