//
//  SK_IconFont.h
//  SK_UIKiteDemo
//
//  Created by Skylin on 2018/4/12.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SK_IconInfo.h"

@interface SK_IconFont : NSObject
+ (UIFont *)fontWithSize: (CGFloat)size;
+ (void)setFontName:(NSString *)fontName;
@end
