//
//  AppDelegate.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "YCGGuidePageView.h"
#import "LaunchAdManager.h"
#import "HookLogManager.h"
#import "ScreenshotViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) TabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.tabBarController = [[TabBarController alloc] init];
    self.window.rootViewController = self.tabBarController;
    // 设置这个窗口有主窗口并显示
    [self.window makeKeyAndVisible];
    
    //引导页，一定要在 [self.window makeKeyAndVisible] 后面调用
    if ([self isFirstLaunch]) {
        YCGGuidePageView *guidePageView = [[YCGGuidePageView alloc] initGuideViewWithImages:@[@"guide_01.jpg",@"guide_02.jpg",@"guide_03.jpg",@"guide_04.jpg"]];
        guidePageView.isShowPageView = YES;
        guidePageView.isScrollOut = NO;
        guidePageView.currentColor = [UIColor redColor];
        [_window addSubview:guidePageView];
    }else{
//        [[LaunchAdManager shareManager] loadData];
    }
    
    //给 launch 添加动画
//    [self addLaunchAnimation];
    
//#if !(TARGET_IPHONE_SIMULATOR)//真机
//    //连接xcode时可以从监视器中看日志 没连接时Log日志会输出到文件中，
//    [self redirectNSLogToDocumentFolder];
//    NSLog(@"真机");
//#else//模拟器
//    NSLog(@"模拟器");
//#endif
    
    [[HookLogManager sharedInstance] startHookLog];
    
    [self initShortcutItems];
    
    return YES;
}

#pragma mark - 判断app是否是首次启动或者是更新后首次启动
#define LAST_RUN_VERSION_KEY @"last_run_version_of_application"
- (BOOL)isFirstLaunch{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
    }
    else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
    }
    return NO;
}

#pragma mark - 添加启动动画(此方法要在rootviewcontroller之后添加)
- (void)addLaunchAnimation
{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    //UIView *launchView = viewController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    
    //viewController.view.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:viewController.view];
    [self.window bringSubviewToFront:viewController.view];
    
    //添加广告图
    /*
     UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDHT, 300)];
     NSString *str = @"http://upload-images.jianshu.io/upload_images/746057-6e83c64b3e1ec4d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
     [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default1.jpg"]];
     [viewController.view addSubview:imageV];
     */
    [UIView animateWithDuration:0.6f delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        viewController.view.alpha = 0.0f;
        viewController.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        [viewController.view removeFromSuperview];
    }];
    
}

#pragma mark - 设置屏幕转向
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 3D Touch菜单进入
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
    if ([shortcutItem.type isEqualToString:@"com.cgy.fintech.RichScan"]) {
        ScreenshotViewController *toVC = [[ScreenshotViewController alloc] init];
        UIViewController *currentVC = [self currentViewController];
        [currentVC.navigationController pushViewController:toVC animated:YES];
    }
}

- (void)initShortcutItems {
    
    if ([UIApplication sharedApplication].shortcutItems.count >= 2)
        return;
    
    NSMutableArray *arrShortcutItem = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
    
    UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.cgy.fintech.propertyQuery" localizedTitle:@"资产查询" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    [arrShortcutItem addObject:shoreItem1];
    
    UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"com.cgy.fintech.RichScan" localizedTitle:@"扫一扫" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"saoyisao"] userInfo:nil];
    [arrShortcutItem addObject:shoreItem2];
    
    [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
    
}

//获取手机当前显示的ViewController
- (UIViewController *)currentViewController {
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

@end
