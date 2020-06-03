//
//  NSDate+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by 石磊 on 2017/11/1.
//  Copyright © 2017年 ShiLei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GMT_e8   (8*60*60)   //北京时间(东八)
#define GMT_w5   (-5*60*60)  //纽约时间(西五)
#define GMT_0    0           //0时区

typedef enum : NSInteger{
    DateBeforeType_OneWeak=0,      //一周前
    DateBeforeType_OneMonth=1,     //一个月前
    DateBeforeType_ThreeMonths=3,  //三个月前
    DateBeforeType_HalfYear=6,     //半年前
    DateBeforeType_OneYear=12,      //一年前
}DateBeforeType; //日期往前类型


@interface NSDate (SKUtils)


/**
 *  将时间戳转换成需要的格式，以字符串输出
 *
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

/// 将日期转换成时间戳
/// @param dateStr 日期字符串
+(NSString *)GetTimeStampStrWithDateStr:(NSString *)dateStr;

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

/**
 *  时间戳按时区转换时间
 */
+(NSString *)getDate:(NSString *)time GMT:(NSInteger)seconds ZoneName:(NSString *)name;

//获取服务器时间(保证不同时区下转换时间不变)
+(NSString *)getServerDate_C:(NSString *)time  withFormatter:(NSString *)formatter;
+(NSString *)getServerDate_Java:(NSString *)time  withFormatter:(NSString *)formatter;
//时间戳转时间
+(NSDate *)getDateWidthTimeStamp_C:(long long)C_timeStamp TimeStamp_Java:(long long)J_timeStamp;
//UTC时间戳转当地时间
+(NSString *)getDateWidthUTCTimeStamp_C:(long long)C_timeStamp TimeStamp_Java:(long long)J_timeStamp dateFormat:(NSString *)dateFormat;
+ (BOOL)validateWithStartTime:(NSString *)startTime expireTime:(NSString *)expireTime;

//是否为今天
- (BOOL)isToday;
//是否为昨天
- (BOOL)isYesterday;
//是否为前天
- (BOOL)isBeforeYesterday;
//是否为今年
- (BOOL)isThisYear;
//获取时间戳距离当前时间多久
+ (NSString *)getDateIntervalForNow_CDate:(long long)c_date javaDate:(long long)java_date;

/**
 获取传入日期的前一段时间

 @param nowDate 比较的日期  yyyyMMDD
 @param type    类型       DateBeforeType
 @return 之前的日期         yyyyMMDD
 */
+(NSString *)getBeforeDate:(NSString *)nowDate type:(DateBeforeType)type;



@end
