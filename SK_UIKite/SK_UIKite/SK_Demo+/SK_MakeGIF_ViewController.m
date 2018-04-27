//
//  SK_MakeGIF_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/4/18.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_MakeGIF_ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/Photos.h>

@interface SK_MakeGIF_ViewController ()
{
    UIImageView * gifImageView;
    NSMutableArray * images;
    NSString * _pathUrl;
}
@end

@implementation SK_MakeGIF_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI
{
    gifImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT-100)];
    gifImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:gifImageView];
    
    NSArray * btnTitleArr = @[@"演示",@"照册/拍照",@"制作GIF",@"保存GIF"];
    CGFloat w = WIDTH_IPHONE/2;
    CGFloat h = 50;
    for (int i=0; i<btnTitleArr.count; i++) {
        UIButton * btn = [UIButton initWithFrame:CGRectMake(i%2*w, gifImageView.bottom+i/2*h, w, h) Title:btnTitleArr[i] TitleColor:[UIColor blackColor] BgColor:RandomColor Image:nil BgImage:nil Target:self Action:@selector(GifAction:) ForControlEvents:(UIControlEventTouchUpInside) Tag:i];
        [self.view addSubview:btn];
    }
}

-(void)GifAction:(UIButton *)btn
{
    int tag = (int)btn.tag;
    switch (tag) {
        case 0:
        {
            NSLog(@"演示");
            
            images = [NSMutableArray array];
            for (int i=1; i<=8; i++) {
                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image_%d",i]]];
            }
            gifImageView.animationImages = images;
            gifImageView.contentMode = UIViewContentModeScaleAspectFit;
            gifImageView.animationDuration = 1.0;//完成一次时间
            gifImageView.animationRepeatCount = NSUIntegerMax;//播放次数
            [gifImageView startAnimating];
        }
            break;
            
        case 1:
        {
            NSLog(@"相册/拍照");
        }
            break;

        case 2:
        {
            NSLog(@"制作GIF");
            
        }
            break;
            
        case 3:
        {
            NSLog(@"保存GIF");
            
        }
            break;

        default:
            break;
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
