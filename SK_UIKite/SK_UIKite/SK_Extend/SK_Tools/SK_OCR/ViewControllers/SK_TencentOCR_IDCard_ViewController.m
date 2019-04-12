//
//  SK_TencentOCR_IDCard_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2018/5/14.
//  Copyright © 2018年 SKylin. All rights reserved.
//

#import "SK_TencentOCR_IDCard_ViewController.h"
#import "FixOrientation.h"

@interface SK_TencentOCR_IDCard_ViewController ()

@end

@implementation SK_TencentOCR_IDCard_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    UIImage * img = [UIImage imageNamed:@"idCard_1.jpeg"];
    
    [self post:@"http://recognition.image.myqcloud.com/ocr/idcard"
    parameters:@{@"appid":@"1251144773",//项目ID
                 @"bucket":@"test",     //图片空间
                 @"card_type":@"0"      //0 为身份证有照片的一面，1 为身份证有国徽的一面；如果未指定，默认为0。
                 }
      imageArr:@[img]
       nameArr:@[@"image[0]"]
   fileNameArr:@[@"image"]
      mimeType:@"image/jpeg"
       success:^(NSURLSessionDataTask *operation, id responseObject, BOOL isOK) {
           
       } failure:^(NSURLSessionDataTask *operation, NSError *error) {
           
       }];
    
}
-(void)post:(NSString *)requestHeader
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    SK_HTTPClient *manager = [SK_HTTPClient manager];
    //修改网络不稳定，请重新刷新时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    [manager POST:requestHeader
       parameters:parameters
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             BOOL isOK = [responseObject[AF_KEY] integerValue] == AF_STATUS_Post;
             success(task,responseObject,isOK);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         }];
}

-(void)post:(NSString *)requestHeader parameters:(id)parameters imageArr:(NSArray *)imageArr nameArr:(NSArray *)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType success:(void (^)(NSURLSessionDataTask *operation, id responseObject, BOOL isOK))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    SK_HTTPClient *manager = [SK_HTTPClient manager];
    //    修改网络不稳定，请重新刷新时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects: @"text/plain",@"text/html", @"application/json",@"text/json",@"text/javascript",nil];
    
    
    //头文件
    
    //Host
    [manager.requestSerializer setValue:@"recognition.image.myqcloud.com" forHTTPHeaderField:@"host"];
    //整个请求包体内容的总长度，单位：字节（Byte）
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"content-length"];
    /**
     *根据不同接口选择：
     1. 使用图片 url，选择 application/json；
     2. 使用图片 image，选择 multipart/form-data。
     */
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"content-type"];
    [manager.requestSerializer setValue:@"9OLzFZMFeAvI148JZxPvnltmUf9hPTEyNTExNDQ3NzMmYj10ZW5jZW50eXVuJms9QUtJRGpPMVVteE93aElrMTk4VHdHV241RUhDd2d5Q0lEaEhnJnQ9MTUyNTc3NDY4OCZlPTE1MjczMDA0NjI4OTUmcj0xOTkwMjY2ODI=" forHTTPHeaderField:@"authorization"];
    
    
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
