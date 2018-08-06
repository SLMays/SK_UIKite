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

#import "SignUtil.h"

@implementation SignUtil

/**
 * 将Request中的httpMethod、headers、path、queryParam、formParam合成一个字符串
 */
+(NSString *) buildStringToSign:(NSMutableDictionary *) headers
                           path:(NSString *) path
                     queryParam:(NSDictionary *) queryParam
                      formParam:(NSDictionary *) formParam
                         method:(NSString *) method{
    
    NSMutableString * result = [[NSMutableString alloc] initWithFormat:@"%@%c" , method , CLOUDAPI_LF];
    
    //如果有@"Accept"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_ACCEPT]){
        [result appendString:[headers valueForKey:CLOUDAPI_HTTP_HEADER_ACCEPT]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];
    
    //如果有@"Content-MD5"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_CONTENT_MD5]){
        [result appendString: [headers valueForKey:CLOUDAPI_HTTP_HEADER_CONTENT_MD5]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];
    
    //如果有@"Content-Type"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_CONTENT_TYPE]){
        [result appendString: [headers valueForKey:CLOUDAPI_HTTP_HEADER_CONTENT_TYPE]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];
    
    //如果有@"Date"头，这个头需要参与签名
    if(nil != [headers objectForKey:CLOUDAPI_HTTP_HEADER_DATE]){
        [result appendString:[headers valueForKey:CLOUDAPI_HTTP_HEADER_DATE]];
    }
    [result appendFormat:@"%c" , CLOUDAPI_LF];
    
    
    //将headers合成一个字符串
    [result appendString:[SignUtil buildHeaders:headers]];
    
    //将path、queryParam、formParam合成一个字符串
    [result appendString:[SignUtil buildResource:path queryParam:queryParam formParam:formParam]];
    
    return result;
    
}

@end
@implementation SignUtil(private)


/**
 *  将headers合成一个字符串
 *  需要注意的是，HTTP头需要按照字母排序加入签名字符串
 *  同时所有加入签名的头的列表，需要用逗号分隔形成一个字符串，加入一个新HTTP头@"X-Ca-Signature-Headers"
 */
+(NSString *) buildHeaders:(NSMutableDictionary *) headers{
    NSMutableString * signHeaders  = [[NSMutableString alloc] init];
    NSMutableString * result = [[NSMutableString alloc] init];
    
    //使用NSMutableOrderedSet好排序
    NSMutableOrderedSet * signHeaderNames = [[NSMutableOrderedSet alloc] init];
    if(nil != headers){
        bool isFirst = true;
        for(id key in headers){
            if([key hasPrefix:CLOUDAPI_CA_HEADER_PREFIX]){
                if(!isFirst){
                    [signHeaders appendString:@","];
                }
                else{
                    isFirst = false;
                }
                
                
                [signHeaders appendString:key];
                [signHeaderNames addObject:key];
            }
        }
        //同时所有加入签名的头的列表，需要用逗号分隔形成一个字符串，加入一个新HTTP头@"X-Ca-Signature-Headers"
        [headers setValue:signHeaders forKey:CLOUDAPI_X_CA_SIGNATURE_HEADERS];
        
    }
    
    //加入签名的头需要按照头的字母排序
    [signHeaderNames sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str1 compare:str2];
    }];
    for(int i = 0 ; i < (int)[signHeaderNames count]  ; i++){
        [result appendFormat:@"%@:%@%c" , [signHeaderNames objectAtIndex:i] , [headers objectForKey:[signHeaderNames objectAtIndex:i]] , CLOUDAPI_LF];
    }
    
    return result;
}


/**
 * 将path、queryParam、formParam合成一个字符串
 */
+(NSString *) buildResource:(NSString *) path queryParam:(NSDictionary *) queryParam formParam:(NSDictionary *) formParam
{
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    
    
    if(nil != queryParam && queryParam.count > 0){
        [parameters addEntriesFromDictionary:queryParam];
    }
    
    if(nil != formParam && formParam.count > 0){
        [parameters addEntriesFromDictionary:formParam];
    }
    
    NSArray * keys = [parameters allKeys];
    NSArray * sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str1 compare:str2];
    }];
    
    
    NSMutableString * result = [[NSMutableString alloc] initWithString:path];
    
    if(parameters.count > 0){
        [result appendString:@"?"];
        bool isFirst = true;
        for(int i = 0 ; i < sortedKeys.count ; i++){
            if(!isFirst){
                [result appendString:@"&"];
            }
            else{
                isFirst = false;
            }
            id key = [sortedKeys objectAtIndex:i];
            [result appendString:key];
            
            NSString* value = [parameters objectForKey:key];
            if(nil !=  value && [NSNull null] != (NSNull *)value && [value length] > 0 )
            [result appendFormat:@"=%@" , value];
            
        }
        
    }
    
    return result;
}




@end
