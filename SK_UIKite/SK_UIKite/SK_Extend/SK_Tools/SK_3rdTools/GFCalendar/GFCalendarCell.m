//
//  GFCalendarCell.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarCell.h"

@implementation GFCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.leftBgView];
        [self addSubview:self.rightBgView];
        [self addSubview:self.todayLabel];        
    }
    
    return self;
}

-(UIView *)leftBgView
{
    if (!_leftBgView) {
        CGFloat size = floor(0.6 * self.height);
        CGFloat top = (self.height-size)/2;
        _leftBgView = [UIView initWithFrame:CGRectMake(0, top, self.width/2, size) backgroundColor:[UIColor clearColor] alpha:1.0];
    }
    return _leftBgView;
}
-(UIView *)rightBgView
{
    if (!_rightBgView) {
        CGFloat size = floor(0.6 * self.height);
        CGFloat top = (self.height-size)/2;
        _rightBgView = [UIView initWithFrame:CGRectMake(self.width/2, top, self.width/2, size) backgroundColor:[UIColor clearColor] alpha:1.0];
    }
    return _rightBgView;
}
- (UILabel *)todayLabel {
    if (_todayLabel == nil) {
        CGFloat size = floor(0.6 * self.height);
        CGFloat margin = (self.height-size)/2;
        _todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, size, size)];
        _todayLabel.center = CGPointMake(self.width/2, self.height/2);
        _todayLabel.bRadius = size/2;
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _todayLabel.backgroundColor = [UIColor clearColor];
    }
    return _todayLabel;
}

@end
