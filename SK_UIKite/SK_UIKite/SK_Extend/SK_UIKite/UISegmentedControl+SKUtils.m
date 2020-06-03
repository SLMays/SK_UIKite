//
//  UISegmentedControl+SKUtils.m
//  GuJia_MMZQ
//
//  Created by YL on 2018/9/27.
//  Copyright © 2018年 石磊. All rights reserved.
//

#import "UISegmentedControl+SKUtils.h"

@implementation UISegmentedControl (SKUtils)

+ (UISegmentedControl*)initWithItems:(NSArray *)items frame:(CGRect)frame selectedIndex:(int)selectedIndex tintColor:(NSString *)tintColor titleAttNormal:(NSDictionary *)titleAttNormal titleAttSelected:(NSDictionary *)titleAttSelected target:(nullable id)target action:(SEL)sel
{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:items];
    segmentControl.frame = frame;
    
    segmentControl.backgroundColor = [UIColor clearColor];
    
    segmentControl.selectedSegmentIndex = selectedIndex;
    
    if (STRING_IS_NOT_EMPTY(tintColor)) {
        segmentControl.lee_theme.LeeConfigTintColor(tintColor);
    }else{
        if (@available(iOS 13.0, *)) {
            segmentControl.selectedSegmentTintColor = [UIColor clearColor];
        } else {
            segmentControl.tintColor = [UIColor clearColor];
        }
    }
    
    [segmentControl setTitleTextAttributes:titleAttNormal forState:UIControlStateNormal];
    [segmentControl setTitleTextAttributes:titleAttSelected forState:UIControlStateSelected];
    [segmentControl addTarget:target action:sel forControlEvents:UIControlEventValueChanged];
    
    return segmentControl;
}

@end
