//
//  MoreAppModel.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MoreAppModel.h"
#import "BoxFunctionModel.h"

@implementation MoreAppModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.sectionTitle = dict[@"sectionTitle"];
        self.functionArray = dict[@"functionArray"];
    }
    return  self;
}

- (void)setFunctionArray:(NSArray *)functionArray {
    _functionArray = functionArray;
    for (NSDictionary *dict in functionArray) {
        BoxFunctionModel *model = [[BoxFunctionModel alloc] initWithDict:dict];
        [self.modelArray addObject:model];
    }
}

#pragma mark - lazy
- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
