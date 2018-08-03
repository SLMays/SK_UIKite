//
//  NSDictionary+SK_Utils.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/14.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "NSDictionary+SK_Utils.h"

@implementation NSDictionary (SK_Utils)

#pragma mark - 【Dictionary】 Data -> Dict
+(NSDictionary *)GetDictionaryWithData:(NSData *)data
{
    return nil;
}

#pragma mark  【Dictionary】 Data -> String
+(NSDictionary *)GetDictionaryWithString:(NSString *)str
{
    if (str == nil) {
        return nil;
    }
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err] mutableCopy];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
