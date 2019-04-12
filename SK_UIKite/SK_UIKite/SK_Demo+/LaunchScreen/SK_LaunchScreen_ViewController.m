//
//  SK_LaunchScreen_ViewController.m
//  SK_UIKite
//
//  Created by Skylin on 2019/4/9.
//  Copyright © 2019 SKylin. All rights reserved.
//

#import "SK_LaunchScreen_ViewController.h"

@interface SK_LaunchScreen_ViewController ()

@end

@implementation SK_LaunchScreen_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self refLaunchScreenImg];
}

-(void)refLaunchScreenImg
{
    NSString * url = @"http://39.106.201.72:8100/advert/isUpdate";
    NSString * version = GetUserDefaults(K_UserDefaults_LaunchScreenVersion);
    version = STRING_IS_NOT_EMPTY(version)?version:@"";
    NSDictionary * dic = @{@"version":version};
    
    [SK_HTTPClient post:url
             parameters:dic
                success:^(NSURLSessionDataTask *operation, id responseObject, BOOL isOK) {
                    
                    if (isOK) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            NSString * url = [NSString stringWithFormat:@"http://image.lovestockhome.com%@",responseObject[@"data"][@"image"]];
                            NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                            if (imgData) {
                                SaveUserDefaults(@"LaunchScreenImgData", imgData);
                            }
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [_launchScreenImgView setImage:[UIImage imageWithData:GetUserDefaults(@"LaunchScreenImgData")]];
                            });
                        });
                    }else{
                        
                    }
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    NSLog(@"%@",error);
                    
                }];
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
