//
//  GFCalendarScrollView.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectDayHandler)(NSString * startDate, NSString * endDate);

@interface GFCalendarScrollView : UIScrollView


@property (nonatomic, strong) UIColor *calendarBasicColor; // 基本颜色
@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler; // 日期点击回调

- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份
- (void)refreshSelectDate_stratDateNum:(long long)startDateNum endDateNum:(long long)endDateNum;//选中时间段后刷新日历

@end
