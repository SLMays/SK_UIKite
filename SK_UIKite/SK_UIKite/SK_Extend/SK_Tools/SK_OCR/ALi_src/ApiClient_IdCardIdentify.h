//
//  Created by  fred on 2016/10/26.
//  Copyright © 2016 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudApiSdk/BaseApiClient.h>

@interface ApiClient_IdCardIdentify : BaseApiClient
+ (instancetype) instance;
- (instancetype) init;

- (void) IdCardIdentify:(NSData *) body completionBlock:(void (^)(NSData * , NSURLResponse * , NSError *))completionBlock;
@end
