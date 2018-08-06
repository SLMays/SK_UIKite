//
//  Created by  fred on 2016/10/26.
//  Copyright © 2016 Alibaba. All rights reserved.
//

#import "ApiClient_IdCardIdentify.h"
#import <CloudApiSdk/HttpConstant.h>

@implementation ApiClient_IdCardIdentify

static NSString* HOST = @"dm-51.data.aliyun.com";

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static ApiClient_IdCardIdentify *api = nil;
    dispatch_once(&onceToken, ^{
        api = [ApiClient_IdCardIdentify new];
    });
    return api;
}

- (instancetype)init {
    self = [super initWithKey:@"24879045" appSecret:@"bb6c0527164af204b17c54bf3978218b"];
    return self;
}


- (void) IdCardIdentify:(NSData *) body completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock
{

    //定义Path
    NSString * path = @"/rest/160601/ocr/ocr_idcard.json";

    [self httpPost: CLOUDAPI_HTTP
    host: HOST
    path: path
    pathParams: nil
    queryParams: nil
    body: body
    headerParams: nil
    completionBlock: completionBlock];
}


@end
