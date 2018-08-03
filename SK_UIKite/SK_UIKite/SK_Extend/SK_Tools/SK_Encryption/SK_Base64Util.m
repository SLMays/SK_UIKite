//
//  SK_Base64Util.m
//  ThuInfo
//
//  Created by WenHao on 12-10-30.
//  Copyright (c) 2012年 WenHao. All rights reserved.
//

#import "SK_Base64Util.h"

@implementation SK_Base64Util
//加密
+ (NSString*)encodeBase64:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //转换到base64
    data = [SK_GTMBase64 encodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

//解密
+ (NSString*)decodeBase64:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //转换到base64
    data = [SK_GTMBase64 decodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
@end
