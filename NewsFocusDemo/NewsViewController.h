//
//  NewsViewController.h
//  NewsFocusDemo
//
//  Created by 徐锐 on 15/4/16.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsFocusView;

@interface NewsViewController : UIViewController
{
    __weak IBOutlet UITextField *_intervalTextField;
    __weak IBOutlet UISwitch *_autoScrollSwitch;
    
    NewsFocusView * _newsScrollView;
}
//点击背景
- (IBAction)backgroundClicked:(id)sender;

//开启／关闭自动滚动
- (IBAction)autoScrollChanged:(id)sender;
//设定自动滚动时间
- (IBAction)setInterval:(id)sender;

@end
