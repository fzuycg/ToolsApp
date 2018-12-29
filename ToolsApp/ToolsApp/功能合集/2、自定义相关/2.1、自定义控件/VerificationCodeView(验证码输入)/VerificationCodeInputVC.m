//
//  VerificationCodeInputVC.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/10/22.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "VerificationCodeInputVC.h"
#import "CodeTextView/CodeTextView.h"

@interface VerificationCodeInputVC ()
@property (nonatomic, weak) CodeTextView *codeTextView;

@end

@implementation VerificationCodeInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
    CodeTextView *codeTextView = [[CodeTextView alloc] initWithCount:6 margin:30];
    codeTextView.frame = CGRectMake(20, 100, kScreen_width-40, 80);
    [self.view addSubview:codeTextView];
    self.codeTextView = codeTextView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)tap {
    [self.codeTextView endEditing:YES];
}

@end
