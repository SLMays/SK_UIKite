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

@interface SK_ThemeHelp : NSObject

+(SK_ThemeHelp *)sharedInstance;
-(NSString *)GetThemeJson_Key:(NSString *)key;

@end
