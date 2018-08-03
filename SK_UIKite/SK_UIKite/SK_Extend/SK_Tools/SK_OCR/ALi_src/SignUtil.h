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

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import "HttpConstant.h"
#import "SDKConstant.h"


/**
 *
 *  签名工具类
 *  客户端需要对Request中的关键内容做签名处理，将生成的签名字符串放入到请求头中
 *  网关在收到Request后，在验证签名合法后才将请求转发给后端服务，否则返回400
 *  签名采用hmacSha256算法，秘钥在“阿里云官网”->"API网关"->"应用管理"->"应用详情"查看
 *
 */
@interface SignUtil : NSObject

/**
 * 将Request中的httpMethod、headers、path、queryParam、formParam合成一个字符串
 */
+(NSString *) buildStringToSign:(NSDictionary *) headers
                           path:(NSString *) path
                     queryParam:(NSDictionary *) queryParam
                      formParam:(NSDictionary *) formParam
                         method:(NSString *) method;


@end

@interface SignUtil (private)



/**
 * 将headers合成一个字符串
 */
+(NSString *) buildHeaders:(NSDictionary *) headers;


/**
 * 将path、queryParam、formParam合成一个字符串
 */
+(NSString *) buildResource:(NSString *) path queryParam:(NSDictionary *) queryParam formParam:(NSDictionary *) formParam;

@end
