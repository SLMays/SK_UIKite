//
//  SK_ThemeHelp.h
//  SK_UIKite
//
//  Created by Skylin on 2018/7/10.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Theme_Day       @"Day"
#define Theme_Night     @"Night"


//颜色
#define Color_363636_FF7F24     @"Color_363636_FF7F24"
#define Color_CFCFCF_FFFFFF     @"Color_CFCFCF_FFFFFF"
#define Color_FFFF00_1E90FF     @"Color_FFFF00_1E90FF"
#define Color_CFCFCF_000000     @"Color_CFCFCF_000000"
#define Color_C2D8E4_FFFFFF     @"Color_C2D8E4_FFFFFF"
#define Color_152C45_FFFFFF     @"Color_152C45_FFFFFF"
#define Color_C2D8E4_333333     @"Color_C2D8E4_333333"
#define Color_FFFFFF_FFFFFF     @"Color_FFFFFF_FFFFFF"
#define Color_333333_333333     @"Color_333333_333333"
#define Color_969696_7b7b7b     @"Color_969696_7b7b7b"
#define Color_Random             @"Color_Random"
#define Color_Clear             @"Color_Clear"










@interface SK_ThemeHelp : NSObject

+(SK_ThemeHelp *)sharedInstance;
-(NSString *)GetThemeJson_Key:(NSString *)key;

@end
