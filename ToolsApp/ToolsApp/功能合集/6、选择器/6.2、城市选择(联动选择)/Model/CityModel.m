//
//  CityModel.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/4.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (instancetype)initWithDictionary:(NSDictionary *)dic province:(NSString *)province {
    self = [super init];
    if (self) {
        _areaListArray = [NSMutableArray array];
        if (province.length > 0) {
            _city = province;
        }else{
            _city = [dic objectForKey:@"n"];
            NSArray *array = [dic objectForKey:@"a"];
            for (NSDictionary *dict in array) {
                [_areaListArray addObject:[dict objectForKey:@"s"]];
            }
        }
    }
    return self;
}

- (void)setCityArray:(NSArray *)cityArray{
    for (NSDictionary *dict in cityArray) {
        [_areaListArray addObject:[dict objectForKey:@"n"]];
    }
}

@end

@implementation CityArrayModel

- (instancetype)initWithCity:(NSArray *)cityArray province:(NSString *)province {
    self = [super init];
    if (self) {
        _citiesArray = [NSMutableArray array];
        CityModel *cityModel;
        for (NSDictionary *cityDic in cityArray) {
            if (![cityDic objectForKey:@"a"]) {
                cityModel = [[CityModel alloc]initWithDictionary:cityDic province:province];
                cityModel.cityArray = cityArray;
                [_citiesArray addObject:cityModel];
                break;
            }else{
                cityModel = [[CityModel alloc]initWithDictionary:cityDic province:@""];
                [_citiesArray addObject:cityModel];
            }
            
        }
    }
    return self;
}

@end
