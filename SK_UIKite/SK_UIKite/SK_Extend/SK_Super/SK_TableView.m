//
//  SK_TableView.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/28.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_TableView.h"

@implementation SK_TableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    
    return self;
}

@end
