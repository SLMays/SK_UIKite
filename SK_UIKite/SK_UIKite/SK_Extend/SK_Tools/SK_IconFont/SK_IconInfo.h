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
#define SK_IconImageMake(text, imageSize, imageColor) [UIImage iconWithInfo:[SK_IconInfo iconInfoWithText:text size:imageSize color:imageColor]]

@interface SK_IconInfo : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color;
+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color;

@end
