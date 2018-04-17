//
//  PopMenuView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "PopMenuView.h"
#import "PopMenuTableViewCell.h"
#import "PopMenuTableDelegate.h"
#import "PopMenuTableDataSource.h"
#import "PopMenuModel.h"
#import "PopMenuManager.h"

#define WBNUMBER 6

static CGFloat MinEdge = 12.0f;

@interface PopMenuView()
@property (nonatomic, strong) PopMenuTableDataSource * tableViewDataSource;
@property (nonatomic, strong) PopMenuTableDelegate   * tableViewDelegate;
@end

@implementation PopMenuView

- (instancetype)initWithFrame:(CGRect)frame
                     menuFrame:(CGRect)menuFrame
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action {
    
    if (self = [super initWithFrame:frame]) {
        self.menuFrame = menuFrame;
        self.menuItem = items;
        self.action = [action copy];
        
        self.tableViewDataSource = [[PopMenuTableDataSource alloc]initWithItems:items cellClass:[PopMenuTableViewCell class] configureCellBlock:^(PopMenuTableViewCell *cell, PopMenuModel *model) {
            PopMenuTableViewCell * tableViewCell = (PopMenuTableViewCell *)cell;
            tableViewCell.textLabel.text = model.title;
            tableViewCell.imageView.image = [UIImage imageNamed:model.image];
        }];
        self.tableViewDelegate = [[PopMenuTableDelegate alloc]initWithDidSelectRowAtIndexPath:^(NSInteger indexRow) {
            if (self.action) {
                self.action(indexRow);
            }
        }];
        
        
        self.tableView = [[UITableView alloc]initWithFrame:[self setupMenuFrame] style:UITableViewStylePlain];
        self.tableView.dataSource = self.tableViewDataSource;
        self.tableView.delegate   = self.tableViewDelegate;
        self.tableView.layer.cornerRadius = 10.0f;
        self.tableView.layer.anchorPoint = CGPointMake(1.0, 0);
        self.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.tableView.rowHeight = 40;
        [self addSubview:self.tableView];
        
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
    }
    return self;
}

- (CGRect)setupMenuFrame {
    CGFloat menuX = self.menuFrame.origin.x;
    CGFloat menuY = self.menuFrame.origin.y;
    CGFloat width = 160;
    CGFloat heigh = 40 * WBNUMBER;
    return (CGRect){menuX,menuY,width,heigh};
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect {
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context,
                         self.menuFrame.origin.x+self.menuFrame.size.width/2+10,
                         self.menuFrame.origin.y);//设置起点
    CGContextAddLineToPoint(context,
                            self.menuFrame.origin.x+self.menuFrame.size.width/2,
                            self.menuFrame.origin.y-10);
    
    CGContextAddLineToPoint(context,
                            self.menuFrame.origin.x+self.menuFrame.size.width/2-10,
                            self.menuFrame.origin.y);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor whiteColor] setFill];  //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[PopMenuManager sharedInstance] hideMenu];
}

@end
