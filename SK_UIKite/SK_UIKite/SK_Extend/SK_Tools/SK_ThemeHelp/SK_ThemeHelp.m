//
//  SK_ThemeHelp.m
//  SK_UIKite
//
//  Created by Skylin on 2018/7/10.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_ThemeHelp.h"

static NSMutableDictionary * jsonDict;

@implementation SK_ThemeHelp

+(SK_ThemeHelp *)sharedInstance{
    static dispatch_once_t onceToken;
    static SK_ThemeHelp * themeHelp;
    
    dispatch_once(&onceToken, ^{
        themeHelp = [[SK_ThemeHelp alloc]init];
        [themeHelp initTheme];
    });
    
    return themeHelp;
}
-(void)initTheme
{
    NSDictionary * theme_Day = @{
                                 @"backgroundcolor":@"#FFFFFF",
                                 @"textColor":@"#000000"
                                 };
    NSDictionary * theme_Night = @{
                                   @"backgroundcolor":@"#000000",
                                   @"textColor":@"#FFFFFF"
                                   };
    
    jsonDict = [NSMutableDictionary new];
    [jsonDict setValue:theme_Day forKey:@"Day"];
    [jsonDict setValue:theme_Night forKey:@"Night"];
}
-(NSString *)GetThemeJson_Key:(NSString *)key
{
    NSString * json = [NSString GetJsonStrWithDictionary:[jsonDict objectForKey:key]];
    return json;
}

@end
