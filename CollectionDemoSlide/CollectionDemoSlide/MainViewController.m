//
//  MainViewController.m
//  CollectionDemoSlide
//
//  Created by wangxiaokang on 16/12/8.
//  Copyright © 2016年 王晓康. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+PositionAndSize.h"
#import "ChooseView.h"


@interface MainViewController ()
{
    BOOL _isShow;
}
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) ChooseView * chooseView;
@end

@implementation MainViewController

- (UIButton *) btn
{
    if (nil == _btn)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(self.view.valueOfW - 100,100,60,40);
        _btn.backgroundColor = [UIColor blueColor];
        [_btn setTitle:@"Show" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DemoDemo";
    [self creatUI];
}

- (void) creatUI
{
    [self.view addSubview:self.btn];
    _isShow = NO;
    
    CGFloat x = 10;
    CGFloat y = self.btn.valueOfBottomMargin + 5;
    CGFloat w = self.view.valueOfW - 20;
    CGFloat h = self.view.valueOfH-y - 25;
    
    self.chooseView = [[ChooseView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    
}

- (void) clickBtn
{
    if (_isShow == YES)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.chooseView.alpha = 0;
        } completion:^(BOOL finished) {
            NSLog(@"finish");
            [self.chooseView removeFromSuperview];
        }];
        [self.btn setTitle:@"Show" forState:UIControlStateNormal];
        _isShow = NO;
    }else
    {
        [self.view addSubview:self.chooseView];
        
        self.chooseView.alpha = 0;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.chooseView.alpha = 1;
        } completion:^(BOOL finished) {
            NSLog(@"finish");
        }];
        
        [self.btn setTitle:@"收起" forState:UIControlStateNormal];
        _isShow = YES;
    }
}

@end
