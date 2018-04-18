//
//  PopMenuManager.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "PopMenuManager.h"

@interface PopMenuManager()
@property (nonatomic, strong) PopMenuView * popMenuView;
@end

@implementation PopMenuManager

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)showPopMenuSelecteWithFrame:(struct MenuRect)menuRect
                                item:(NSArray *)item
                              action:(void (^)(NSInteger))action {
    __weak __typeof(&*self)weakSelf = self;
    if (self.popMenuView != nil) {
        [weakSelf hideMenu];
    }
    UIWindow * window = [[[UIApplication sharedApplication] windows] firstObject];
    self.popMenuView = [[PopMenuView alloc]initWithFrame:window.bounds
                                                 menuRect:menuRect
                                                     items:item
                                                    action:^(NSInteger index) {
                                                        action(index);
                                                        [weakSelf hideMenu];
                                                    }];
    self.popMenuView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    [window addSubview:self.popMenuView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.popMenuView.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    
}

- (void)hideMenu {
    [UIView animateWithDuration:0.15 animations:^{
        self.popMenuView.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [self.popMenuView.tableView removeFromSuperview];
        [self.popMenuView removeFromSuperview];
        self.popMenuView.tableView = nil;
        self.popMenuView = nil;
    }];
}

@end
