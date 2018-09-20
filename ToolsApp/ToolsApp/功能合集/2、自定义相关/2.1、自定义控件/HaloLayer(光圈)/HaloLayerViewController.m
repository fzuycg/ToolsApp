//
//  HaloLayerViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "HaloLayerViewController.h"
#import "CALayer+Halo.h"

@interface HaloLayerViewController ()

@end

@implementation HaloLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width-80, kScreen_width-80)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"touxiang.jpg"];
    
    imageView.layer.masksToBounds = YES;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 10;
    
    /**
     给控件四边设置阴影还可以设置两个背景View，然后设置不同方向的阴影，需要注意的是：
     - 设置阴影的view不能设置masksToBounds与clipsToBounds为YES，需用默认的，否则阴影无效果；
     - 解决上面的问题，一般设置一个背景View做阴影，背景view可设置为透明的；
     - 如果一个view设置为透明的，它上面又没有控件可显示出来的，阴影也是没有效果。
     */
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(40, kNavigation_HEIGHT+40, kScreen_width-80, kScreen_width-80)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor clearColor];
    [bgView.layer applyHaloLayerWithRadius:10 color:[UIColor colorWithRed:0.0 green:13.0/255.0 blue:36.0/255.0 alpha:0.5]];
    [bgView addSubview:imageView];
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
