//
//  IPhoneInfoViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "IPhoneInfoViewController.h"
#import "NSString+Addition.h"

@interface IPhoneInfoViewController ()
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation IPhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UUID 重装后改变；
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    
    //设备名称 e.g. @"iOS"
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    
    //手机系统版本 e.g. @"10.3.1"
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    
    //地方型号 （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    // 当前应用软件版本 比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    // 当前应用版本号码 int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    self.dataArray = @[
                       @[@"手机序列号：",identifierNumber],
                       @[@"手机别名：",userPhoneName],
                       @[@"手机型号：",deviceName],
                       @[@"手机系统版本：",phoneVersion],
                       @[@"设备名称：",phoneModel],
                       @[@"地区型号：",localPhoneModel],
                       @[@"当前应用名称：",appCurName],
                       @[@"当前应用软件版本：",appCurVersion],
                       @[@"当前应用版本号码：",appCurVersionNum],];
    
    [self createUI];
}

- (void)createUI {
    CGFloat height = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        NSArray *array = self.dataArray[i];
        UILabel *nameLabel = [self createLabelWithFrame:CGRectMake(10, Navigation_HEIGHT+20+20*i+height, kScreen_width/2-20, 34) Alignment:2 textColor:[UIColor blackColor] Text:array[0]];
        [self.view addSubview:nameLabel];
        
        UILabel *infoLabel = [self createLabelWithFrame:CGRectMake(kScreen_width/2+10, Navigation_HEIGHT+20+20*i+height,kScreen_width/2-20, 34) Alignment:0 textColor:[UIColor redColor] Text:array[1]];
        [self.view addSubview:infoLabel];
        height += infoLabel.frame.size.height;
    }
}

- (UILabel *)createLabelWithFrame:(CGRect)frame Alignment:(int)alignment textColor:(UIColor *)color Text:(NSString *)text
{
    CGFloat textHeight = [text heightForContent:text withWidth:frame.size.width withFont:[UIFont systemFontOfSize:15.0]];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, textHeight)];
    label.numberOfLines=0;                              //默认一行
    if (alignment == 0) {
        label.textAlignment=NSTextAlignmentLeft;//左
    }
    if (alignment == 1) {
        label.textAlignment=NSTextAlignmentCenter;//中
    }
    if (alignment == 2) {
        label.textAlignment=NSTextAlignmentRight;//右
    }
    label.backgroundColor=[UIColor clearColor];
    label.font =[UIFont systemFontOfSize:15.0];
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.textColor=color;               //字体颜色
    label.adjustsFontSizeToFitWidth=YES; //自适应
    label.text=text;
    return label;
    
}

@end
