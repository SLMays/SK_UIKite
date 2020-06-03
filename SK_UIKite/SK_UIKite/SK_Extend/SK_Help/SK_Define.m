//
//  SK_Define.m
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/2/8.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_Define.h"

@implementation SK_Define

#pragma -mark 判断导航的高度
+(float)NavightionHeight{
    
    if (Device_iPhone_5_8) {
        return 88.0;
    } else {
        if (IOS_VERSION>=7.0) {
            return 64.0;
        }else{
            return 44.0;
        }
    }
}
#pragma mark - 判断TabBar高度
+(float)TabBarHeight
{
    if (Device_iPhone_5_8) {
        return  83;
    }else{
        return  49;
    }
}
+(float)StatusHeight
{
    if (Device_iPhone_5_8) {
        return  44;
    }else{
        return  20;
    }
}

@end
