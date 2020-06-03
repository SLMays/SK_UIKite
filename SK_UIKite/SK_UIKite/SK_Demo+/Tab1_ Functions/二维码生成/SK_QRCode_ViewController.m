//
//  SK_QRCode_ViewController.m
//  SK_UIKite
//
//  Created by S&King on 2020/5/12.
//  Copyright © 2020 SKylin. All rights reserved.
//

#import "SK_QRCode_ViewController.h"


@interface SK_QRCode_ViewController ()

@end

@implementation SK_QRCode_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.urlTextF.bColor = RandomColor;
    self.QRCodeImgV.bColor = RandomColor;
}

- (IBAction)createQRCodeImgAction:(UIButton *)sender {
    if (!STRING_IS_NOT_EMPTY(self.urlTextF.text)) {
        SKToast(@"URL地址为空");
    }else{
        UIImage * QRImg = [UIImage createImgQRCodeWithString:self.urlTextF.text centerImage:nil];
        [self.QRCodeImgV setImage:QRImg];
    }
}

- (IBAction)saveQRCodeImg:(UIButton *)sender {
    if (!self.QRCodeImgV.image) {
        SKToast(@"请先生成二维码");
    }else{
        UIImageWriteToSavedPhotosAlbum(self.QRCodeImgV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        SKToast(@"保存成功");
    }else{
        SKToast(@"保存失败");
        
    }
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
