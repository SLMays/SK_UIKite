//
//  UITableView+SKUtils.m
//  SK_UIKiteDemo
//
//  Created by ShiLei on 2017/11/1.
//  Copyright © 2017年 SKyLin. All rights reserved.
//

#import "UITableView+SKUtils.h"

@implementation UITableView (SKUtils)

+(UITableView *)initWithFrame:(CGRect)frame Style:(UITableViewStyle)style Delegate:(id)delegate SeparatorStyle:(SK_TableViewCellSeparatorStyle)separatorStyle
{
    UITableView * mainTableView = [[UITableView alloc]initWithFrame:frame style:style];
    mainTableView.tableFooterView = [[UIView alloc]init];
    mainTableView.backgroundColor = [UIColor whiteColor];
    mainTableView.estimatedRowHeight = 0;
    mainTableView.estimatedSectionHeaderHeight = 0;
    mainTableView.estimatedSectionFooterHeight = 0;
    mainTableView.delegate = delegate;
    mainTableView.dataSource = delegate;
    mainTableView.showsVerticalScrollIndicator = NO;
    mainTableView.showsHorizontalScrollIndicator = NO;
    if (separatorStyle==SK_TableViewCellSeparatorStyle_None) {
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else if (separatorStyle==SK_TableViewCellSeparatorStyle_Full){
        [mainTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    return mainTableView;
}

@end
