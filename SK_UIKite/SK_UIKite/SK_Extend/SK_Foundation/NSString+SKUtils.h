//
//  NSString+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SKUtils)

+(NSString *)GetStringWithData:(NSDate *)data;
+(NSString *)GetURLStringWithDictionary:(NSDictionary *)dict;
+(NSString *)GetJsonStrWithDictionary:(NSDictionary *)dict;

@end
