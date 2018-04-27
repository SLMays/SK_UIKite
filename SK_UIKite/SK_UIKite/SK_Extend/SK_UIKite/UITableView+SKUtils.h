//
//  UITableView+SKUtils.h
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SK_TableViewCellSeparatorStyle_None = 0,
    SK_TableViewCellSeparatorStyle_Full,
}SK_TableViewCellSeparatorStyle;

@interface UITableView (SKUtils)

+(UITableView *)initWithFrame:(CGRect)frame Style:(UITableViewStyle)style Delegate:(id)delegate SeparatorStyle:(SK_TableViewCellSeparatorStyle)separatorStyle;

@end
