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
static CGFloat defualtW = 160.0f;
static CGFloat defualtH = 240.0f;

@interface PopMenuView()
@property (nonatomic, strong) PopMenuTableDataSource * tableViewDataSource;
@property (nonatomic, strong) PopMenuTableDelegate   * tableViewDelegate;

@property (nonatomic, assign) CGPoint topPoint; //三角形顶点
@end

@implementation PopMenuView

- (instancetype)initWithFrame:(CGRect)frame
                     menuRect:(struct MenuRect)menuRect
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action {
    
    if (self = [super initWithFrame:frame]) {
        self.topPoint = [self setupTopPoint:menuRect];
        self.action = action;
        
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
        
        self.tableView = [[UITableView alloc]initWithFrame:[self setupMenuFrame:menuRect] style:UITableViewStylePlain];
        self.tableView.dataSource = self.tableViewDataSource;
        self.tableView.delegate   = self.tableViewDelegate;
        self.tableView.layer.cornerRadius = 10.0f;
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

/**
 计算菜单的位置

 @param menuRect 箭头的位置 与 菜单的宽高
 @return 菜单的frame
 */
- (CGRect)setupMenuFrame:(struct MenuRect)menuRect {
    CGFloat W = menuRect.menuWidth;
    CGFloat H = menuRect.menuHeight;
    
    // 当给的宽度过大时使用默认的
    if (W > kScreen_width - MinEdge*2 || W < 60) {
        W = defualtW;
    }
    // 当给的高度过高时使用默认的
    if (H > kScreen_height - MinEdge*2 || H < 80) {
        H = defualtH;
    }
    
    CGFloat X = menuRect.pointX-W/2;
    CGFloat Y = menuRect.pointY+10;
    
    // 超出左边
    if (X < MinEdge) {
        X = MinEdge;
    }
    
    // 超出右边
    if (X+W > kScreen_width-MinEdge) {
        X = kScreen_width-MinEdge-W;
    }
    
    return (CGRect){X,Y,W,H};
}


/**
 计算顶点位置

 @param menuRect 原始参数
 @return 顶点位置
 */
- (CGPoint)setupTopPoint:(struct MenuRect)menuRect {
    CGFloat x = menuRect.pointX;
    CGFloat y = menuRect.pointY;
    
    if (x < MinEdge+18) {
        x = MinEdge+18;
    }
    if (x > kScreen_width-MinEdge-18) {
        x = kScreen_width-MinEdge-18;
    }
    
    return CGPointMake(x, y);
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
                         self.topPoint.x+10,
                         self.topPoint.y+10);//设置起点
    CGContextAddLineToPoint(context,
                            self.topPoint.x,
                            self.topPoint.y);
    
    CGContextAddLineToPoint(context,
                            self.topPoint.x-10,
                            self.topPoint.y+10);
    
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
