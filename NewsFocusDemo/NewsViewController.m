//
//  NewsViewController.m
//  NewsFocusDemo
//
//  Created by 徐锐 on 15/4/16.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsFocusView.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createScrollView];
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

#pragma mark - 构建滚动视图
- (void)createScrollView
{
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsFocusDataPlist.plist" ofType:nil]];
    
    _newsScrollView = [[NewsFocusView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 150) imageName:[dataArray objectAtIndex:0] title:[dataArray objectAtIndex:1] urlArray:[dataArray objectAtIndex:2]];
    [self.view addSubview:_newsScrollView];
}

//开启／关闭自动滚动
- (IBAction)autoScrollChanged:(id)sender {
    if (_autoScrollSwitch.isOn) {
        [_newsScrollView startAutoScroll];
    }else {
        [_newsScrollView stopAutoScroll];
    }
}

//设定自动滚动时间
- (IBAction)setInterval:(id)sender {
    int interval = [_intervalTextField.text intValue];
    if (interval < 0 || interval > 100) {
        UIAlertView *vv = [[UIAlertView alloc] initWithTitle:@"自动滚动时间" message:@"自动滚动时间最少1秒，最多100秒" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [vv show];
        return;
    }
    if (_autoScrollSwitch.isOn) {
        [_newsScrollView setAutoScrollInterval:interval];
    }
}

//点击背景
- (IBAction)backgroundClicked:(id)sender {
    [_intervalTextField resignFirstResponder];
}
@end
