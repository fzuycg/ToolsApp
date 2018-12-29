//
//  YCGMeViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGMeViewController.h"
#import "GDataXMLNode.h"

@interface YCGMeViewController ()

@end

@implementation YCGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 120, kScreen_width-40, 100)];
    textView.backgroundColor = [UIColor yellowColor];
    textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    textView.showsVerticalScrollIndicator = NO;
    textView.editable = NO;
    textView.userInteractionEnabled = NO;
    [textView setScrollEnabled:NO];
    [self.view addSubview:textView];
    
    
    NSString *htmlString = @"<p style='text-align: end; margin: 0px; font-family: PingFangSC-Regular, sans-serif, Arial, 黑体; font-size: 20px;'>第二</p>";
    
    /*处理字体大小*/
    NSMutableString *newString = [[NSMutableString alloc] initWithString:@""];
    //从字符 中分隔成2个元素的数组
    NSMutableArray *array = [NSMutableArray arrayWithArray:[htmlString componentsSeparatedByString:@"</p>"]];
    [array removeLastObject];
    for (int i=0; i<array.count; i++) {
        NSString *string = [NSString stringWithFormat:@"%@</p>", array[i]];
        NSString *str = [self GDataXML:string];
        [newString appendString:str];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableAttributedString *htmlStr = [[NSMutableAttributedString alloc] initWithData:[newString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        
//        [htmlStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, htmlStr.length)];
        
        /*设置行间距*/
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;// 字体的行间距
        
        if ([htmlString containsString:@"center"]) {
            paragraphStyle.alignment = NSTextAlignmentCenter;
        }
        if ([htmlString containsString:@"right"]) {
            paragraphStyle.alignment = NSTextAlignmentRight;
        }
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:10],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
//        [htmlStr addAttributes:attributes range:NSMakeRange(0, htmlStr.length)];//这里设置行间距之后其他属性不起作用
        
        [htmlStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlStr length])];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            textView.attributedText = htmlStr;
        });
    });
    
}



#pragma mark - Private
- (NSString *)GDataXML:(NSString *)html {
    //对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:html error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    //获取其他节点
    NSArray *array = [rootElement children];
    for (GDataXMLElement *spanElement in array) {
        if ([[spanElement XMLString] isEqualToString:[spanElement stringValue]]) {//什么都没有设置
            NSString *text = [spanElement stringValue];
            GDataXMLElement *newSpanElement = [GDataXMLNode elementWithName:@"span" stringValue:text];
            
            NSString *newStyleStr = [NSString stringWithFormat:@"font-size: %.2fpx;", 14*(kScreen_width/375)];
            GDataXMLElement *newSize = [GDataXMLNode attributeWithName:@"style" stringValue:newStyleStr];
            
            [newSpanElement addAttribute:newSize];
            
            [rootElement removeChild:spanElement];
            [rootElement addChild:newSpanElement];
            
        }else if (![[spanElement XMLString] containsString:@"a-font"]) {//没有设置字体大小、颜色
            NSString *newStyleStr = [NSString stringWithFormat:@"font-size: %.2fpx;", 14*(kScreen_width/375)];
            GDataXMLElement *newSize = [GDataXMLNode attributeWithName:@"style" stringValue:newStyleStr];
            
            [spanElement addAttribute:newSize];
        } else {
            NSString *aFontStr = [self interceptingString:[spanElement XMLString]];
            GDataXMLElement *aFontElement = [[GDataXMLElement alloc] initWithXMLString:aFontStr error:nil];
            
            GDataXMLNode *sizeNode = [aFontElement attributeForName:@"size"];
            NSString *fontStr = [sizeNode stringValue];//获取字体大小
            CGFloat textFont = [fontStr floatValue];
            NSString *spanStr = [spanElement XMLString];
            NSString *newSpanStr = @"";
            if (!textFont) {//没有设置字体大小
                newSpanStr = [self interpositionString:spanStr with:[NSString stringWithFormat:@"font-size: %.2fpx; ", 14*(kScreen_width/375)]];
            }else{
                newSpanStr = [spanStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@px;", fontStr] withString:[NSString stringWithFormat:@"%.2fpx;", textFont*(kScreen_width/375)]];//替换字符串
                
            }
            GDataXMLElement *newSpanElement = [[GDataXMLElement alloc] initWithXMLString:newSpanStr error:nil];
            
            [rootElement removeChild:spanElement];
            [rootElement addChild:newSpanElement];
        }
    }
    
    NSString *resultStr = [rootElement XMLString];
    
    return resultStr;
}

/**
 截取字符串
 */
- (NSString *)interceptingString:(NSString *)string {
    NSRange startRange = [string rangeOfString:@"<a-font"];
    NSRange endRange = [string rangeOfString:@"</a-font>"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [string substringWithRange:range];
    return [NSString stringWithFormat:@"<a-font%@</a-font>", result];
}

/**
 插入字符串
 */
- (NSString *)interpositionString:(NSString *)baseString with:(NSString *)string {
    NSRange startRange = [baseString rangeOfString:@"style="];
    
    NSMutableString *result = [[NSMutableString alloc] initWithString:baseString];
    [result insertString:string atIndex:startRange.location+startRange.length+1];
    
    return result;
}


@end
