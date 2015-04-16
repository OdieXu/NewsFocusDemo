//
//  NewsFocusView.h
//  NewsFocusDemo
//
//  Created by 徐锐 on 15/4/14.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFocusView : UIView<UIScrollViewDelegate>
{
    //底部标题标签
    UILabel *_titleNameLabel;
    //滚动视图
    UIScrollView * _scrollView;
    //页码控件
    UIPageControl *_pageControl;
    //定时器：用于自动滚动
    NSTimer *_moveTime;
    NSInteger _interval;
    
    //图片数组
    NSMutableArray *_imageArray;
    //图片标题数组
    NSMutableArray *_titleArray;
    //点击图片跳转url地址数组
    NSMutableArray *_urlArray;
}

//构造函数
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSArray *)imageNameArray title:(NSArray *)titleArray urlArray:(NSArray *)urlArray;

//开启自动滚动
- (void)startAutoScroll;
//关闭自动滚动
- (void)stopAutoScroll;
//设置自动滚动时间
- (void)setAutoScrollInterval:(NSInteger)interval;
@end
