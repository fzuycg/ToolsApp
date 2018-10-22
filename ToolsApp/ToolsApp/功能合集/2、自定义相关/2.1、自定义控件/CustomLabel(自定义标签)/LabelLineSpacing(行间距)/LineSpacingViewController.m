//
//  LineSpacingViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LineSpacingViewController.h"
#import "NSString+Addition.h"
#import "SpacingCanSetLabel.h"

@interface LineSpacingViewController ()

@end

@implementation LineSpacingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}


- (void)createUI {
    NSString *string = @"苹果公司（Apple Inc. ）是美国一家高科技公司。由史蒂夫·乔布斯、斯蒂夫·沃兹尼亚克和罗·韦恩(Ron Wayne)等人于1976年4月1日创立，并命名为美国苹果电脑公司（Apple Computer Inc. ），2007年1月9日更名为苹果公司，总部位于加利福尼亚州的库比蒂诺。";
    UIFont *labelFont = [UIFont systemFontOfSize:14];
    CGFloat stringHeight = [string heightForContent:string withWidth:kScreen_width-40 withFont:labelFont];
    
    
    /// 默认的Label
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kNavigation_HEIGHT+20, kScreen_width-40, stringHeight)];
    myLabel.text = string;
    myLabel.font = labelFont;
    myLabel.backgroundColor = [UIColor greenColor];
    myLabel.textColor = [UIColor blackColor];
    myLabel.numberOfLines = 0;
    [self.view addSubview:myLabel];
    
    
    /// 可以设置间距的Label
    SpacingCanSetLabel *label = [[SpacingCanSetLabel alloc] initWithFrame:CGPointMake(20, kNavigation_HEIGHT+20+20+stringHeight) withWidth:kScreen_width-40 withContent:string withFont:labelFont withSpacing:10];
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
}


@end
