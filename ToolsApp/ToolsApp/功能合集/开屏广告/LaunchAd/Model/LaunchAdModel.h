//
//  LaunchAdModel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface LaunchAdModel : BaseModel

@property (nonatomic, copy) NSString *fileType;

@property (nonatomic, copy) NSString *fileUrl;

@property (nonatomic, copy) NSString *openUrl;

@property (nonatomic, assign) NSInteger showTime;

@property (nonatomic, copy) NSString *contentSize;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@end
