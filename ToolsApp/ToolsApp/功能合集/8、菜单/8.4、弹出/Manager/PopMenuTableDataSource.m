//
//  PopMenuTableDataSource.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "PopMenuTableDataSource.h"
#import "PopMenuTableViewCell.h"

@interface PopMenuTableDataSource()

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, strong) Class Cellclass;
@property (nonatomic, strong) NSArray * modelArray;

@end

@implementation PopMenuTableDataSource

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)anItems
                     cellClass:(Class)cellClass
            configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    if (self = [super init]) {
        self.modelArray = anItems;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.Cellclass = cellClass;
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopMenuTableViewCell * cell = [[self.Cellclass class]cellAllocWithTableView:tableView];
    self.configureCellBlock(cell,self.modelArray[indexPath.row]);
    return cell;
}

@end
