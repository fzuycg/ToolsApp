//
//  LaunchAdModel.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LaunchAdModel.h"

@implementation LaunchAdModel

-(void)setContentSize:(NSString *)contentSize {
    self.contentSize = contentSize;
    self.width = [[[contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
    self.height = [[[contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}

@end
