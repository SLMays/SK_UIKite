//
//  SK_DateTransformation_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/12/5.
//  Copyright © 2018 SKylin. All rights reserved.
//

#import "SK_DateTransformation_ViewController.h"

@interface SK_DateTransformation_ViewController ()
{
    NSMutableString * timeStr;
    NSString * timeStamp;
    BOOL isTimeRun;
}
@property (nonatomic, strong) UITextView *textView;
@end

@implementation SK_DateTransformation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    isTimeRun = NO;
}
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT)];
        _textView.font = [UIFont boldSystemFontOfSize:14];
        _textView.editable = NO;
        
        NSDate * date = [NSDate date];
        NSTimeZone * zone = [NSTimeZone systemTimeZone];
        timeStamp = [NSDate GetTimeStampStrWithDate:date];
        timeStamp = [timeStamp substringToIndex:timeStamp.length-3];
        NSString * log = [NSString stringWithFormat:@"当前UTC时间：%@\n时间戳：%@\n时区：%@\n\n\n",date,timeStamp,zone];
        NSLog(@"%@",log);
        
        timeStr = [[NSMutableString alloc]init];
        [timeStr appendString:log];
        _textView.text = timeStr;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshTime)];
        [_textView addGestureRecognizer:tap];
    }
    return _textView;
}
-(void)refreshTime
{
    long long time = [timeStamp longLongValue];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSString * date = [NSDate getDateWidthUTCTimeStamp_C:time TimeStamp_Java:0 dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [timeStr appendString:[NSString stringWithFormat:@"本地时间：%@\n时区：%@\n\n",date,zone]];
    self.textView.text = timeStr;
}
-(void)refUTCTime
{
    NSDate * date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    timeStamp = [NSDate GetTimeStampStrWithDate:date];
    timeStamp = [timeStamp substringToIndex:timeStamp.length-3];
    NSString * log = [NSString stringWithFormat:@"当前UTC时间：%@\n时间戳：%@\n时区：%@\n\n",date,timeStamp,zone];
    NSLog(@"%@",log);

    [timeStr appendString:log];
    self.textView.text = timeStr;
}
-(void)refShowTime
{
    NSDate * date = [NSDate date];
    timeStamp = [NSDate GetTimeStampStrWithDate:date];
    timeStamp = [timeStamp substringToIndex:timeStamp.length-3];
    self.textView.text = timeStamp;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self refreshTime];
//    [self refUTCTime];
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
