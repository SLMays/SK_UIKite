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
   success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success
   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    SK_HTTPClient *manager = [SK_HTTPClient manager];
    
    //    修改网络不稳定，请重新刷新时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 6.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    //设置请求头
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"cn" forHTTPHeaderField:@"Accept-Language"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"0oalnfaz49KsTy9CB8e8" forHTTPHeaderField:@"ApplicationKey"];
    
    NSMutableString * sginRequestHeader = [[NSMutableString alloc]initWithString:requestHeader];
    
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
        UIImage * _image = [image fixOrientation];
        NSData *imgData = UIImageJPEGRepresentation(_image, 1);

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
+(void)post:(NSString *)requestHeader parameters:(id)parameters imageArr:(NSArray *)imageArr serverNameArr:(NSArray *)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
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
    
    switch (errorCode) {
        case NSURLErrorUnknown:
        {
            errorContent = @"未知Error";
        }
            break;
        case kCFHostErrorHostNotFound:
        {
            errorContent = @"Indicates that the DNS lookup failed.";
        }
            break;
        case kCFHostErrorUnknown:
        {
            errorContent = @"An unknown error occurred (a name server failure, for example). For additional information, query the kCFGetAddrInfoFailureKey to get the value returned from getaddrinfo; lookup in netdb.h.";
        }
            break;
        case kCFSOCKSErrorUnknownClientVersion:
        {
            errorContent = @"The SOCKS server rejected access because it does not support connections with the requested SOCKS version.Query kCFSOCKSStatusCodeKey to recover the status code returned by the server.";
        }
            break;
        case kCFSOCKSErrorUnsupportedServerVersion:
        {
            errorContent = @"The version of SOCKS requested by the server is not supported. Query kCFSOCKSStatusCodeKey to recover the status code returned by the server.";
        }
            break;
        case kCFSOCKS4ErrorRequestFailed:
        {
            errorContent = @"Request rejected or failed by the server.";
        }
            break;
        case kCFSOCKS4ErrorIdentdFailed:
        {
            errorContent = @"Request rejected because SOCKS server cannot connect to identd on the client.";
        }
            break;
        case kCFSOCKS4ErrorIdConflict:
        {
            errorContent = @"Request rejected because the client program and identd report different user-ids.";
        }
            break;
        case kCFSOCKS4ErrorUnknownStatusCode:
        {
            errorContent = @"The status code returned by the server is unknown.";
        }
            break;
        case kCFSOCKS5ErrorBadState:
        {
            errorContent = @"The stream is not in a state that allows the requested operation.";
        }
            break;
        case kCFSOCKS5ErrorBadResponseAddr:
        {
            errorContent = @"The address type returned is not supported.";
        }
            break;
        case kCFSOCKS5ErrorBadCredentials:
        {
            errorContent = @"The SOCKS server refused the client connection because of bad login credentials.";
        }
            break;
        case kCFSOCKS5ErrorUnsupportedNegotiationMethod:
        {
            errorContent = @"The requested method is not supported. Query kCFSOCKSNegotiationMethodKey to find the method requested.";
        }
            break;
        case kCFSOCKS5ErrorNoAcceptableMethod:
        {
            errorContent = @"The client and server could not find a mutually agreeable authentication method.";
        }
            break;
        case kCFFTPErrorUnexpectedStatusCode:
        {
            errorContent = @"The server returned an unexpected status code. Query the kCFFTPStatusCodeKey to get the status code returned by the server";
        }
            break;
        case kCFErrorHTTPAuthenticationTypeUnsupported:
        {
            errorContent = @"The client and server could not agree on a supported authentication type.";
        }
            break;
        case kCFErrorHTTPBadCredentials:
        {
            errorContent = @"The credentials provided for an authenticated connection were rejected by the server.";
        }
            break;
        case kCFErrorHTTPConnectionLost:
        {
            errorContent = @"The connection to the server was dropped. This usually indicates a highly overloaded server.";
        }
            break;
        case kCFErrorHTTPParseFailure:
        {
            errorContent = @"The HTTP server response could not be parsed.";
        }
            break;
        case kCFErrorHTTPRedirectionLoopDetected:
        {
            errorContent = @"Too many HTTP redirects occurred before reaching a page that did not redirect the client to another page. This usually indicates a redirect loop.";
        }
            break;
        case kCFErrorHTTPBadURL:
        {
            errorContent = @"The requested URL could not be retrieved.";
        }
            break;
        case kCFErrorHTTPProxyConnectionFailure:
        {
            errorContent = @"A connection could not be established to the HTTP proxy.";
        }
            break;
        case kCFErrorHTTPBadProxyCredentials:
        {
            errorContent = @"The authentication credentials provided for logging into the proxy were rejected.";
        }
            break;
        case kCFErrorPACFileError:
        {
            errorContent = @"An error occurred with the proxy autoconfiguration file.";
        }
            break;
        case kCFErrorPACFileAuth:
        {
            errorContent = @"The authentication credentials provided by the proxy autoconfiguration file were rejected.";
        }
            break;
        case kCFErrorHTTPSProxyConnectionFailure:
        {
            errorContent = @"A connection could not be established to the HTTPS proxy.";
        }
            break;
        case kCFStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod:
        {
            errorContent = @"The HTTPS proxy returned an unexpected status code, such as a 3xx redirect.";
        }
            break;
        case kCFURLErrorUnknown:
        {
            errorContent = @"An unknown error occurred.";
        }
            break;
        case kCFURLErrorCancelled:
        {
            errorContent = @"The connection was cancelled.";
        }
            break;
        case kCFURLErrorBadURL:
        {
            errorContent = @"The connection failed due to a malformed URL.";
        }
            break;
        case kCFURLErrorTimedOut:
        {
            errorContent = @"The connection timed out.";
        }
            break;
        case kCFURLErrorUnsupportedURL:
        {
            errorContent = @"The connection failed due to an unsupported URL scheme.";
        }
            break;
        case kCFURLErrorCannotFindHost:
        {
            errorContent = @"The connection failed because the host could not be found.";
        }
            break;
        case kCFURLErrorCannotConnectToHost:
        {
            errorContent = @"The connection failed because a connection cannot be made to the host.";
        }
            break;
        case kCFURLErrorNetworkConnectionLost:
        {
            errorContent = @"The connection failed because the network connection was lost.";
        }
            break;
        case kCFURLErrorDNSLookupFailed:
        {
            errorContent = @"The connection failed because the DNS lookup failed.";
        }
            break;
        case kCFURLErrorHTTPTooManyRedirects:
        {
            errorContent = @"The HTTP connection failed due to too many redirects.";
        }
            break;
        case kCFURLErrorResourceUnavailable:
        {
            errorContent = @"The connection’s resource is unavailable.";
        }
            break;
        case kCFURLErrorNotConnectedToInternet:
        {
            errorContent = @"The connection failed because the device is not connected to the internet.";
        }
            break;
        case kCFURLErrorRedirectToNonExistentLocation:
        {
            errorContent = @"The connection was redirected to a nonexistent location.";
        }
            break;
        case kCFURLErrorBadServerResponse:
        {
            errorContent = @"The connection received an invalid server response.";
        }
            break;
        case kCFURLErrorUserCancelledAuthentication:
        {
            errorContent = @"The connection failed because the user cancelled required authentication.";
        }
            break;
        case kCFURLErrorUserAuthenticationRequired:
        {
            errorContent = @"The connection failed because authentication is required.";
        }
            break;
        case kCFURLErrorZeroByteResource:
        {
            errorContent = @"The resource retrieved by the connection is zero bytes.";
        }
            break;
        case kCFURLErrorCannotDecodeRawData:
        {
            errorContent = @"The connection cannot decode data encoded with a known content encoding.";
        }
            break;
        case kCFURLErrorCannotDecodeContentData:
        {
            errorContent = @"The connection cannot decode data encoded with an unknown content encoding.";
        }
            break;
        case kCFURLErrorCannotParseResponse:
        {
            errorContent = @"The connection cannot parse the server’s response.";
        }
            break;
        case kCFURLErrorInternationalRoamingOff:
        {
            errorContent = @"The connection failed because international roaming is disabled on the device.";
        }
            break;
        case kCFURLErrorCallIsActive:
        {
            errorContent = @"The connection failed because a call is active.";
        }
            break;
        case kCFURLErrorDataNotAllowed:
        {
            errorContent = @"The connection failed because data use is currently not allowed on the device.";
        }
            break;
        case kCFURLErrorRequestBodyStreamExhausted:
        {
            errorContent = @"The connection failed because its request’s body stream was exhausted.";
        }
            break;
        case kCFURLErrorFileDoesNotExist:
        {
            errorContent = @"The file operation failed because the file does not exist.";
        }
            break;
        case kCFURLErrorFileIsDirectory:
        {
            errorContent = @"The file operation failed because the file is a directory.";
        }
            break;
        case kCFURLErrorNoPermissionsToReadFile:
        {
            errorContent = @"The file operation failed because it does not have permission to read the file.";
        }
            break;
        case kCFURLErrorDataLengthExceedsMaximum:
        {
            errorContent = @"The file operation failed because the file is too large.";
        }
            break;
        case kCFURLErrorSecureConnectionFailed:
        {
            errorContent = @"The secure connection failed for an unknown reason";
        }
            break;
        case kCFURLErrorServerCertificateHasBadDate:
        {
            errorContent = @"The secure connection failed because the server’s certificate has an invalid date.";
        }
            break;
        case kCFURLErrorServerCertificateUntrusted:
        {
            errorContent = @"The secure connection failed because the server’s certificate is not trusted.";
        }
            break;
        case kCFURLErrorServerCertificateHasUnknownRoot:
        {
            errorContent = @"The secure connection failed because the server’s certificate has an unknown root.";
        }
            break;
        case kCFURLErrorServerCertificateNotYetValid:
        {
            errorContent = @"The secure connection failed because the server’s certificate is not yet valid.";
        }
            break;
        case kCFURLErrorClientCertificateRejected:
        {
            errorContent = @"The secure connection failed because the client’s certificate was rejected.";
        }
            break;
        case kCFURLErrorClientCertificateRequired:
        {
            errorContent = @"The secure connection failed because the server requires a client certificate.";
        }
            break;
        case kCFURLErrorCannotLoadFromNetwork:
        {
            errorContent = @"The connection failed because it is being required to return a cached resource, but one is not available.";
        }
            break;
        case kCFURLErrorCannotCreateFile:
        {
            errorContent = @"The file cannot be created.";
        }
            break;
        case kCFURLErrorCannotOpenFile:
        {
            errorContent = @"The file cannot be opened.";
        }
            break;
        case kCFURLErrorCannotCloseFile:
        {
            errorContent = @"The file cannot be closed.";
        }
            break;
        case kCFURLErrorCannotWriteToFile:
        {
            errorContent = @"The file cannot be written.";
        }
            break;
        case kCFURLErrorCannotRemoveFile:
        {
            errorContent = @"The file cannot be removed.";
        }
            break;
        case kCFURLErrorCannotMoveFile:
        {
            errorContent = @"The file cannot be moved.";
        }
            break;
        case kCFURLErrorDownloadDecodingFailedMidStream:
        {
            errorContent = @"The download failed because decoding of the downloaded data failed mid-stream.";
        }
            break;
        case kCFURLErrorDownloadDecodingFailedToComplete:
        {
            errorContent = @"The download failed because decoding of the downloaded data failed to complete.";
        }
            break;
        case kCFHTTPCookieCannotParseCookieFile:
        {
            errorContent = @"The cookie file cannot be parsed.";
        }
            break;
        case kCFNetServiceErrorUnknown:
        {
            errorContent = @"An unknown error occurred.";
        }
            break;
        case kCFNetServiceErrorCollision:
        {
            errorContent = @"An attempt was made to use a name that is already in use.";
        }
            break;
        case kCFNetServiceErrorNotFound:
        {
            errorContent = @"Not used.";
        }
            break;
        case kCFNetServiceErrorInProgress:
        {
            errorContent = @"A new search could not be started because a search is already in progress.";
        }
            break;
        case kCFNetServiceErrorBadArgument:
        {
            errorContent = @"A required argument was not provided or was not valid.";
        }
            break;
        case kCFNetServiceErrorCancel:
        {
            errorContent = @"The search or service was cancelled.";
        }
            break;
        case kCFNetServiceErrorInvalid:
        {
            errorContent = @"Invalid data was passed to a CFNetServices function.";
        }
            break;
        case kCFNetServiceErrorTimeout:
        {
            errorContent = @"A search failed because it timed out.";
        }
            break;
        case kCFNetServiceErrorDNSServiceFailure:
        {
            errorContent = @"An error from DNS discovery; look at kCFDNSServiceFailureKey to get the error number and interpret using dnssd.h.";
        }
            break;
            
        default:
            errorContent = [NSString stringWithFormat:@"ErrorCode:%ld",(long)errorCode];
            break;
    }
    
    
    return errorContent;
}

@end
