//
//  PrintLabel.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/22.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "PrintLabel.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation PrintLabel{
    SystemSoundID  soundID;
    NSTimer *prientTimer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置默认值
        self.textColor = [UIColor clearColor];
        self.hasSound = YES;
        self.time = 0.3;
    }
    return self;
}

- (void)startPrint {
    //播放声音
    NSString *path =[[NSBundle mainBundle] pathForResource:@"printerVoice" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &(soundID));
    
    prientTimer =    [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(outPutWord:) userInfo:nil repeats:YES];
}
-(void)outPutWord:(id)atimer
{
    if (self.text.length ==self.currentIndex) {
        
        [atimer invalidate];
        atimer =nil;
        DeLog(@"打印完成");
        self.completeBlock();
    }
    else
    {
        DeLog(@"正在打印");
        self.currentIndex ++;
        NSDictionary *dic =@{NSForegroundColorAttributeName:self.printColor};
        NSMutableAttributedString *mutStr =[[NSMutableAttributedString alloc]initWithString:self.text];
        [mutStr addAttributes:dic range:NSMakeRange(0, self.currentIndex)];
        [self setAttributedText:mutStr];
        self.hasSound?AudioServicesPlaySystemSound(soundID):AudioServicesPlaySystemSound (0);
    }
}



-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [prientTimer invalidate];
    prientTimer =nil;
}

@end
