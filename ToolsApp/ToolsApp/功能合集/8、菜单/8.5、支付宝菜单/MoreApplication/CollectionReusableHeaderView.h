//
//  CollectionReusableHeaderView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableHeaderView : UICollectionReusableView

@property (nonatomic, strong) NSString *sectionTitleText;
@property (nonatomic, assign) BOOL isFirstSection;

@end
