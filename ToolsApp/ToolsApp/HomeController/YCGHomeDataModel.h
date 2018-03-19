//
//  YCGHomeDataModel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCGBaseModel.h"

@interface YCGHomeDataModel : YCGBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *otherInfo;

@end
