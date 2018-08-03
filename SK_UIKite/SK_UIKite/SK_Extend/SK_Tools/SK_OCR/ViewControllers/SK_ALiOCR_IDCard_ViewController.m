//
//  SK_ALiOCR_IDCard_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/14.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_ALiOCR_IDCard_ViewController.h"
#import "ApiClient_IdCardIdentify.h"

@interface SK_ALiOCR_IDCard_ViewController ()
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;

@end

@implementation SK_ALiOCR_IDCard_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray * titleArr = @[@"正面",@"背面"];
    
    for (int i=0; i<2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = RandomColor;
        btn.tag = i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:35];
        btn.frame = CGRectMake(0, i*NOHAVE_TABBAR_HEIGHT/2, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT/2);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
-(void)Action:(UIButton *)btn
{
    int tag = (int)btn.tag;
    [self IdCardIdentifyTest:tag];
}
-(UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [self.view addSubview:_activityIndicator];
        //设置小菊花的frame
        _activityIndicator.frame= CGRectMake((WIDTH_IPHONE-100)/2, (HEIGHT_IPHONE-100)/2, 100, 100);
        //设置小菊花颜色
        _activityIndicator.color = RandomColor;
        //设置背景颜色
        _activityIndicator.backgroundColor = [UIColor cyanColor];
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
}
- (void) IdCardIdentifyTest:(NSInteger)side {
    
    NSString * imgName = side==0?@"idCard_1.jpeg":@"idCard_2.jpeg";
    
    UIImage * image = [UIImage imageNamed:imgName];
    
    //压缩图片到指定尺寸大小
//    image = [UIImage compressOriginalImage:image toSize:CGSizeMake(<#CGFloat width#>, <#CGFloat height#>)];
    
    NSData *data =UIImageJPEGRepresentation(image,0.1);
    
    NSString *pictureDataString=[data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    
    NSString *bodys = [NSString stringWithFormat:@"{\"image\":\"%@\",\"configure\":\"{\\\"side\\\":\\\"%@\\\"}\"}",pictureDataString,side==0?@"face":@"back"];//#身份证正反面类型:face/back
    
    long long start = [[NSDate GetTimeStampStrWithDate:[NSDate date]] longLongValue];
    
    [self.activityIndicator startAnimating];
    [[ApiClient_IdCardIdentify instance] IdCardIdentify: [bodys dataUsingEncoding:NSUTF8StringEncoding] completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableString *bodyString = [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] mutableCopy];
        [self.activityIndicator stopAnimating];
        
        long long end = [[NSDate GetTimeStampStrWithDate:[NSDate date]] longLongValue];
        long long time = end - start;
        
        [bodyString appendFormat:@"\n图片大小%lu KB \n用时:%lld",(unsigned long)data.length/1024,time];
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"识别结果" message:bodyString preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
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
