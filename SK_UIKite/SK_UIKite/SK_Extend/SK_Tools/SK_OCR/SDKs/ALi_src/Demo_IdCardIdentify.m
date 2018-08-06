
//
//  Created by  fred on 2016/10/26.
//  Copyright © 2016 Alibaba. All rights reserved.
//

#import "Demo_IdCardIdentify.h"

/**
 *  API invoke example
 */
@implementation Demo_IdCardIdentify

+ (void) init{

    /**
     * HTTPS request use DO_NOT_VERIFY mode only for demo
     * Suggest verify for security
     */
    BOOL (^pVerifyCerts)(NSURLAuthenticationChallenge *x);
    pVerifyCerts = ^(NSURLAuthenticationChallenge* certHandler)
    {
        
        //验证实现代码
        
        return YES;
    };
    [ApiClient_IdCardIdentify instance].verifyCert = pVerifyCerts;

}

+ (void) IdCardIdentifyTest:(NSInteger)side {
    
    NSString * imgName = side==0?@"idCard_1.jpeg":@"idCard_1.jpeg";
    
    UIImage * image = [UIImage imageNamed:imgName];
    NSData *data =UIImageJPEGRepresentation(image,0.5);
    NSString *pictureDataString=[data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];

    NSString *bodys = [NSString stringWithFormat:@"{\"image\":\"%@\",\"configure\":\"{\\\"side\\\":\\\"%@\\\"}\"}",pictureDataString,side==0?@"face":@"back"];//#身份证正反面类型:face/back
    
    [[ApiClient_IdCardIdentify instance] IdCardIdentify: [bodys dataUsingEncoding:NSUTF8StringEncoding] completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    //打印应答对象
                    NSLog(@"Response object: %@" , response);
                    NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];

                    //打印应答中的body
                    NSLog(@"Response body: %@" , bodyString);
        
        
    }];

}
@end
