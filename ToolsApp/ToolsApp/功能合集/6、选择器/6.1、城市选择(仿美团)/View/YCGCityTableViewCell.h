//
//  YCGCityTableViewCell.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

//选择定位城市、历史访问城市和热门城市的通知（用来修改“当前：”后面的城市名称）
extern NSString * const YCGCityTableViewCellDidChangeCityNotification;

@interface YCGCityTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *cityNameArray;
@end
