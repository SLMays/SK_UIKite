//
//  SK_HTTPClient.h
//  StockHome
//
//  Created by 石磊 on 15/7/5.
//  Copyright (c) 2015年 SLMays. All rights reserved.
//

#import "SK_HTTPClient.h"
#import "FixOrientation.h"
#import "SK_Base64Util.h"

#define MaxKB  1024
#define LogURL 1

static SK_HTTPClient *singleHTTPClient = nil;

@implementation SK_HTTPClient

/*!
 *  GJ_HTTPClient 是不是单例都可以
 */

+ (SK_HTTPClient *)defaultClient
{
    static dispatch_once_t onceToken;
    dispatch_once( & onceToken, ^{
        if (singleHTTPClient == Nil) {
            singleHTTPClient                                           = [[SK_HTTPClient alloc]init];
            singleHTTPClient.netWorkStatue                             = NetWorkStatueNormal;
            singleHTTPClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json",@"text/json",@"text/javascript",nil];
        }
    });
    return singleHTTPClient;
}



+(void)post:(NSString *)requestHeader
 parameters:(NSDictionary *)parameters
HTTPCachePolicy:(HTTPCachePolicy)HTTPCashPolicyType
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    SK_HTTPClient *manager = [SK_HTTPClient manager];
    //    修改网络不稳定，请重新刷新时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];

    NSMutableDictionary *mutableDic;
    if (DICT_IS_NOT_EMPTY(parameters)) {
        mutableDic = [parameters mutableCopy];
    }else{
        mutableDic = [[NSMutableDictionary alloc]init];
    };
    
    parameters = mutableDic;
    
    NSURLSessionDataTask *operation;
    
    if (LogURL) {
        if (DICT_IS_NOT_EMPTY(parameters)) {
            NSLog(@"【请求】%@?%@\n________",requestHeader,[NSString GetURLStringWithDictionary:parameters]);
        }else{
            NSLog(@"【请求】%@\n________",requestHeader);
        }
    }

    [manager POST:requestHeader
       parameters:parameters
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (LogURL) {
                 NSLog(@"___收到返回数据____\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@\n______________\n",requestHeader);
             }
             
             BOOL isOK = [responseObject[AF_KEY] integerValue] == AF_STATUS_Post;
             success(task,responseObject,isOK);
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (LogURL) {
                 NSLog(@"【报错】%@\n________",requestHeader);
             }
             if (failure) {
                 failure(operation,error);
             }
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         }];
}

+(void)get:(NSString *)requestHeader
parameters:(id)parameters
HTTPCachePolicy:(HTTPCachePolicy)HTTPCashPolicyType
   success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success
   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    SK_HTTPClient *manager = [SK_HTTPClient manager];
    
    //    修改网络不稳定，请重新刷新时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 6.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableString * sginRequestHeader = [[NSMutableString alloc]initWithString:requestHeader];
    [sginRequestHeader appendFormat:@"&sign=%@",[self GetJiaMiWithRequestHeader:requestHeader]];
    
    if (LogURL) {
        NSLog(@"____http 请求____\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@\n________",sginRequestHeader);
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:sginRequestHeader
      parameters:parameters
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (LogURL) {
                NSLog(@"___收到返回数据____\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@\n______________\n",requestHeader);
            }
            if (success) {
                BOOL isOk = [responseObject[AF_KEY] intValue] == AF_STATUS_Get;
                success(task,responseObject,isOk);
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"___收到错误信息____\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@\n________",sginRequestHeader);
            
            if (failure) {
                failure(task,error);
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }];
}


#pragma mark - 上传图片
+(void)post:(NSString *)requestHeader
 parameters:(id)parameters
      image:(UIImage *)image
       name:(NSString *)name
   fileName:(NSString *)fileName
   mimeType:(NSString *)mimeType
HTTPCachePolicy:(HTTPCachePolicy)HTTPCashPolicyType
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    SK_HTTPClient *manager = [SK_HTTPClient manager];
    //    修改网络不稳定，请重新刷新时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects: @"text/plain",@"text/html", @"application/json",@"text/json",@"text/javascript",nil];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary * mdict = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    
    if (DICT_IS_NOT_EMPTY(parameters)) {
        if (!image) {
            [mdict removeObjectForKey:@"img"];
        }
        NSLog(@"_________requestHeader______\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@?%@\n",requestHeader,[NSString GetURLStringWithDictionary:mdict]);
    }else{
        NSLog(@"_________requestHeader______\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@\n",requestHeader);
    }
    
    
    [manager POST:requestHeader
       parameters:mdict
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    if (image) {
        UIImage * _image = image;
        NSData *imgData = UIImagePNGRepresentation(_image);

        _image  = [_image fixOrientation];
        imgData = UIImageJPEGRepresentation(_image, 1);
        long KB = (long)imgData.length/1024;
        NSLog(@"【原始】图片内存大小__%ld_KB",KB);
        if (KB>MaxKB) {
            _image  = [UIImage imageWithData:imgData];
            imgData = UIImageJPEGRepresentation(_image, MaxKB/KB);
            KB      = (long)imgData.length/1024;
            NSLog(@"【压缩】图片内存大小__%ld_KB",KB);
        };

        //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名;fileName,指定文件名;mimeType,指定文件格式 */
        [formData appendPartWithFileData:imgData name:name fileName:fileName mimeType:mimeType];
    }
} progress:^(NSProgress * _Nonnull uploadProgress) {
    
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSString * jsonStr  = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"jsonStr========\n%@",jsonStr);
    NSDictionary * Dict = [NSDictionary GetDictionaryWithString:jsonStr];
    NSLog(@"Dict========\n%@",Dict);
    
    BOOL isOK = [Dict[AF_KEY] integerValue] == AF_STATUS_Post;
    success(task,Dict,isOK);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (failure) {
        failure(task,error);
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}];
    
}

#pragma mark - 上传多张图片
+(void)post:(NSString *)requestHeader parameters:(id)parameters imageArr:(NSArray *)imageArr nameArr:(NSArray *)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType HTTPCachePolicy:(HTTPCachePolicy)HTTPCashPolicyType success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    SK_HTTPClient *manager = [SK_HTTPClient manager];
    //    修改网络不稳定，请重新刷新时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects: @"text/plain",@"text/html", @"application/json",@"text/json",@"text/javascript",nil];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary * mdict                                       = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    
    if (DICT_IS_NOT_EMPTY(parameters)) {
        if (!ARRAY_IS_NOT_EMPTY(imageArr)) {
            [mdict setValue:@"" forKey:@"img"];
        }
        NSLog(@"_________requestHeader______\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@?%@\n",requestHeader,[NSString GetURLStringWithDictionary:mdict]);
    }else{
        NSLog(@"_________requestHeader______\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n%@\n",requestHeader);
    }
    
    [manager POST:requestHeader
       parameters:mdict
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    if (ARRAY_IS_NOT_EMPTY(imageArr)) {
        // 上传 多张图片
        for(NSInteger i = 0; i < imageArr.count; i++)
        {
            UIImage * _image = imageArr[i];
            _image           = [_image fixOrientation];
            NSData * imgData = UIImageJPEGRepresentation(_image, 1);
            long KB          = (long)imgData.length/1024;
            NSLog(@"【原始】图片内存大小__%ld_KB",KB);
            if (KB>200) {
                _image  = [UIImage imageWithData:imgData];
                imgData = UIImageJPEGRepresentation(_image, 200/KB);
                KB      = (long)imgData.length/1024;
                NSLog(@"【压缩】图片内存大小__%ld_KB",KB);
            };
            //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名;fileName,指定文件名;mimeType,指定文件格式 */
            [formData appendPartWithFileData:imgData name:nameArr[i] fileName:fileNameArr[i] mimeType:mimeType];
        }
    }
} progress:^(NSProgress * _Nonnull uploadProgress) {
    
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSString * jsonStr  = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"jsonStr========\n%@",jsonStr);
    NSDictionary * Dict = [NSDictionary GetDictionaryWithString:jsonStr];
    NSLog(@"Dict========\n%@",Dict);
    
    BOOL isOK = [Dict[AF_KEY] integerValue] == AF_STATUS_Post;
    success(task,Dict,isOK);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (failure) {
        failure(task,error);
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}];
}



/**
 *  根据Error获得错误信息
 */
+(NSString *)getErrorContentWith:(NSError *)error
{
    NSString *errorContent = @"";
    NSInteger errorCode    = [error code];
    
    SK_HTTPClient * singleHTTPClient = [SK_HTTPClient defaultClient];
    if (singleHTTPClient.netWorkStatue == NetWorkStatueNone) {
        return @"网络有问题,请检查网络";
    }
    
    NSLog(@"\n错误信息:  %@",error);
    
    // -1001: request timeout
    // -1002: unsupported URL
    // -1003: cannot find host
    // -1004: cannot connect to host
    // -1005: network connection lost
    // -1006: DNS lookup failed
    // -1008: resource unavailable
    // -1009: not connected to internet
    
    switch (errorCode) {
        case -999:
            errorContent = @"请求被取消";
            break;
        case -1001:
            errorContent = @"网络不稳定，请重新刷新";
            break;
        case -1002:
            errorContent = @"不支持的URL";
            break;
        case -1003:
            errorContent = @"找不到服务器";
            break;
        case -1004:
            errorContent = @"无法连接到服务器";
            break;
        case -1005:
            errorContent = @"网络连接丢失";
            break;
        case -1006:
            errorContent = @"DNS查找失败";
            break;
        case -1009:
            errorContent = @"没有连接到互联网";
            break;
        case -1011:
            errorContent = @"服务器异常";
            break;
            
        default:
            errorContent = [NSString stringWithFormat:@"未知错误:%ld",(long)errorCode];
            break;
    }
    
    errorContent = @"网络连接失败";
    
    return errorContent;
}

@end
