//
//  SK_PDFReder_ViewController.m
//  SK_UIKite
//
//  Created by S&King on 2020/1/13.
//  Copyright © 2020 SKylin. All rights reserved.
//

#import "SK_PDFReder_ViewController.h"
#import "SK_WebNavigation_ViewController.h"
#import "SK_WebViewController.h"

@interface SK_PDFReder_ViewController ()<UIDocumentInteractionControllerDelegate>
@property (nonatomic, strong) UIDocumentInteractionController * documentController; //文档交互控制器
@end

@implementation SK_PDFReder_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray * titArr = @[@"本地预览",@"在线预览",@"下载预览"];
    for (int i=0; i<3; i++) {
        CGFloat size = (WIDTH_IPHONE/2);
        UIButton * btn = [UIButton initWithFrame:CGRectMake(i%2*size, i/2*size, size, size) title:titArr[i] titleColor:Color_FFFFFF_FFFFFF titleFont:[UIFont boldSystemFontOfSize:20] bgColor:Color_Random target:self action:@selector(btnClick:) tag:i];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    if (tag==0) {//本地预览
        [self localPreview];
        
    }else if (tag==1){//在线预览
        [self onLinePreview];
        
    }else if (tag==2){//下载预览
        [self downloadPreview];
        
    }
}
#pragma mark - 懒加载
-(UIDocumentInteractionController *)documentController
{
    if (!_documentController) {
        _documentController = [[UIDocumentInteractionController alloc]init];
        _documentController.delegate = self;
    }
    return _documentController;
}

#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    //注意：此处要求的控制器，必须是它的页面view，已经显示在window之上了
    
    return self;
}


#pragma mark - 本地预览
-(void)localPreview
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"ABC.pdf" withExtension:nil];
    self.documentController.URL = url;
    [self.documentController setDelegate:self];
    
    //当前APP打开  需实现协议方法才可以完成预览功能
    [self.documentController presentPreviewAnimated:YES];
}

#pragma mark - 在线预览
-(void)onLinePreview
{
    NSURL * url = [NSURL URLWithString:@"http://ima.51mm.com/taImage/product/subInsurance/20/shuoMingZ3VqaWEhQCMxNTc3OTM1NjM4NTEyMTYwOQ==.pdf"];
    SK_WebViewController * web = [[SK_WebViewController alloc]initWithURL:url];
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark - 下载预览
-(void)downloadPreview
{
    SKToast(@"暂未开发");
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
