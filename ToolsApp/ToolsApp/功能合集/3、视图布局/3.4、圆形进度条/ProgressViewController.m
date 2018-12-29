//
//  ProgressViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/11/7.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "ProgressViewController.h"
#import "CircleProgressView.h"

@interface ProgressViewController ()

@property (nonatomic, strong) CircleProgressView *progressView;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CircleProgressView *progressView = [[CircleProgressView alloc] initWithFrame:CGRectMake(0, kNavigation_HEIGHT, kScreen_width, 300)];
    progressView.progress = 0.5;
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int count = 0;
    self.progressView.progress = (count%5)/4.0;
    count++;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
