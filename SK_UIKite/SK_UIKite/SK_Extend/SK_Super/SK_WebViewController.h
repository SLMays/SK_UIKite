//
//  SK_WebViewController.h
//  XinFeng
//
//  Created by S&King on 2019/10/12.
//  Copyright © 2019 石磊. All rights reserved.
//

#import "SK_ViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SK_WebViewController : SK_ViewController


/**
 *  WKWebView
 */
@property (nonatomic, nonnull, strong)WKWebView * webView;

/**
 *  url string
 */
@property (nonatomic, nonnull, strong) NSString *urlString;

/**
 *  website url
 */
@property (nonatomic,strong) NSURL * _Nullable url;

/**
 *  标题
 */
@property (nonatomic, nonnull, copy) NSString *titleStr;


///是否立即返回
@property (nonatomic, assign) BOOL  isGoBackInstant;
/**
 * The tint colour of the page loading progress bar.
 * If not set on iOS 7 and above, the loading bar will defer to the app's global UIView tint color.
 * If not set on iOS 6 or below, it will default to the standard system blue tint color.
 *
 * Default value is nil.
 */
@property (nonatomic,copy)      UIColor * _Nullable loadingBarTintColor;


/**
 *  Initializes object with url
 *
 *  @param url webpage url
 *
 *  @return SK_WebViewController object
 */
- (id _Nonnull )initWithURL:(NSURL *_Nullable)url;


/**
 *  Initializes object with url string
 *
 *  @param urlString webpage url string
 *
 *  @return SK_WebViewController object
 */

- (id _Nullable )initWithURLString:(NSString *_Nullable)urlString;

@end

NS_ASSUME_NONNULL_END
