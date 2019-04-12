//
//  GFCalendarView.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectDayHandler)(NSString * startDate, NSString * endDate);

@interface GFCalendarView : UIView


/**
 *  构造方法
 *
 *  @param origin calendar 的位置
 *  @param width  calendar 的宽度（高度会根据给定的宽度自动计算）
 *
 *  @return bannerView对象
 */
- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width;


/**
 *  calendar 的高度（只读属性）
 */
@property (nonatomic, assign, readonly) CGFloat calendarHeight;


/**
 *  calendar 基本颜色
 */
@property (nonatomic, strong) UIColor *calendarBasicColor;


/**
 *  日期点击回调
 *  block 的参数表示当前日期的 NSDate 对象
 */
@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler;



/**
 选中时间段后刷新日历

 @param startDateNum 开始日期   20190301
 @param endDateNum 结束日期     20190331
 */
- (void)refreshSelectDate_stratDateNum:(long)startDateNum endDateNum:(long)endDateNum;

@end
