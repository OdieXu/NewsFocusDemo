//
//  NewsFocusView.m
//  NewsFocusDemo
//
//  Created by 徐锐 on 15/4/14.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import "NewsFocusView.h"

//pageController高度
#define K_PageCtrl_Height    20

@interface NewsFocusView ()
{
}

@end

@implementation NewsFocusView

//构造函数
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSArray *)imageNameArray title:(NSArray *)titleArray urlArray:(NSArray *)urlArray
{
    self = [super initWithFrame:frame];
    if (self) {
        //图片数目
        int imageCount = (int)[imageNameArray count];
        
        //判断是否需要循环滚动：图片数多于1时需要循环滚动，循环滚动在scrollview前后各增加一张图
        BOOL cycle = (imageCount > 1) ? YES : NO;
        
        //创建scrollView
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.contentSize = CGSizeMake(frame.size.width * imageCount, frame.size.height);
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //图片宽度撑满，高度底部留20像素
        int imageWidth = frame.size.width;
        int imageHeight = frame.size.height - K_PageCtrl_Height;
        
        int startX = 0;
        if (cycle) {
            startX = frame.size.width;
        }
        
        //判断是否需要循环滚动：图片数多于1时需要循环滚动，循环滚动在scrollview前后各增加一张图
        if (cycle) {
            _scrollView.contentOffset = CGPointMake(frame.size.width, 0);
            _scrollView.contentSize = CGSizeMake(frame.size.width * (imageCount+2), frame.size.height);
            
            /**********将最后一张图添加到scrollView的头部**********/
            NSString *tailImageName = [imageNameArray objectAtIndex:imageNameArray.count-1];
            UIImageView *tailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tailImageName]];
            tailImageView.frame = CGRectMake(0, 0, imageWidth, imageHeight);
            [_scrollView addSubview:tailImageView];
            //[_imageArray addObject:tailImageView];
            
            //添加点击事件
            tailImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            [tailImageView addGestureRecognizer:singleTap1];
            //tag来标志点击图片的序号
            tailImageView.tag = imageNameArray.count-1;
            
            /**********将第一张图添加到scrollView的尾部**********/
            NSString *headImageName = [imageNameArray objectAtIndex:0];
            UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:headImageName]];
            headImageView.frame = CGRectMake((imageNameArray.count+1)*frame.size.width, 0, imageWidth, imageHeight);
            [_scrollView addSubview:headImageView];
            //[_imageArray addObject:headImageView];
            
            //添加点击事件
            headImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            [headImageView addGestureRecognizer:singleTap2];
            //tag来标志点击图片的序号
            headImageView.tag = 0;
        }else {
            _scrollView.contentOffset = CGPointMake(0, 0);
            _scrollView.contentSize = CGSizeMake(frame.size.width * imageCount, frame.size.height);
        }

        //创建图片数组
        if (_imageArray) {
            [_imageArray removeAllObjects];
            _imageArray = nil;
        }
        _imageArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageCount; ++i) {
            NSString *imageName = [imageNameArray objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imageView.frame = CGRectMake(startX+i*frame.size.width, 0, imageWidth, imageHeight);
            [_scrollView addSubview:imageView];
            [_imageArray addObject:imageView];
            
            //添加点击事件
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            [imageView addGestureRecognizer:singleTap1];
            //tag来标志点击图片的序号
            imageView.tag = i;
        }
        
        //纪录链接跳转地址
        if (_urlArray) {
            [_urlArray removeAllObjects];
            _urlArray = nil;
        }
        if (urlArray.count > 0) {
            _urlArray = [[NSMutableArray alloc] initWithArray:urlArray copyItems:YES];
        }
        
        //图片标题
        if (_titleArray) {
            [_titleArray removeAllObjects];
            _titleArray = nil;
        }
        _titleArray = [[NSMutableArray alloc] initWithArray:titleArray copyItems:YES];
        
        //pageControl宽度
        NSUInteger pageCtrlWidth = K_PageCtrl_Height*[titleArray count];
        //标签起始位置
        int titleStartX = 10;
        //标签宽度
        int titleWidth = frame.size.width - titleStartX - pageCtrlWidth;
        //标签高度
        int titleHeight = K_PageCtrl_Height;
        
//        for (int i = 0; i < [titleArray count] && i < [imageNameArray count]; ++i) {
//            NSString *titleStr = [titleArray objectAtIndex:i];
//            
//            //创建标签
//            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX+titleStartX+i*frame.size.width, frame.size.height - titleHeight, titleWidth, titleHeight)];
//            titleLabel.backgroundColor = [UIColor clearColor];
//            titleLabel.textColor = [UIColor blackColor];
//            titleLabel.textAlignment = NSTextAlignmentLeft;
//            titleLabel.font = [UIFont systemFontOfSize:14];
//            titleLabel.text = titleStr;
//            [_scrollView addSubview:titleLabel];
//            
//            [_titleArray addObject:titleLabel];
//        }
        
        //创建标签
        _titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleStartX, frame.size.height - titleHeight, titleWidth, titleHeight)];
        _titleNameLabel.backgroundColor = [UIColor clearColor];
        _titleNameLabel.textColor = [UIColor blackColor];
        _titleNameLabel.textAlignment = NSTextAlignmentLeft;
        _titleNameLabel.font = [UIFont systemFontOfSize:14];
        _titleNameLabel.text = [titleArray objectAtIndex:0];
        [self addSubview:_titleNameLabel];
        
        //创建pageControl：默认靠右
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = imageNameArray.count;
        _pageControl.frame = CGRectMake( frame.size.width - pageCtrlWidth, frame.size.height - K_PageCtrl_Height, pageCtrlWidth, K_PageCtrl_Height);
        _pageControl.currentPage = 0;
        _pageControl.enabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        [self addSubview:_pageControl];
        
        //自动滚动时间间隔
        _interval = 5;
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"dealloc---------");
}

#pragma mark - 图片点击事件
- (void)imageTap:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = [gestureRecognizer view];
    NSInteger tagvalue = view.tag;
    if (tagvalue >= 0 && tagvalue < _urlArray.count) {
        NSString *url = [_urlArray objectAtIndex:tagvalue];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

#pragma mark - 计时器到时,系统滚动图片
- (void)autoScroll
{
    NSInteger page = _pageControl.currentPage;
    page++;
    if (page == [_imageArray count]) {
        page = 0;
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*(page+1),0) animated:YES];
}
//开启自动滚动
- (void)startAutoScroll
{
    if (_moveTime) {
        [_moveTime invalidate];
        _moveTime = nil;
    }
    _moveTime = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}
//关闭自动滚动
- (void)stopAutoScroll
{
    if (_moveTime) {
        [_moveTime invalidate];
        _moveTime = nil;
    }
}
//设置自动滚动时间
- (void)setAutoScrollInterval:(NSInteger)interval
{
    _interval = interval;
    if (_moveTime) {
        [_moveTime invalidate];
        _moveTime = nil;
    }
    _moveTime = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int offsetX = _scrollView.contentOffset.x;
    int currentPage = offsetX/_scrollView.frame.size.width;
    
    if (offsetX == 0) {
        currentPage = (int)[_imageArray count] - 1;
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width*[_imageArray count],0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width*[_imageArray count], 0);
    }else if (currentPage == [_imageArray count] + 1) {
        currentPage = 0;
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }else {
        currentPage--;
    }
    
    //重置标题和页码
    _titleNameLabel.text = [_titleArray objectAtIndex:currentPage];
    _pageControl.currentPage = currentPage;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int offsetX = _scrollView.contentOffset.x;
    int currentPage = offsetX/_scrollView.frame.size.width;
    currentPage--;
    
    //重置标题和页码
    _titleNameLabel.text = [_titleArray objectAtIndex:currentPage];
    _pageControl.currentPage = currentPage;
}

@end