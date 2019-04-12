//
//  GFCalendarCell.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFCalendarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *todayLabel; //!< 标示日期（几号）
@property (nonatomic, strong) UIView *leftBgView; //!< 标示'始末期间'
@property (nonatomic, strong) UIView *rightBgView; //!< 标示'始末期间'

@end
