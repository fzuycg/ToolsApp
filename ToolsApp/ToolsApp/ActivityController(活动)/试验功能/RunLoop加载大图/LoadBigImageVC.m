//
//  LoadBigImageVC.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/10/9.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "LoadBigImageVC.h"

static NSString * IDENTIFIER = @"IDENTIFIER";//identifier
static CGFloat CELL_HEIGHT = 140.f;

@interface LoadBigImageVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LoadBigImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册Cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

- (void)loadView {
    self.view = [UIView new];
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //干掉contentView上面的子控件!! 节约内存!!
    for (NSInteger i = 1; i <= 5; i++) {
        //干掉contentView 上面的所有子控件!!
        [[cell.contentView viewWithTag:i] removeFromSuperview];
    }
    
    //添加文字
    [LoadBigImageVC addLabel:cell indexPath:indexPath];
    //添加图片
    [LoadBigImageVC addImageView1:cell];
    [LoadBigImageVC addImageView2:cell];
    [LoadBigImageVC addImageView3:cell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

#pragma mark - Private
+ (void)addLabel:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, kScreen_width-20, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"这是第%zd行。。。", indexPath.row];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.tag = 4;
    [cell.contentView addSubview:label];
}

+ (void)addImageView1:(UITableViewCell *)cell {
    //第一张
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, (kScreen_width-40)/3, 100)];
    imageView.tag = 1;
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"big_image_1" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path1];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imageView];
    } completion:nil];
}

+ (void)addImageView2:(UITableViewCell *)cell {
    //第二张
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20+(kScreen_width-40)/3, 10, (kScreen_width-40)/3, 100)];
    imageView1.tag = 2;
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"big_image_2" ofType:@"jpg"];
    UIImage *image1 = [UIImage imageWithContentsOfFile:path1];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView1.image = image1;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imageView1];
    } completion:nil];
}

+ (void)addImageView3:(UITableViewCell *)cell {
    //第三张
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_width-10-(kScreen_width-40)/3, 10, (kScreen_width-40)/3, 100)];
    imageView2.tag = 3;
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"big_image_3" ofType:@"jpg"];
    UIImage *image2 = [UIImage imageWithContentsOfFile:path1];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = image2;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imageView2];
    } completion:nil];
}


@end
