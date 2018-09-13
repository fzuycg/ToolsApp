//
//  HubMessageView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/28.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "HubMessageView.h"

@implementation HubMessageView

#define font_size 14

+(void)showMessage:(NSString *)message withView:(UIView *)view
{
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor yellowColor];
    showview.frame = CGRectZero;
    showview.layer.cornerRadius = 5.0f;
//    showview.layer.masksToBounds = YES;
    
    //设置阴影（不起作用是因为：showview.layer.masksToBounds = YES）
    showview.layer.shadowColor = [UIColor blackColor].CGColor;
    showview.layer.shadowOpacity = 0.8f;
    showview.layer.shadowRadius = 4.f;
    showview.layer.shadowOffset = CGSizeMake(4,4);
    
    [view addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:font_size]};
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(290, 9000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    label.frame = CGRectMake(10, 5, labelSize.width, labelSize.height);
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:font_size];
    [showview addSubview:label];
    //提示框的位置
    showview.frame = CGRectMake(0, 0, labelSize.width+21*2, labelSize.height+21*2);
    showview.center =CGPointMake(kScreen_width/2, kScreen_height/2);
    label.center = CGPointMake(showview.frame.size.width/2, showview.frame.size.height/2);
    [UIView animateWithDuration:0.7 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        showview.alpha = 0;
        
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
        
    }];
    
}

+(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [HubMessageView showMessage:message withView:window];
}
@end
