//
//  NSDate+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by 石磊 on 2017/11/1.
//  Copyright © 2017年 ShiLei. All rights reserved.
//

#import "NSDate+SKUtils.h"

@implementation NSDate (SKUtils)


/**
 *  将时间戳转换成需要的格式，以字符串输出
 *
 *  @param dateStr   时间戳
 *  @param Formatter 时间格式
 *
 *  @return 转好后的时间字符串
 */
+(NSString *)getDateToStr:(NSString *)dateStr withFormatter:(NSString *)Formatter
{
    double date = [dateStr doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:Formatter];

    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    return currentDateStr;
}

/**
 *  获取当前日期
 *
 *  @param Formatter 时间格式
 *
 *  @return 当前日期
 */
+(NSString *)GetTodayDateWithFormatter:(NSString *)Formatter
{
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:Formatter];
    NSString * date = [format stringFromDate:[NSDate date]];
    return date;
}
+(NSDate *)GetTodayDate
{
    NSCalendar *calendar         = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    components.hour              = 0;
    components.minute            = 0;
    components.second            = 0;
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

/**
 *  获取今天之前的一段时间日期
 *
 *  @param time 据今天之前的时间（天）
 *
 *  @return 日期[NSString *]
 */
+(NSString *)GetDateStrWithTime:(int)time  WithFormatter:(NSString *)Formatter
{
    float day                = 60*60*24;
    NSDate * date            = [NSDate date];
    date                     = [date dateByAddingTimeInterval:day*time];
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:Formatter];
    NSString * dateStr = [format stringFromDate:date];
    //    NSLog(@"%.f天前的时间为---------【%@】",time,dateStr);
    return dateStr;
}

/**
 *  获取距离今天的一段时间日期
 *
 *  @param time 据今天的时间（天）正数为之后，负数为之前
 *
 *  @return 日期[NSDate *]
 */
+(NSDate *)GetDateWithTime:(float)time
{
    float day     = 60*60*24;
    NSDate * date = [NSDate date];
    date          = [date dateByAddingTimeInterval:day*time];
    return date;
}

/**
 *  计算两个时间戳之间的时间间隔
 *
 *  @param start     开始时间
 *  @param end       结束时间
 *
 *  @return 时间间隔
 */
+(NSString *)GetTimeIntervalWithStart:(NSString *)start  End:(NSString *)end  Type:(NSInteger)type
{
    //创建日期格式化对象
    NSString * Formatter = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:Formatter];
    
    //创建了两个日期对象
    long long et   = [end longLongValue];
    long long st   = [start longLongValue];
    long long time = et - st;
    time           = time/1000;
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    if (time<=0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"key" object:nil];
    }
    NSString *dateContent;
    switch (type) {
        case 1:
        {
            int days=((int)time)/(3600*24);
            dateContent=[[NSString alloc] initWithFormat:@"%i天",days];
        }
            break;
        case 2:
        {
            int days=((int)time)/(3600*24);
            int hours=((int)time)%(3600*24)/3600;
            int minutes=((int)time)%(3600*24)%3600/60;
            dateContent=[[NSString alloc] initWithFormat:@"%i天%i时%i分",days,hours,minutes];
        }
            break;
        case 3:
        {
            int days=((int)time)/(3600*24);
            int hours=((int)time)%(3600*24)/3600;
            int minutes=((int)time)%(3600*24)%3600/60;
            int seconds =((int)time)%(3600*24)%3600%60;
            dateContent=[[NSString alloc] initWithFormat:@"%i天%i时%i分%i秒",days,hours,minutes,seconds];
        }
            
            break;
        case 4:
        {
            int minutes=((int)time)%(3600*24)%3600/60;
            int seconds =((int)time)%(3600*24)%3600%60;
            dateContent=[[NSString alloc] initWithFormat:@"%i分%i秒",minutes,seconds];
            
        }
            break;
        case 5:
        {
            int minutes=((int)time)%(3600*24)%3600/60;
            dateContent=[[NSString alloc] initWithFormat:@"%i",minutes];
        }
            break;
        default:
            break;
    }
    //    NSLog(@"dateContent------------%@",dateContent);
    return dateContent;
}

/**
 *  将date转换成时间戳
 *
 *  @param date date原数据
 *
 *  @return 时间戳
 */
+(long)GetTimeStampWithDate:(NSDate *)date millisecond:(BOOL)milli
{
    long TimeStamp = 0;
    if (date) {
        if (milli) {
            TimeStamp = (long)[date timeIntervalSince1970]*1000;
        }else{
            TimeStamp = (long)[date timeIntervalSince1970];
        }
    }
    
    //    NSLog(@"时间戳~~~~~~~~%ld",TimeStamp);
    
    return TimeStamp;
}

+(NSString *)GetTimeStampStrWithDate:(NSDate *)date
{
    NSString * TimeStamp;
    if (date) {
        TimeStamp = [NSString stringWithFormat:@"%.f",[date timeIntervalSince1970]*1000];
    }
    NSLog(@"时间戳~~~~~~~~%@",TimeStamp);
    
    return TimeStamp;
}

/**
 *  时间戳转换成date
 *
 *  @param timeStamp 时间戳
 *
 *  @return date
 */
+(NSDate *)GetDateWithTimeStamp:(NSString *)timeStamp
{
    NSString * time = [NSString stringWithFormat:@"%.f",[timeStamp doubleValue]/1000];
    //    timeStamp += 8*3600;
    NSDate *date    = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSLog(@"时间戳转换成date:  %@",date);
    
    return date;
}

/**
 *  获取当前时间(北京时间)
 *
 *  @return 当前时间
 */
+(NSDate *)getTimeForNow
{
    NSDate *date       = [NSDate date];
    NSTimeZone *zone   = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}


+ (NSMutableArray *)getMonthTrisectionWithFirstTimeStamp:(NSString *)Stamp
{
    NSMutableArray * TrisectionArr = [NSMutableArray new];
    
    NSString * TimeStamp = [NSString stringWithFormat:@"%@000",Stamp];
    NSString * date = [NSDate getDateToStr:TimeStamp withFormatter:@"yyyy-MM-dd"];
    NSArray * dateArr = [date componentsSeparatedByString:@"-"];
    int Year = [dateArr[0] intValue];
    int Month = [dateArr[1] intValue];
    int day1 = 1;
    int day2 = 15;
    int day3 = 30;
    
    if (Month==1 || Month==3 || Month==5 || Month==7 || Month==8 || Month==10 || Month==12) {
        day1 = 1;   day2 = 15;  day3 = 31;
    }else if (Month==2){
        if (Year % 100 == 0)
        {
            if (Year % 400 == 0){
                day1 = 1;   day2 = 15;  day3 = 29;
            }else{
                day1 = 1;   day2 = 15;  day3 = 28;
            }
        }else{
            if (Year % 4 == 0){
                day1 = 1;   day2 = 15;  day3 = 29;
            }else{
                day1 = 1;   day2 = 15;  day3 = 28;
            }
        }
    }
    
    [TrisectionArr addObject:[NSString stringWithFormat:@"%02d-%02d",Month,day1]];
    [TrisectionArr addObject:[NSString stringWithFormat:@"%02d-%02d",Month,day2]];
    [TrisectionArr addObject:[NSString stringWithFormat:@"%02d-%02d",Month,day3]];
    
    return TrisectionArr;
}


//获取当前的美东时间
+ (NSString *)getTodayEasternDate:(NSDate *)date formatter:(NSString *)formatter timeZone:(NSString *)timeZone
{
    NSTimeZone *nowTimeZone = [NSTimeZone timeZoneWithName:timeZone];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = nowTimeZone;
    dateFormatter.dateFormat = formatter;
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

//获取距离当前日期 n年n月n日 的美东时间
+ (NSString *)getEasternDate:(NSDate *)date yearAgo:(int)year monthAgo:(int)month dayAgo:(int)day formatter:(NSString *)formatter
{
    //转为美东时区
    NSTimeZone *nowTimeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = nowTimeZone;
    dateFormatter.dateFormat = formatter;
    //    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    NSCalendar *greCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //    NSLog(@"current TIME IS%@",currentDateStr);
    
    NSDateComponents *components = [greCal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    if (year) {
        [components setYear:([components year] - year)];
    }
    if (month) {
        [components setMonth:([components month] - month)];
    }
    if (day) {
        [components setDay:([components day] - day)];
    }
    
    NSDate *newDate = [greCal dateFromComponents:components];
    NSLog(@"new TIME IS%@",[dateFormatter stringFromDate:newDate]);
    
    return [dateFormatter stringFromDate:newDate];
}

//NSString 转为美东时间NSDate
+ (NSDate *)getEasternDateFromSting:(NSString *)str
{
    NSTimeZone *nowTimeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    formatter.timeZone = nowTimeZone;
    
    NSDate *date = [formatter dateFromString:str];
    return date;
}

+(NSString *)getDateComparedWithNow:(NSString *)time isBeiJing:(BOOL)isBJ
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];//[NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:time];
    
    //今天日期
    NSString * today = [dateFormatter stringFromDate:[NSDate date]];
    today = [today substringToIndex:10];
    
    //转为美东时区
    NSTimeZone *nowTimeZone = [NSTimeZone timeZoneWithName:isBJ?@"Asia/Hong_Kong":@"America/New_York"];
    NSInteger timeOffset = [nowTimeZone secondsFromGMTForDate:date];
    NSDate *newDate = [date dateByAddingTimeInterval:timeOffset];
    NSString *newDateStr = [dateFormatter stringFromDate: newDate];
    
    
    if ([newDateStr hasPrefix:today]) {
        return [newDateStr substringFromIndex:11];
    }else{
        return [newDateStr substringToIndex:10];
    }
}
+(NSString *)getDate:(NSString *)time GMT:(NSInteger)seconds ZoneName:(NSString *)name
{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    
    // 直接初始化的时间, 也是当前时间
    //NSDate *date = [[NSDate alloc]init];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:seconds];
    
    NSTimeInterval interval = [zone secondsFromGMTForDate:date];
    NSDate *current = [date dateByAddingTimeInterval:interval];
    
    NSTimeZone *zoneZero = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:zoneZero];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:current];
    
    NSLog(@"%@ %@",name,currentDateStr);
    
    return currentDateStr;
}

+(NSString *)getServerDate_C:(NSString *)time  withFormatter:(NSString *)formatter
{
    long long date = [time longLongValue];
    time = [NSString stringWithFormat:@"%lld",date];
    
    //获取当前时区
    NSTimeZone *zoneL = [NSTimeZone systemTimeZone];
    //获取东八区时区
    NSTimeZone *zone8 = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    
    //转存为字符串
    NSString * zoneLStr = [NSString stringWithFormat:@"%@",zoneL];
    NSString * zone8Str = [NSString stringWithFormat:@"%@",zone8];
    
    //获取时差(与GMT+0)
    zoneLStr = [[zoneLStr componentsSeparatedByString:@" "] objectAtIndex:3];
    zone8Str = [[zone8Str componentsSeparatedByString:@" "] objectAtIndex:3];
    
    //获取时间间隔
    long long zoneJG = [zoneLStr longLongValue]-[zone8Str longLongValue];
    
    //从新设置时间戳
    long long currentTime = [time longLongValue]-zoneJG;
    
    //获取时间
    return [NSDate getDateToStr:[NSString stringWithFormat:@"%lld",currentTime] withFormatter:formatter];
}

+(NSString *)getServerDate_Java:(NSString *)time  withFormatter:(NSString *)formatter
{
    long long date = [time longLongValue]/1000;
    NSString * dateStr = [NSString stringWithFormat:@"%lld",date];
    return [NSDate getDateToStr:dateStr withFormatter:formatter];
}
//时间戳转时间
+(NSDate *)getDateWidthTimeStamp_C:(long long)C_timeStamp TimeStamp_Java:(long long)J_timeStamp
{
    NSDate * date = [NSDate date];
    if (C_timeStamp) {
        date = [NSDate dateWithTimeIntervalSince1970:C_timeStamp];
    }else if (J_timeStamp){
        J_timeStamp = J_timeStamp/1000;
        date = [NSDate dateWithTimeIntervalSince1970:J_timeStamp];
    }
    
    return date;
}
//UTC时间戳转当地时间
+(NSString *)getDateWidthUTCTimeStamp_C:(long long)C_timeStamp TimeStamp_Java:(long long)J_timeStamp dateFormat:(NSString *)dateFormat
{
    NSDate * date = [NSDate date];
    if (C_timeStamp) {
        date = [NSDate dateWithTimeIntervalSince1970:C_timeStamp];
    }else if (J_timeStamp){
        J_timeStamp = J_timeStamp/1000;
        date = [NSDate dateWithTimeIntervalSince1970:J_timeStamp];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateFormat];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
}
/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=7，toHour=20时，即为判断当前时间是否在7:00-20:00之间
 */
+ (BOOL)validateWithStartTime:(NSString *)startTime expireTime:(NSString *)expireTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *currentStr = [dateFormat stringFromDate:currentDate];//将日期转换成字符串
    currentDate = [dateFormat dateFromString:currentStr];
    
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([currentDate compare:start] == NSOrderedAscending || [currentDate compare:expire] == NSOrderedDescending) {
        return NO;
    }else{
        return YES;
    }
}

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}
/**
 *  是否为前天
 */
- (BOOL)isBeforeYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 2;
}
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
+ (NSString *)getDateIntervalForNow_CDate:(long long)c_date javaDate:(long long)java_date
{
    NSDate * date = [NSDate getDateWidthTimeStamp_C:c_date TimeStamp_Java:java_date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"EEE MMM dd HH24:mm:ss Z yyyy";
    NSString * dateStr = @"";

    if (date.isThisYear) {//今年
        if (date.isToday) { // 今天
            NSDateComponents *cmps = [date deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                dateStr =  [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                dateStr = [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else { // 1分钟内发的
                dateStr = @"刚刚";
            }
        } else if (date.isYesterday) { // 昨天
            dateFormat.dateFormat = @"昨天 HH:mm";
            dateStr = [dateFormat stringFromDate:date];
        } else if (date.isBeforeYesterday) { // 前天
            dateFormat.dateFormat = @"前天 HH:mm";
            dateStr = [dateFormat stringFromDate:date];
        } else { // 至少是大前天
            dateFormat.dateFormat = @"MM-dd HH:mm";
            dateStr = [dateFormat stringFromDate:date];
        }
    } else { // 非今年
        dateFormat.dateFormat = @"yyyy-MM-dd";
        dateStr = [dateFormat stringFromDate:date];
    }
    
    return dateStr;
}

@end
