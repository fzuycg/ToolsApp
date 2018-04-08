//
//  YCGCityViewController.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCGCityViewControllerDelegate <NSObject>

- (void)cityName:(NSString *)name;

@end

@interface YCGCityViewController : UIViewController
@property (nonatomic, weak) id<YCGCityViewControllerDelegate> delegate;

@end
