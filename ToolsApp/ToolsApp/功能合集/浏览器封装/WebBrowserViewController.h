//
//  WebBrowserViewController.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/27.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BaseViewController.h"

@interface WebBrowserViewController : BaseViewController

+ (void)openUrl:(NSString *)urlString fromViewController:(UIViewController *)viewController;

@end
