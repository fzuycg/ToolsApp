//
//  BoxFunctionModel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/26.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxFunctionModel : NSObject

@property (nonatomic, assign) NSInteger functionId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) BOOL isSelectStatus;

//处理后的
@property (nonatomic, strong) UIImage *image;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
