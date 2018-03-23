//
//  PrintLabelViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/22.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "PrintLabelViewController.h"
#import "PrintLabel.h"

@interface PrintLabelViewController ()
@property (nonatomic, retain) PrintLabel *printLabel;

@end

@implementation PrintLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _printLabel = [[PrintLabel alloc] initWithFrame:CGRectMake(20, 120, kScreen_width-40, kScreen_height-240)];
    _printLabel.text = @"\n永和九年，岁在癸丑，暮春之初，会于会稽山阴之兰亭，修禊事也。\n群贤毕至，少长咸集。此地有崇山峻岭，茂林修竹，又有清流激湍，映带左右，引以为流觞曲水，列坐其次。\n虽无丝竹管弦之盛，一觞一咏，亦足以畅叙幽情。！";\
    _printLabel.numberOfLines = 0;
    _printLabel.backgroundColor = [UIColor clearColor];
    _printLabel.printColor = [UIColor redColor];
    [_printLabel sizeToFit];
    
    _printLabel.completeBlock = ^{
        
    };
    
    [self.view addSubview:_printLabel];
    [_printLabel startPrint];
}

@end
