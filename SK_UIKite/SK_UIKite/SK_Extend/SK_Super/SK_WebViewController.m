//
//  SK_WebViewController.m
//  XinFeng
//
//  Created by S&King on 2019/10/12.
//  Copyright © 2019 石磊. All rights reserved.
//

#import "SK_WebViewController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

@interface SK_WebViewController ()<WKNavigationDelegate, WKUIDelegate>

/**
 *  Get/set the request
 */
@property (nonatomic,strong) NSMutableURLRequest *urlRequest;
@property (nonatomic, strong) UIProgressView *progressView;//进度条
@end

@implementation SK_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional loadURL after loading the view.
     
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

#pragma mark - Initialize
- (id)initWithURL:(NSURL *)url{
    self = [super init];
    if (self) {
        _url = [self cleanURL:url];
        [self loadURL];
    }
    return self;
}
- (id)initWithURLString:(NSString *)urlString{
    self = [super init];
    if (self) {
        _url = [self cleanURL:[NSURL URLWithString:urlString]];
        [self loadURL];
    }
    return self;
}
#pragma mark - set&get
- (void)setUrl:(NSURL *)url{
    if (self.url == url) {
        return;
    }
    _url = [self cleanURL:url];
    [self loadURL];
}
- (void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    _url = [self cleanURL:[NSURL URLWithString:urlString]];
    [self loadURL];
}
- (NSURL *)cleanURL:(NSURL *)url{
    //If no URL scheme was supplied, defer back to HTTP.
    if (url.scheme.length == 0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[url absoluteString]]];
    }
    return url;
}
#pragma mark - 懒加载
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView.scrollView addHeaderWithTarget:self action:@selector(reloadUrl)];
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];

        //
        _webView.frame = CGRectMake(0, Height_StatusBar, WIDTH_IPHONE, NOHAVE_TABBAR_HEIGHT+Height_NavigationBar-Height_StatusBar);

        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
        
        //添加KVO监听者，监听加载进度和标题
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:0 context:nil];
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
        [self.view addSubview:_webView];
    }
    return _webView;
}
-(NSMutableURLRequest *)urlRequest
{
    if (!_urlRequest) {
        _urlRequest = [[NSMutableURLRequest alloc] init];
    }
    return _urlRequest;
}
/// 进度条
-(UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView= [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame=CGRectMake(0,0,WIDTH_IPHONE,2);

        [_progressView setTrackTintColor:[UIColor colorWithHexString:[LEETheme getJsonValueWithTag:[LEETheme currentThemeTag] Identifier:Color_FFFFFF_FFFFFF]]];

        _progressView.progressTintColor=  self.loadingBarTintColor;
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

#pragma mark 刷新请求
-(void)loadURL
{
    self.urlRequest = [NSMutableURLRequest requestWithURL:self.url];
    [self.webView loadRequest:self.urlRequest];
}
-(void)reloadUrl
{
    [self.webView reload];
    [self.webView.scrollView headerEndRefreshing];
}
//重写返回方法
-(void)GoToBack
{
    if (self.webView.canGoBack && !self.isGoBackInstant) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

    NSLog(@"%s",__FUNCTION__);
    
    //开始夹在进度条
    self.progressView.hidden = NO;
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //根据请求链接判断是否跳转
    if ([navigationAction.request.URL.host.lowercaseString hasPrefix:@"http://gujia.toback.ios/"]) {
        [self.navigationController popViewControllerAnimated:YES];
        // 不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel);
        
        return;
    }
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - KVO
//kvo 监听进度
-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object  change:(NSDictionary *)change context:(void*)context {

    if([keyPath isEqualToString:@"estimatedProgress"] ) {

        [self.progressView setAlpha:1.0f];

        BOOL animated =self.webView.estimatedProgress>self.progressView.progress;

        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];

        if(self.webView.estimatedProgress>=1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            }completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else if([keyPath isEqualToString:@"title"]) {//网页title
            if(object ==self.webView) {
                if (STRING_IS_NOT_EMPTY(_titleStr)) {
                    self.navigationItem.title=_titleStr;//设置标题为自定义内容
                }else{
                    self.navigationItem.title=self.webView.title;//设置为H5的标题
                }
            }else{
                [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            }
    }
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
