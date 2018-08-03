//
//  SK_Base64Util.h
//  ThuInfo
//
//  Created by WenHao on 12-10-30.
//  Copyright (c) 2012年 WenHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SK_GTMBase64.h"

@interface SK_Base64Util : NSObject

//加密
+ (NSString*)encodeBase64:(NSString*)input;
//解密
+ (NSString*)decodeBase64:(NSString*)input;

@end
