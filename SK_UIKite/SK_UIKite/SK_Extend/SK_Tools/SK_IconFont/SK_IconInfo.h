//
//  SK_IconInfo.h
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/4/12.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SK_IconName.h"

#define SK_IconInfoMake(text, textSize, textColor) [SK_IconInfo iconInfoWithText:text size:textSize color:textColor]
#define SK_IconInfoMake_Hex(text, textSize, textHexColor) [SK_IconInfo iconInfoWithText:text size:textSize hexColor:textHexColor]
#define SK_IconImageMake(text, imageSize, imageColor) [UIImage iconWithInfo:[SK_IconInfo iconInfoWithText:text size:imageSize color:imageColor]]
#define SK_IconImageMake_Hex(text, imageSize, imageHexColor) [UIImage iconWithInfo:[SK_IconInfo iconInfoWithText:text size:imageSize hexColor:imageHexColor]]

@interface SK_IconInfo : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) UIColor *color;

+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color;
+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size hexColor:(NSString *)hexColor;

@end
