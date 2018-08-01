//
//  MoreAppModel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreAppModel : NSObject
@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSArray *functionArray;

//处理过后的数据
@property (nonatomic, strong) NSMutableArray *modelArray;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
