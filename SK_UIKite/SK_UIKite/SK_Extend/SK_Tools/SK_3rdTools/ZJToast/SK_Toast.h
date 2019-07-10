//
//  SK_Toast.h
//  SK_Toast
//
//  Created by Choi on 2017/4/9.
//  Copyright © 2017年 CSK_. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SK_TOAST_SHOW_INTERVAL 3.5

#define SK_TOAST_SHOW_TOP(msg) [[SK_Toast sharedInstance] makeToast:msg duration:SK_TOAST_SHOW_INTERVAL position:@"top"];

#define SK_TOAST_SHOW_CENTER(msg) [[SK_Toast sharedInstance] makeToast:msg duration:SK_TOAST_SHOW_INTERVAL position:@"center"];

#define SK_TOAST_SHOW_BOTTOM(msg) [[SK_Toast sharedInstance] makeToast:msg duration:SK_TOAST_SHOW_INTERVAL position:@"bottom"];

/** 吐司提示 */
@interface SK_Toast : UIView

+ (SK_Toast *)sharedInstance;

- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position;

@end
