//
//  SK_HTTPClient.h
//  StockHome
//
//  Created by 石磊 on 15/7/5.
//  Copyright (c) 2015年 SLMays. All rights reserved.
//

#import "AFNetworking.h"
 
@class NSURLSessionDataTask;

#define AF_STATUS_Get   0           //用于判断成功请求状态的【数值】
#define AF_STATUS_Post  1           //用于判断成功请求状态的【数值】
#define AF_KEY      @"state"        //用于判断成功请求状态的【字段】

@interface SK_HTTPClient : AFHTTPSessionManager
/*!                    
 *  所有请求的请求头  例如 @"http://www.ifood517.com/index.php/Api/App/"
 *
 *  @since 1.0
 */
@property (nonatomic, strong)NSString *requestHeaderString;

typedef NS_ENUM(NSUInteger, HTTPCachePolicy) {
    HTTPCachePolicyNormal,              //普通网络请求,不会有缓存
    HTTPCachePolicyCacheAndRefresh,     //如果有网络直接读网络，如果没网络直接读本地
    HTTPCachePolicyCacheAndLocal        //优先读取本地，不管有没有网络，优先读取本地
};
typedef enum {
    NetWorkStatueNone = 0,  //无网络
    NetWorkStatueNormal,    //普通
    NetWorkStatueWifi       //wifi
}NetWorkStatue;

@property (nonatomic, assign)NetWorkStatue netWorkStatue;

//@property (nonatomic, assign)SK_HTTPClient *singleHTTPClient;

+ (SK_HTTPClient *)defaultClient;


/*!
 *  简单的POST 请求
 *
 *  @param requestHeader 请求的 接口名称 如@"getCabList"  不需要包括请求头
 *  @param parameters    API 请求参数 字典格式
 *  @param success       成功的回调
 *  @param failure       失败的回调
 *
 */
+(void)post:(NSString *)requestHeader
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject,BOOL isOK))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/*!
 *  支持图片上传的异步POST
 *
 *  @param requestHeader 请求的 接口名称 如@"getCabList"  不需要包括请求头
 *  @param parameters    API 请求参数 字典格式
 *  @param image         准备上传的图片
 *  @param success       成功回调
 *  @param failure       失败回调
 *
 */
+(void)post:(NSString *)requestHeader
 parameters:(id)parameters
      image:(UIImage *)image
       name:(NSString *)name
   fileName:(NSString *)fileName
   mimeType:(NSString *)mimeType
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  异步上传多张图片
 *
 *  @param requestHeader 请求的 接口名称 如@"getCabList"  不需要包括请求头
 *  @param parameters    API 请求参数 字典格式
 *  @param success       成功回调
 *  @param failure       失败回调
 *
 */
+(void)post:(NSString *)requestHeader parameters:(id)parameters imageArr:(NSArray *)imageArr nameArr:(NSArray *)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/*!
 *  GET 请求
 *
 *  @param URLString  请求接口名 不包括请求头
 *  @param parameters 参数 字典格式
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 */
+(void)get:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success
   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


/**
 *  根据Error获得错误信息
 *  @return 错误信息
 */
+(NSString *)getErrorContentWith:(NSError *)error;

@end
