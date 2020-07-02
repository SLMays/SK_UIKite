//
//  SK_KeyBoardTool_ViewController.m
//  SK_UIKite
//
//  Created by GuJia on 2020/6/19.
//  Copyright © 2020 SKylin. All rights reserved.
//

#import "SK_KeyBoardTool_ViewController.h"

@interface SK_KeyBoardTool_ViewController ()
@property (nonatomic, strong) UITextField *textFTop;
@property (nonatomic, strong) UITextField *textFCenter;
@property (nonatomic, strong) UITextField *textFBottom;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation SK_KeyBoardTool_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainScrollView];
}
-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT)];
        [_mainScrollView addSubview:self.textFTop];
        [_mainScrollView addSubview:self.textFCenter];
        [_mainScrollView addSubview:self.textFBottom];
        _mainScrollView.contentSize = CGSizeMake(WIDTH_IPHONE, self.textFBottom.bottom);
    }
    return _mainScrollView;
}
-(UITextField *)textFTop
{
    if (!_textFTop) {
        _textFTop = [UITextField initWithFrame:CGRectMake(20, 20, WIDTH_IPHONE-40, 35) placeholder:@"点击输入内容" passWord:NO leftImageView:nil rightImageView:nil font:14 backgRoundImageName:nil text:nil textBorderStyle:(UITextBorderStyleRoundedRect) keyboardType:(UIKeyboardTypeDefault) textAlignment:(NSTextAlignmentLeft) bgColor:Color_FFFFFF_FFFFFF borderColor:Color_Random tag:1];
    }
    return _textFTop;
}
-(UITextField *)textFCenter
{
    if (!_textFCenter) {
        _textFCenter = [UITextField initWithFrame:CGRectMake(20, 20, WIDTH_IPHONE-40, 35) placeholder:@"点击输入内容" passWord:NO leftImageView:nil rightImageView:nil font:14 backgRoundImageName:nil text:nil textBorderStyle:(UITextBorderStyleRoundedRect) keyboardType:(UIKeyboardTypeDefault) textAlignment:(NSTextAlignmentLeft) bgColor:Color_FFFFFF_FFFFFF borderColor:Color_Random tag:2];
        _textFCenter.centerY = NOHAVE_TABBAR_HEIGHT/2;
    }
    return _textFCenter;
}
-(UITextField *)textFBottom
{
    if (!_textFBottom) {
        _textFBottom = [UITextField initWithFrame:CGRectMake(20, 20, WIDTH_IPHONE-40, 35) placeholder:@"点击输入内容" passWord:NO leftImageView:nil rightImageView:nil font:14 backgRoundImageName:nil text:nil textBorderStyle:(UITextBorderStyleRoundedRect) keyboardType:(UIKeyboardTypeDefault) textAlignment:(NSTextAlignmentLeft) bgColor:Color_FFFFFF_FFFFFF borderColor:Color_Random tag:3];
        _textFBottom.centerY = NOHAVE_TABBAR_HEIGHT-(_textFBottom.height/2);
    }
    return _textFBottom;
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
