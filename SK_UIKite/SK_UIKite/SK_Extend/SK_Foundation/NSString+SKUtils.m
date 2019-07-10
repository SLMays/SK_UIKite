//
//  NSString+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "NSString+SKUtils.h"

@implementation NSString (SKUtils)

#pragma mark - 【String】 Data -> String
+(NSString *)GetStringWithData:(NSDate *)data
{
    return nil;
}

#pragma mark  【String】 Dict -> URLString
+(NSString *)GetURLStringWithDictionary:(NSDictionary *)dict
{
    NSMutableString * Str = [NSMutableString stringWithCapacity:0];
    for (NSString *key in [dict allKeys]) {
        NSString * value = STRING_IS_NOT_EMPTY(dict[key])?dict[key]:@"";
        [Str appendString:[NSString stringWithFormat:@"&%@=%@",key,value]];
    }
    return Str;
}
#pragma mark  【String】 Dict -> JsonString
+(NSString *)GetJsonStrWithDictionary:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
//获取LaunchImage
+ (NSString *)getLaunchImageName
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

@end
