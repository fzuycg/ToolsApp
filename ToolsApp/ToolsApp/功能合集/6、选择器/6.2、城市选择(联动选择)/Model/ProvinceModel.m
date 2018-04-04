//
//  ProvinceModel.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/4.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _province = [dic objectForKey:@"p"];
        _citiesListModel = [[CityArrayModel alloc]initWithCity:[dic objectForKey:@"c"] province:_province];
    }
    return self;
}

@end
