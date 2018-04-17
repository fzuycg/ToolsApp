//
//  SideMenuViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MenuContentViewController.h"
#import "UIView+Parameter.h"

#define MAXLEFTSLIDEWIDTH (kScreen_width -100)
#define MAXSPEED 800
#define CGWS(weakSelf)  __weak __typeof(self) weakSelf = self;

@interface SideMenuViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIViewController *contentVC;
@property (nonatomic, strong) UIViewController *mainVC;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *pan1;   //开始的边缘平移手势
@property (nonatomic, strong) UIPanGestureRecognizer *pan2;             //滑动后的平移手势
@property (nonatomic, strong) UITapGestureRecognizer *tap;              //轻拍手势

@property (nonatomic, strong) UIView *maskView;                         //蒙版
@end

@implementation SideMenuViewController
+ (instancetype)initWithLeftVC:(UIViewController *)leftVC mainVC:(UIViewController *)mainVC{
    return  [[SideMenuViewController alloc]initWithLeftVC:leftVC mainVC:mainVC];
}

- (instancetype)initWithLeftVC:(UIViewController *)leftVC mainVC:(UIViewController *)mainVC {
    if (self = [super init]) {
        self.contentVC = leftVC;
        self.mainVC = mainVC;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.view addSubview:self.contentVC.view];
    [self.view addSubview:self.mainVC.view];
    [self addChildViewController:self.contentVC];
    [self addChildViewController:self.mainVC];
    
    [self.mainVC didMoveToParentViewController:self];
    [self.contentVC didMoveToParentViewController:self];
    
    self.contentVC.view.frame = self.view.bounds;
    self.mainVC.view.frame = self.view.bounds;
    
    UITabBarController *tabbarVc = (UITabBarController *)self.mainVC;
    [tabbarVc.tabBar addSubview:self.maskView];
    
    [self.mainVC.view addGestureRecognizer:self.pan1];
    [self.mainVC.view addGestureRecognizer:self.pan2];
    [self.mainVC.view addGestureRecognizer:self.tap];
    
//    MenuContentViewController *leftVc = (MenuContentViewController *)self.contentVC;
//    CGWS(weakSelf);
    
//    leftVc.typeClick = ^(NSString *type, __unsafe_unretained Class targetClass) {
//        if ([weakSelf.mainVc isKindOfClass:[LXTabbarController class]]) {
//
//            LXBasicController *vc = [targetClass new];
//            LXNavController *nav =  (LXNavController *)[tabbarVc LX_NavController];
//            vc.view.backgroundColor = LXRandomColor;
//            vc.title = type;
//            [nav pushViewController:vc animated:YES];
//            [weakSelf closeDrawer];//关闭抽屉
//        }
//    };
}

#pragma mark -
#pragma mark---手势处理
-(void)screenGesture:(UIPanGestureRecognizer *)pan{
    
    //移动的距离
    CGPoint point = [pan translationInView:pan.view];
    //移动的速度
    CGPoint verPoint =  [pan velocityInView:pan.view];
    
    
    
    self.mainVC.view.originX += point.x;
    
    //边界限定
    if (self.mainVC.view.originX >= MAXLEFTSLIDEWIDTH) {
        self.mainVC.view.originX = MAXLEFTSLIDEWIDTH;
    }
    if (self.mainVC.view.originX <= 0) {
        self.mainVC.view.originX = 0;
    }
    
    //蒙版的阴影限定
    self.maskView.alpha = self.mainVC.view.originX /MAXLEFTSLIDEWIDTH;
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        //判断手势
        if (pan == self.pan1) {
            
            
            if (verPoint.x > MAXSPEED) {
                
                [self showLeftVc];
                
            }else{
                
                if (self.mainVC.view.originX >= kScreen_width/2) {
                    
                    [self showLeftVc];
                    
                }else{
                    
                    [self hideLeftVc];
                    
                }
            }
        }else{
            
            if (verPoint.x < - MAXSPEED) {
                
                [self hideLeftVc];
            }else{
                
                if (self.mainVC.view.originX >= kScreen_width/2) {
                    
                    
                    [self showLeftVc];
                    
                }else{
                    
                    [self hideLeftVc];
                    
                }
            }
        }
        
        
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
}
#pragma mark - 点击手势
-(void)tapGesture:(UITapGestureRecognizer *)tap{
    
    [self hideLeftVc];
}

#pragma mark - 隐藏左侧视图
-(void)hideLeftVc{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.maskView.alpha = 0;
        self.mainVC.view.originX = 0;
        
    } completion:^(BOOL finished) {
        self.pan1.enabled = YES;
        self.pan2.enabled = NO;
        self.tap.enabled = NO;
    }];
}
#pragma mark - 显示左侧视图
-(void)showLeftVc{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.mainVC.view.originX = MAXLEFTSLIDEWIDTH;
        
    } completion:^(BOOL finished) {
        self.pan1.enabled = NO;
        self.pan2.enabled = YES;
        self.tap.enabled = YES;
    }];
}

#pragma mark - 关闭抽屉
-(void)closeDrawer{
    
    self.mainVC.view.originX = 0;
    self.maskView.alpha  = 0;
    self.pan1.enabled = YES;
    self.pan2.enabled = NO;
    self.tap.enabled = NO;
    
}
#pragma mark - 打开抽屉
-(void)openDrawer{
    [self showLeftVc];
}

#pragma mark - 懒加载
//- (MenuContentViewController *)contentVC {
//    if (!_contentVC) {
//        
//    }
//    return _contentVC;
//}
//
//- (UIViewController *)mainVC {
//    if (!_mainVC) {
//        
//    }
//    return _mainVC;
//}

- (UIScreenEdgePanGestureRecognizer *)pan1 {
    if (!_pan1) {
        _pan1 =[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenGesture:)];
        _pan1.edges = UIRectEdgeLeft;
        _pan1.delegate = self;
        _pan1.enabled = YES;
        
    }
    return _pan1;
}

- (UIPanGestureRecognizer *)pan2 {
    if (!_pan2) {
        _pan2 =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(screenGesture:)];
        _pan2.delegate = self;
        
        _pan2.enabled = NO;
        
    }
    return _pan2;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        _tap.numberOfTapsRequired = 1;
        
    }
    return _tap;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView =[[UIView alloc]initWithFrame:self.view.bounds];
        _maskView.originY = -self.mainVC.view.bounds.size.height +49; //蒙版添加到tabbar上
        _maskView.backgroundColor =[[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
        _maskView.alpha = 0;
    }
    return _maskView;
}

    
@end
