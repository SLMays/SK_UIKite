/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */


#import "SHA256.h"

#import <CommonCrypto/CommonHMAC.h>

@interface SHA256 ()

@property (nonatomic, strong, readwrite) NSString *appKey;
@property (nonatomic, strong, readwrite) NSString *appSecret;

@end

@implementation SHA256

#pragma mark -

+ (instancetype)instanceWithAppKey:(NSString *)key secret:(NSString *)secret {
    return [[[self class] alloc] initWithAppKey:key secret:secret];
}


- (id)initWithAppKey:(NSString *)key secret:(NSString *)secret {
    if (self = [super init]) {
        self.appKey = key;
        self.appSecret = secret;
    }
    
    return self;
}

#pragma mark -

- (NSString *)signMethod {
    return @"HmacSHA256";
}

/**
 *  对字符串进行hmacSha256加密，然后再进行BASE64编码
 */
- (NSString *)signWithData:(NSString *)data {
    const char *cKey  = [self.appSecret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    //将加密结果进行一次BASE64编码
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];
    return hash;
}

@end
