//
//  ProvinceModel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/4.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface ProvinceModel : NSObject
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) CityArrayModel *citiesListModel;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
