//
//  NSDictionary+SK_Utils.h
//  SK_UIKite
//
//  Created by Skylin on 2018/5/14.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SK_Utils)

+(NSDictionary *)GetDictionaryWithData:(NSData *)data;
+(NSDictionary *)GetDictionaryWithString:(NSString *)str;

@end
