//
//  WaterFallDataModel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BaseModel.h"

@interface WaterFallDataModel : BaseModel

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *price;

@end
