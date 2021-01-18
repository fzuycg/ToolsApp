//
//  YCGFindViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGFindViewController.h"
#import "UIImage+DrawAddition.h"

@interface YCGFindViewController ()

@end

@implementation YCGFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSArray *array = @[
//                       @"62284 80010 20090 0214",
//                       @"9558800200136624752",
//                       @"453242 53242 491031 54403",
//                       @"436742 622700",
//                       @"1234567890123456789"
//                       ];
//    for (NSString *string in array) {
//        NSString *str = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//        BOOL result = [self checkCardNo:str];
//        NSLog(@"%@-->%@", str, result?@"YES":@"NO");
//    }
    
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
    
    NSArray *arr = [self splitArray:mutArray withSubSize:3];
    for (NSArray *ar in arr) {
        NSLog(@"-->%@", ar);
    }
}

//是否是银行卡号
- (BOOL)checkCardNo:(NSString *)cardNo {
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 获取url中的参数并
 @param urlString 带参数的url
 @return 参数字典
 */
- (NSDictionary *)getParamsWithUrlString:(NSString *)urlString {
    if(urlString.length==0) {
        NSLog(@"链接为空！");
        return nil;
    }
    //先截取问号
    NSArray *allElements = [urlString componentsSeparatedByString:@"?"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典
    if(allElements.count == 2) {
        NSString *paramsString = allElements[1];
        //获取参数对
        NSArray *paramsArray = [paramsString componentsSeparatedByString:@"&"];
        if(paramsArray.count>=2) {
            for(NSInteger i =0; i < paramsArray.count; i++) {
                NSString *singleParamString = paramsArray[i];
                NSArray *singleParamSet = [singleParamString componentsSeparatedByString:@"="];
                if(singleParamSet.count==2) {
                    NSString *key = singleParamSet[0];
                    NSString *value = singleParamSet[1];
                    if(key.length>0 || value.length>0) {
                        [params setObject:value.length>0 ? value : @"" forKey:key.length>0 ? key : @""];
                    }
                }
            }
        }else if(paramsArray.count == 1) {
            //无 &。url只有?后一个参数
            NSString *singleParamString = paramsArray[0];
            NSArray *singleParamSet = [singleParamString componentsSeparatedByString:@"="];
            if(singleParamSet.count == 2) {
                NSString *key = singleParamSet[0];
                NSString *value = singleParamSet[1];
                if(key.length>0|| value.length>0) {
                    [params setObject:value.length>0 ? value : @"" forKey:key.length>0 ? key : @""];
                }
            }else{
                //问号后面啥也没有 xxxx?  无需处理
            }
        }
        return params;
    }else if(allElements.count>2) {
        NSLog(@"链接不合法！链接包含多个\"?\"");
        return nil;
    }else {
        NSLog(@"链接不包含参数！");
        return nil;
    }
}

- (void)createUI {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 90, 80)];
    [button setImage:[UIImage ly_imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

//切割数组
- (NSArray *)splitArray:(NSArray *)array withSubSize:(int)subSize {
    // 数组要被拆分成的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        int index = i * subSize;
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:subSize];
        [arr1 removeAllObjects];
        
        int j = index;
        while (j < subSize*(i+1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        
        [arr addObject:[arr1 copy]];
    }
    
    return [arr copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
