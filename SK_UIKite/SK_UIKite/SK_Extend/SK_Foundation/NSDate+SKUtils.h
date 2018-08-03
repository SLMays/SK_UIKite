//
//  NSDate+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SKUtils)


/**
 *  将时间戳转换成需要的格式，以字符串输出
 *
 *  @param timeStr   时间戳
 *  @param Formatter 时间格式
 *
 *  @return 转好后的时间字符串
 */
+(NSString *)getDateToStr:(NSString *)dateStr withFormatter:(NSString *)Formatter;


/**
 *  获取当前日期
 *
 *  @param Formatter 时间格式
 *
 *  @return 当前日期
 */
+(NSString *)GetTodayDateWithFormatter:(NSString *)Formatter;
+(NSDate *)GetTodayDate;

/**
 *  获取今天之前的一段时间日期
 *
 *  @param time 据今天之前的时间（天）
 *
 *  @return 日期[NSString *]
 */
+(NSString *)GetDateStrWithTime:(int)time  WithFormatter:(NSString *)Formatter;


/**
 *  获取距离今天的一段时间日期
 *
 *  @param time 据今天的时间（天）正数为之后，负数为之前
 *
 *  @return 日期[NSDate *]
 */
+(NSDate *)GetDateWithTime:(float)time;


/**
 *  计算两个时间戳之间的时间间隔
 *
 *  @param start     开始时间
 *  @param end       结束时间
 *  @param Formatter 时间格式
 *
 *  @return 时间间隔
 */
+(NSString *)GetTimeIntervalWithStart:(NSString *)start  End:(NSString *)end  Type:(NSInteger)type;


/**
 *  将date转换成时间戳
 *
 *  @param date date原数据
 *
 *  @return 时间戳
 */
+(long)GetTimeStampWithDate:(NSDate *)date millisecond:(BOOL)milli;
+(NSString *)GetTimeStampStrWithDate:(NSDate *)date;


/**
 *  时间戳转换成date
 *
 *  @param timeStamp 时间戳
 *
 *  @return date
 */
+(NSDate *)GetDateWithTimeStamp:(NSString *)timeStamp;

/**
 *  获取当前时间(北京时间)
 *
 *  @return 当前时间
 */
+(NSDate *)getTimeForNow;

/**
 *  传入时间戳,将月份分成3份返回
 */
+ (NSMutableArray *)getMonthTrisectionWithFirstTimeStamp:(NSString *)Stamp;

+ (NSString *)getEasternDate:(NSDate *)date yearAgo:(int)year monthAgo:(int)month dayAgo:(int)day formatter:(NSString *)formatter;

+ (NSString *)getTodayEasternDate:(NSDate *)date formatter:(NSString *)formatter timeZone:(NSString *)timeZone;

+ (NSDate *)getEasternDateFromSting:(NSString *)str;

/**
 *  如果是当天日期，返回时分秒，否则返回年月日
 */
+(NSString *)getDateComparedWithNow:(NSString *)time isBeiJing:(BOOL)isBJ;

@end
