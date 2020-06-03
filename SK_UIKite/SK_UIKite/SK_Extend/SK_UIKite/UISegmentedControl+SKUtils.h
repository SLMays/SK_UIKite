//
//  UISegmentedControl+SKUtils.h
//  GuJia_MMZQ
//
//  Created by YL on 2018/9/27.
//  Copyright © 2018年 石磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (SKUtils)

+ (UISegmentedControl *_Nullable)initWithItems:(NSArray *_Nullable)items frame:(CGRect)frame selectedIndex:(int)selectedIndex tintColor:(NSString *_Nullable)tintColor titleAttNormal:(NSDictionary *_Nullable)titleAttNormal titleAttSelected:(NSDictionary *_Nullable)titleAttSelected target:(nullable id)target action:(SEL _Nullable)sel;

@end
