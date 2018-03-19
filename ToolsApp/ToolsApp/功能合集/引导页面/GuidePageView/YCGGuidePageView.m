//
//  YCGGuidePageView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/19.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGGuidePageView.h"

@interface YCGGuidePageView() <UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *launchScrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIButton *enterButton;
@property (nonatomic, retain) NSArray *images;
@end

@implementation YCGGuidePageView

- (instancetype)initGuideViewWithImages:(NSArray *)imageArray {
    self = [[YCGGuidePageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    _isScrollOut = YES;
    self.images = imageArray;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _launchScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    _launchScrollView.showsHorizontalScrollIndicator = NO;
    _launchScrollView.bounces = NO;
    _launchScrollView.pagingEnabled = YES;
    _launchScrollView.delegate = self;
    [self addSubview:_launchScrollView];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    
    _launchScrollView.contentSize = CGSizeMake(kScreen_width * images.count, kScreen_height);
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * kScreen_width, 0, kScreen_width, kScreen_height)];
        imageView.image = [UIImage imageNamed:images[i]];
        [_launchScrollView addSubview:imageView];
        
        if (i == images.count - 1) {
            _enterButton = [self getEnterButton];
            [imageView addSubview:_enterButton];
            imageView.userInteractionEnabled = YES;
        }
    }
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreen_height - 50, kScreen_width, 30)];
    _pageControl.numberOfPages = images.count;
    _pageControl.currentPage = 0;
    _pageControl.defersCurrentPageDisplay = YES;
    [self addSubview:_pageControl];
}

- (UIButton *)getEnterButton {
    if (!_enterButton) {
        _enterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        _enterButton.layer.cornerRadius = 5;
        _enterButton.backgroundColor = JDCOLOR_FROM_RGB_OxFF_ALPHA(0x40eb78, 1);
        [_enterButton setTitle:@"点击进入" forState:UIControlStateNormal];
    }
    _enterButton.center = CGPointMake(kScreen_width/2, kScreen_height-80);
    [_enterButton addTarget:self action:@selector(enterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _enterButton;
}

-(void)setEnterButton:(UIButton *)enterButton
{
    _enterButton = enterButton;
}

-(void)setCurrentColor:(UIColor *)currentColor
{
    _pageControl.currentPageIndicatorTintColor = currentColor;
}

-(void)setNomalColor:(UIColor *)nomalColor
{
    _pageControl.pageIndicatorTintColor = nomalColor;
    
}

- (void)enterButtonClick {
    [self hideGuideView];
}

- (void)hideGuideView {
    //动画隐藏
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        //延迟0.5秒移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}

#pragma mark - UIScrollerViewDelagate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    int cuttentIndex = (int)(scrollView.contentOffset.x + kScreen_width/2)/kScreen_width;
    //如果是最后一页左滑
    if (cuttentIndex == self.images.count - 1) {
        if ([self isScrolltoLeft:scrollView]) {
            if (_isScrollOut) {
                [self hideGuideView];
            }
        }
    }
}

//修改page的显示
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _launchScrollView) {
        
        int cuttentIndex = (int)(scrollView.contentOffset.x + kScreen_width/2)/kScreen_width;
        _pageControl.currentPage = cuttentIndex;
    }
}

#pragma mark - 判断滚动方向
-(BOOL )isScrolltoLeft:(UIScrollView *) scrollView{
    //返回YES为向左反动，NO为右滚动
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        return YES;
    }else{
        return NO;
    }
}

@end
