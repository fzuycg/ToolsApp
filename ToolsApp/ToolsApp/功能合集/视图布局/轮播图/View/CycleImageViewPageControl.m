//
//  CycleImageViewPageControl.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CycleImageViewPageControl.h"

#define dotW     20
#define dotH     3
#define magrin   5

@implementation CycleImageViewPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marginX = dotW + magrin;
    CGFloat newW = (self.subviews.count - 1) * marginX;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        
        dot.layer.masksToBounds = YES;
        dot.layer.cornerRadius = dotH/2;
    }
}

@end
