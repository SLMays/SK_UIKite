//
//  SK_CalendarDateChoose_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2019/3/21.
//  Copyright © 2019 SKylin. All rights reserved.
//

#import "SK_CalendarDateChoose_ViewController.h"
#import "GFCalendarView.h"

@interface SK_CalendarDateChoose_ViewController ()
@property (nonatomic, strong) GFCalendarView *calendarView;//日历日期选择器
@end

@implementation SK_CalendarDateChoose_ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self makeUI];
}
-(void)makeUI
{
    self.view.backgroundColor = RandomColor;
    
    CGFloat width = 120;
    CGFloat heigt = 35;
    CGFloat interval = (WIDTH_IPHONE-width*2-25)/2;
    NSArray * placeholderTitArr = @[@"开始日期",@"结束日期"];
    for (int i=0; i<2; i++) {
        UITextField * textF = [UITextField initWithFrame:CGRectMake(interval+i*(25+width), interval, width, heigt) placeholder:placeholderTitArr[i] passWord:NO leftImageView:nil rightImageView:nil font:14 backgRoundImageName:nil text:@"" textBorderStyle:(UITextBorderStyleRoundedRect) keyboardType:(UIKeyboardTypeDefault) textAlignment:(NSTextAlignmentCenter) bgColor:nil borderColor:nil tag:100+i];
        textF.backgroundColor = [UIColor whiteColor];
        textF.userInteractionEnabled = NO;
        [self.view addSubview:textF];
    }
    
    [self.view addSubview:self.calendarView];
}
-(GFCalendarView *)calendarView
{
    if (!_calendarView) {
        int intNum = WIDTH_IPHONE/7;//整数
        CGFloat width = intNum*7;
        _calendarView = [[GFCalendarView alloc] initWithFrameOrigin:CGPointMake((WIDTH_IPHONE-width)/2, HEIGHT_IPHONE) width:width];
        _calendarView.top = NOHAVE_TABBAR_HEIGHT-_calendarView.height;
        // 点击某一天的回调
        SK_WEAKSELF
        [_calendarView setDidSelectDayHandler:^(NSString *startDate, NSString *endDate) {
            [_weakSelf didSelectDayHandler_StartDate:startDate EndDate:endDate];
        }];
    }
    return _calendarView;
}
-(void)didSelectDayHandler_StartDate:(NSString *)startDate  EndDate:(NSString *)endDate
{
    
    NSMutableString * startDateStr = [startDate mutableCopy];
    NSMutableString * endDateStr = [endDate mutableCopy];
    
    [startDateStr insertString:@"-" atIndex:6];
    [startDateStr insertString:@"-" atIndex:4];
    if (STRING_IS_NOT_EMPTY(endDateStr)) {    
        [endDateStr insertString:@"-" atIndex:6];
        [endDateStr insertString:@"-" atIndex:4];
    }
    
    UITextField * textfs = [self.view viewWithTag:100];
    UITextField * textfe = [self.view viewWithTag:101];
    
    textfs.text = startDateStr;
    textfe.text = endDateStr;
}

-(NSString *)getDateStrBeforDate:(NSString *)newDate type:(NSInteger)type
{
    
    return @"";
}

@end
