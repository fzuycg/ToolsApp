//
//  MarkdownViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MarkdownViewController.h"
#import "MyButton.h"

#import "OCGumbo.h"
#import "OCGumbo+Query.h"


@interface MarkdownViewController ()

@property (nonatomic, strong) NSString *sString;
@property (nonatomic, copy) NSString *cString;

@end

@implementation MarkdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createUI];
    NSMutableString *string = [NSMutableString stringWithFormat:@"123"];
    
    self.sString = string;
    self.cString = string;
    
    NSLog(@"对象     -|- 内存地址 -|- 指针地址 -|- 内存地址内容");
    NSLog(@"string  -|- %p -|- %p -|- %@", string, &string, string);
    NSLog(@"sString -|- %p -|- %p -|- %@", _sString, &_sString, _sString);
    NSLog(@"cString -|- %p -|- %p -|- %@", _cString, &_cString, _cString);
    
    [string setString:@"abc"];
    NSLog(@"处理完之后");
    NSLog(@"string  -|- %p -|- %p -|- %@", string, &string, string);
    NSLog(@"sString -|- %p -|- %p -|- %@", _sString, &_sString, _sString);
    NSLog(@"cString -|- %p -|- %p -|- %@", _cString, &_cString, _cString);
    
    
    
}

- (void)createUI {
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, kNavigation_HEIGHT+40, kScreen_width-80, 40)];
    MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(0, kScreen_height-80, kScreen_width, 80)];
    [button setHighlighted:YES];
//    [button setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
//    [button setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
    [button setTitle:@"BUTTON" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor yellowColor];
    button.layer.cornerRadius = 7;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
}


- (void)buttonClick:(UIButton *)button {
    NSLog(@"点击了");
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    //创建1像素区域并开始图片绘图
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    
    //创建画板并填充颜色和区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    //从画板上获取图片并关闭图片绘图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - textView

- (void)createTextView {
    NSString *htmlString = @"<p style='text-align: center; margin: 0px; font-family: Arial, 黑体;'><span style='font-size: 16px; color: rgb(51, 51, 51);'><a-font size='16' color='#333333'>运动健身</a-font></span></p><p style='text-align: center; margin: 0px; font-family: Arial, 黑体;'><span style='font-size: 10px; color: rgb(215, 215, 215);'><a-font size='10' color='#d7d7d7'>办卡优惠活力人生</a-font></span></p>";
//    NSString *htmlString = @"<p style='margin: 0px; font-family: Arial, 黑体; line-height: 100%;'><strong style='font-size: 9px; color: rgb(255, 255, 255);'><a-font size='9' color='#ffffff'>上海</a-font></strong></p>";
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 120, kScreen_width-40, 100)];
    textView.backgroundColor = [UIColor yellowColor];
    textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    textView.showsVerticalScrollIndicator = NO;
    textView.editable = NO;
    textView.userInteractionEnabled = NO;
    [textView setScrollEnabled:NO];
    [self.view addSubview:textView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableAttributedString *htmlStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        //从字符 中分隔成2个元素的数组
        NSMutableArray *array = [htmlString componentsSeparatedByString:@"</p>"];
        [array removeLastObject];
        for (NSString *html in array) {
            OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString:html];
            
            OCGumboElement *element = document.Query(@"p").find(@"strong").first();
            
            NSString *styleStr = element.attr(@"style");
            
            CGFloat textFont = [self getResidueDegree:styleStr];
            if (!textFont) {
                textFont = 14;
            }
            
            [htmlStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:textFont] range:NSMakeRange(0, htmlStr.length)];
        }
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            textView.attributedText = htmlStr;
        });
    });
    
    
}

//截取字符串
- (CGFloat)getResidueDegree:(NSString *)string {
    NSRange startRange = [string rangeOfString:@"font-size: "];
    NSRange endRange = [string rangeOfString:@"px;"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [string substringWithRange:range];
    CGFloat font = [result floatValue];
    return font;
}


@end
