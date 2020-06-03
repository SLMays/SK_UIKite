//
//  SK_IconInfo.m
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/4/12.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_IconInfo.h"

@implementation SK_IconInfo

- (instancetype)initWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color
{
    if (self = [super init]) {
        self.text = text;
        self.size = size;
        self.color = color;
    }
    return self;
}
- (instancetype)initWithText:(NSString *)text size:(NSInteger)size hexColor:(NSString *)hexColor
{
    if (self = [super init]) {
        self.text = text;
        self.size = size;
        self.color = [LEETheme getValueWithTag:[LEETheme currentThemeTag] Identifier:hexColor];
    }
    return self;
}
+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color
{
    return [[SK_IconInfo alloc] initWithText:text size:size color:color];
}
+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size hexColor:(NSString *)hexColor
{
    return [[SK_IconInfo alloc] initWithText:text size:size hexColor:hexColor];
}
@end
