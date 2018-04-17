//
//  PanBoardView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/12.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

typedef void(^OKBtnClick)(void);

@interface PanBoardView : GLKView

@property (nonatomic, copy) OKBtnClick okBtnClick;

@end
