//
//  SK_TimeStampTransformation_ViewController.m
//  SK_UIKite
//
//  Created by S&King on 2020/6/2.
//  Copyright © 2020 SKylin. All rights reserved.
//

#import "SK_TimeStampTransformation_ViewController.h"

@interface SK_TimeStampTransformation_ViewController ()
@property (strong, nonatomic) UITextField *dateTextF;
@property (strong, nonatomic) UITextView *dateShowTextV;
@property (strong, nonatomic) UISegmentedControl *TimeZoneSeg;
@property (nonatomic, strong) NSMutableString * dateShowStr;
@property (nonatomic, copy) NSString * timeStamp;
@end

@implementation SK_TimeStampTransformation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self doneAction];
}

-(void)initUI
{
    UILabel * titleLabel = [UILabel initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, 35) Font:16 Text:@"自定义日期->时间戳->转换日期" setColor:[UIColor blackColor] numberOfLines:1 textAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:titleLabel];
    
    self.dateTextF = [UITextField initWithFrame:CGRectMake(20, titleLabel.bottom, WIDTH_IPHONE-100, 40) placeholder:@"yyyy/MM/dd HH:mm:ss" passWord:NO leftImageView:nil rightImageView:nil font:14 backgRoundImageName:nil text:@"2020/06/01 20:00:13" textBorderStyle:(UITextBorderStyleRoundedRect) keyboardType:(UIKeyboardTypeDefault) textAlignment:(NSTextAlignmentCenter) bgColor:nil borderColor:Color_Random tag:0];
    [self.view addSubview:self.dateTextF];
    
    UIButton * doneBtn = [UIButton initWithFrame:CGRectMake(self.dateTextF.right+10, self.dateTextF.top, 60, self.dateTextF.height) title:@"确认" titleColor:Color_FFFFFF_FFFFFF titleFont:[UIFont systemFontOfSize:16] bgColor:Color_Random target:self action:@selector(doneAction) tag:1];
    doneBtn.bRadius = 4;
    [self.view addSubview:doneBtn];
    
    self.dateShowTextV = [UITextView initWithFrame:CGRectMake(20, self.dateTextF.bottom+10, WIDTH_IPHONE-40, 350) text:nil textHexColor:Color_333333_333333 font:15 textAlignment:(NSTextAlignmentLeft) editable:NO userInteractionEnabled:YES tag:2];
    self.dateShowTextV.bColor = RandomColor;
    [self.view addSubview:self.dateShowTextV];
    
    self.TimeZoneSeg = [UISegmentedControl initWithItems:@[@"当前时区转换",@"固定时区转换(北京)"] frame:CGRectMake(20, self.dateShowTextV.bottom+10, WIDTH_IPHONE-40, 45) selectedIndex:0 tintColor:Color_Random titleAttNormal:nil titleAttSelected:nil target:self action:nil];
    [self.view addSubview:self.TimeZoneSeg];
    
    UIButton * transBtn = [UIButton initWithFrame:CGRectMake(20, self.TimeZoneSeg.bottom+10, WIDTH_IPHONE-40, 45) title:@"开始转换" titleColor:Color_FFFFFF_FFFFFF titleFont:[UIFont systemFontOfSize:16] bgColor:Color_Random target:self action:@selector(TransformationAction) tag:3];
    transBtn.bRadius = 4;
    [self.view addSubview:transBtn];
    
}

-(NSMutableString *)dateShowStr
{
    if (!_dateShowStr) {
        _dateShowStr = [[NSMutableString alloc]init];
    }
    return _dateShowStr;
}

- (IBAction)doneAction
{
    if (STRING_IS_NOT_EMPTY(self.dateTextF.text)) {
        self.timeStamp = [NSDate GetTimeStampStrWithDateStr:self.dateTextF.text];
        self.dateShowStr = [NSMutableString stringWithFormat:@"输入日期：%@\n时间戳：%@\n\n",self.dateTextF.text,self.timeStamp];
        NSLog(@"%@",self.dateShowStr);
        self.dateShowTextV.text = self.dateShowStr;
    }else{
        SKToast(@"日期格式不正确");
    }
}


- (IBAction)TransformationAction
{
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSString * zoneStr = [NSString stringWithFormat:@"%@",zone];
    NSString * date = @"";
    NSString * showStr = @"";
    if (self.TimeZoneSeg.selectedSegmentIndex==0) {//当前时区转换
        date = [NSDate getDateToStr:self.timeStamp withFormatter:@"yyyy/MM/dd HH:mm:ss"];
        showStr = [NSString stringWithFormat:@"当前：%@ \n当地时间：%@\n\n",zoneStr,date];
    }else{//固定时区转换(北京)
        date = [NSDate getDate:self.timeStamp GMT:GMT_e8 ZoneName:@""];
        showStr = [NSString stringWithFormat:@"当前：%@ \n北京时间：%@\n\n",zoneStr,date];
    }
    [self.dateShowStr appendString:showStr];
    self.dateShowTextV.text = self.dateShowStr;
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
