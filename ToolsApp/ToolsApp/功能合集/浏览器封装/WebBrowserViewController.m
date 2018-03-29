//
//  WebBrowserViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/27.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "WebBrowserViewController.h"
#import <WebKit/WebKit.h>
#import "HubMessageView.h"

static NSString *homeUrl = @"https://m.baidu.com";

@interface WebBrowserViewController () <WKNavigationDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIToolbar *toolbar;

@property (nonatomic, weak) UIBarButtonItem *item0;
@property (nonatomic, weak) UIBarButtonItem *item1;
@property (nonatomic, weak) UIBarButtonItem *item2;
@property (nonatomic, weak) UIBarButtonItem *item3;
@end

@implementation WebBrowserViewController

#pragma mark - 自定义API
+ (void)openUrl:(NSString *)urlString fromViewController:(UIViewController *)viewController
{
    WebBrowserViewController *vc =[[WebBrowserViewController alloc]init];
    vc.urlString =urlString;
    
    if (viewController.navigationController) {
        [viewController.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [viewController presentViewController:viewController animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    [self createWebView];
    [self createToolbarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.toolbarHidden = YES;
}

#pragma mark - UI & Action
- (void)createWebView {
    WKWebViewConfiguration *configuration = [self getWkWebViewConfiguration];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.navigationDelegate = self;
    webView.scrollView.delegate = self;
    webView.allowsBackForwardNavigationGestures = YES;  //允许手势右滑回退，默认是NO
    
    //添加监听
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];//进度
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];//是否可以前进
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];//是否可以回退
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];//标题
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlString ? _urlString : homeUrl]];
    [request setTimeoutInterval:10];
    _urlString = homeUrl;
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    self.webView = webView;
    [self.view addSubview:[self progressView]];
    [self.view bringSubviewToFront:_toolbar];
}

- (void)createToolbarItem {
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_toolbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    item0.enabled = NO;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_toolbar_forward"]style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
    item1.enabled = NO;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_toolbar_refresh_select"] style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_toolbar_safari_select"] style:UIBarButtonItemStylePlain target:self action:@selector(openSafari)];
    UIBarButtonItem *itemInterval = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[itemInterval,item0,itemInterval,item1,itemInterval,item2,itemInterval,item3,itemInterval];
    self.item3 = item3;
    self.item2 = item2;
    self.item1 = item1;
    self.item0 = item0;
}

- (void)goBack {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (void)goForward {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (void)refresh {
    [_webView reload];
}

- (void)openSafari {
    [[UIApplication sharedApplication] openURL:_webView.URL];
}

#pragma mark - 配置WKWebViewConfiguration
- (WKWebViewConfiguration *)getWkWebViewConfiguration
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    config.preferences = [WKPreferences new];
    config.preferences.minimumFontSize = 10;//最小的字体大小,默认是0
    config.preferences.javaScriptEnabled = YES; //是否支持JavaScript
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;//不通过用户交互，是否可以打开窗口
    
    return config;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, Navigation_HEIGHT, kScreen_width, 12)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.tintColor = [UIColor greenColor];
    }
    return _progressView;
}

// 计算wkWebView进度条(KVO)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
    if (object == self.webView && [keyPath isEqualToString:@"canGoBack"]) {
        BOOL canGoBack = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        self.item0.enabled = canGoBack;
        [self.item0 setImage:[UIImage imageNamed: canGoBack ? @"web_toolbar_back_select" : @"web_toolbar_back"]];
    }
    
    if (object == self.webView && [keyPath isEqualToString:@"canGoForward"]) {
        BOOL canGoForward = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        self.item1.enabled = canGoForward;
        [self.item1 setImage:[UIImage imageNamed: canGoForward ? @"web_toolbar_forward_select" : @"web_toolbar_forward"]];
    }
    
    if (object == self.webView && [keyPath isEqualToString:@"title"]) {
        self.title = [change objectForKey:NSKeyValueChangeNewKey];
    }
    
}

// 取消监听
- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - WKNavigationDelegate 页面加载过程
//开始加载时
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    DeLog(@"开始加载：%@",[NSDate date].description);
    self.title = @"加载中...";
}

//内容开始返回时
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    DeLog(@"开始返回：%@",[NSDate date].description);
}

//页面加载完成时
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    DeLog(@"加载完成：%@",[NSDate date].description);
    self.title = webView.title;
}

//页面加载失败时（不会调用？？？）
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error {
    if (error) {
        
        /*
         error.userInfo
         
         NSErrorFailingURLKey = "https://www.jianshu.com/";
         NSErrorFailingURLStringKey = "https://www.jianshu.com/";
         NSLocalizedDescription = "The Internet connection appears to be offline.";
         NSUnderlyingError = "Error Domain=kCFErrorDomainCFNetwork Code=-1009 \"(null)\" UserInfo={_kCFStreamErrorCodeKey=50, _kCFStreamErrorDomainKey=1}";
         "_WKRecoveryAttempterErrorKey" = "<WKReloadFrameErrorRecoveryAttempter: 0x170225d40>";
         "_kCFStreamErrorCodeKey" = 50;
         "_kCFStreamErrorDomainKey" = 1;
         */
        
        DeLog(@"%@",error.userInfo);
        if (error.userInfo[@"_kCFStreamErrorCodeKey"]) {
            if ([error.userInfo[@"_kCFStreamErrorCodeKey"] integerValue] ==50) {
                self.title =@"无网络";
            }
            else if ([error.userInfo[@"_kCFStreamErrorCodeKey"] integerValue] ==-2102) {
                self.title =@"超时";
            }
        }
        else
        {
            self.title =webView.title;
            
            NSURL *url2 =error.userInfo[@"NSErrorFailingURLKey"]; //注意这里返回的是个 NSURL 类型的 千万别以为是 NSString 的
            
            if (url2) [[UIApplication sharedApplication] openURL:url2];
            else      [HubMessageView showMessage:@"无法跳转"];
            
        }
        
        /*
         NSString *url = error.userInfo[@"NSErrorFailingURLKey"];
         
         //Note: 在iOS9中,如果你要想使用canOpenURL, 你必须添加URL schemes到Info.plist中的白名单, 否则一样跳转不了...
         BOOL didOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
         if (didOpen) {
         DLog(@"打开成功");
         }
         else
         {
         
         }
         */
    }
    else{
        self.title =@"加载失败!";
    }
}

//navigation发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation
      withError:(NSError *)error {
    
}

//web视图需要响应身份验证时调用。
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    [webView reload];
}


#pragma mark - 用户交互
//是否允许加载网页 在发送请求之前,决定是否跳转(点击跳转的时候,会执行两遍)
/*
 接下里就是交互部分了
 这里主要用到的是用户点击web页面的按钮，App拦截下来，在App端进行处理
 当用户点击页面的按钮，会走
 */

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *urlString =[[navigationAction.request URL] absoluteString];
    //注意对于url中的中文是无法解析的，需要进行url编码(指定编码类型为utf-8)
    //另外注意url解码使用stringByRemovingPercentEncoding方法
    urlString =[urlString stringByRemovingPercentEncoding];
    DeLog(@"urlString=%@",urlString);
    // 用://截取字符串
    NSArray *urlComps =[urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        //获取协议头
        NSString *protocolHead =[urlComps objectAtIndex:0];
        DeLog(@"协议头=%@",protocolHead);
    }
    decisionHandler(WKNavigationActionPolicyAllow);//拦截执行
}

// 在收到响应后，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //不加回调会 cash
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}
// 接收到服务器跳转请求之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

#pragma mark - WKScriptMessageHandler：必须实现的函数，是APP与js交互，提供从网页中收消息的回调方法
// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

#pragma mark - WKUIDelegate UI界面相关，原生控件支持，三种提示框：输入、确认、警告。首先将web提示框拦截然后再做处理。

//与JS的alert、confirm、prompt交互，我们希望用自己的原生界面，而不是JS的，就可以使用这个代理类来实现。

// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return nil;
}
/// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
        textField.placeholder =defaultText;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
/// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    DeLog(@"confirm message:%@", message);
    
}
/// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
