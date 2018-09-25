//
//  ScreenshotViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/25.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "ScreenshotViewController.h"

@interface ScreenshotViewController ()
/// 添加裁剪显示的图片
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ScreenshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewController];
}

-(void)setupViewController {
    /// 随便一张默认的占位图（同学们不需要的话可以直接删除）
    UIImageView *testImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang.jpg"]];
    testImageView.frame = CGRectMake(0, kNavigation_HEIGHT, kScreen_width, kScreen_height-kNavigation_HEIGHT);
    [self.view addSubview:testImageView];
    
    /// 添加裁剪显示的图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kScreen_height-10-kScreen_height/3-(kIs_iPhoneX ? 34 : 0), kScreen_width/3, kScreen_height/3)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.imageView];
    self.imageView.hidden = YES;
    
    /// 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidTakeScreenshot) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 截屏通知
-(void)userDidTakeScreenshot {
    self.imageView.image = [self takeScreenshot];
    self.imageView.hidden = NO;
}

#pragma mark - 截取当前屏幕
-(UIImage *)takeScreenshot {
    CGSize imageSize = CGSizeZero;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = screenSize;
    } else {
        imageSize = CGSizeMake(screenSize.height, screenSize.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, window.center.x, window.center.y);
            CGContextConcatCTM(context, window.transform);
            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
            
            if (orientation == UIInterfaceOrientationLandscapeLeft) {
                CGContextRotateCTM(context, M_PI_4);
                CGContextTranslateCTM(context, 0, -imageSize.width);
            } else if (orientation == UIInterfaceOrientationLandscapeRight) {
                CGContextRotateCTM(context, - M_PI_2);
                CGContextTranslateCTM(context, -imageSize.height, 0);
            } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
                CGContextRotateCTM(context, M_PI);
                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
            }
            
            if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
                [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
            } else {
                [window.layer renderInContext:context];
            }
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
