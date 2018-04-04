//
//  CityModel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/4.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSMutableArray *areaListArray;

- (instancetype)initWithDictionary:(NSDictionary *)dic province:(NSString *)province;

@end


@interface CityArrayModel : NSObject
@property (nonatomic, strong) NSMutableArray<CityModel*>* citiesArray;

- (instancetype)initWithCity:(NSArray *)cityArray province:(NSString *)province;

@end
