//
//  BoxFunctionModel.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/26.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BoxFunctionModel.h"

@implementation BoxFunctionModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.functionId = [dict[@"functionId"] integerValue];
        self.title = dict[@"title"];
        self.imageUrl = dict[@"imageUrl"];
    }
    return  self;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.title]];
}

@end
