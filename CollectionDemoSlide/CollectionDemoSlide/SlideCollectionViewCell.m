//
//  SlideCollectionViewCell.m
//  CollectionDemoSlide
//
//  Created by wangxiaokang on 16/12/6.
//  Copyright © 2016年 王晓康. All rights reserved.
//

#import "SlideCollectionViewCell.h"
#import "UIView+PositionAndSize.h"
#import "DataManager.h"

@interface SlideCollectionViewCell ()

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIButton * stateButton; // Cell的编辑状态
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation SlideCollectionViewCell

- (UILabel *) label
{
    if(nil == _label)
    {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = self.valueOfW;
        CGFloat h = self.valueOfH;
        _label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
    }
    return _label;
}

- (UIButton *) stateButton
{
    if (nil == _stateButton)
    {
        CGFloat w = 23;
        CGFloat h = 23;
        CGFloat x = self.valueOfW - w;
        CGFloat y = 0;
        _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stateButton.frame = CGRectMake(x, y, w, h);
        [_stateButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stateButton;
}

- (void)resetModel:(SlideModel *)data :(NSIndexPath *)indexPath
{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.stateButton];
    
    self.layer.borderColor = [UIColor colorWithWhite:0.95 alpha:1].CGColor;
    self.layer.borderWidth =  1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonState:) name:@"notification_CellBeganEditing" object:nil];
    self.data = data;
    self.label.text = data.title;
    self.indexPath = indexPath;
    self.backgroundColor = data.backGroundColor;
    if ([DataManager shareDataManager].isEditing) {
        self.stateButton.hidden = NO;
        [self showStateButton];
    }else{
        self.stateButton.hidden = YES;
    }
}
- (void)showStateButton {
    switch (self.data.state) {
        case ServeAdd:
            self.stateButton.enabled = YES;
            [self.stateButton setImage:[UIImage imageNamed:@"app_add"] forState:UIControlStateNormal];
            break;
        case ServeSelected:
            if (self.indexPath.section == 0) {
                self.stateButton.enabled = YES;
                [self.stateButton setImage:[UIImage imageNamed:@"app_del"] forState:UIControlStateNormal];
                
            }else {
                if ([[DataManager shareDataManager].headArray containsObject:self.data]) {
                    self.stateButton.enabled = NO;
                    [self.stateButton setImage:[UIImage imageNamed:@"app_ok"] forState:UIControlStateNormal];
                    
                }else{
                    self.stateButton.enabled = YES;
                    [self.stateButton setImage:[UIImage imageNamed:@"app_add"] forState:UIControlStateNormal];
                }
            }
            break;
    }
}

- (void)changeButtonState:(NSNotification *)notification {
    NSString *string = notification.object;
    if ([string isEqualToString:@"yes"]) {
        self.stateButton.hidden = NO;
        [self showStateButton];
        self.stateButton.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.1 animations:^{
            self.stateButton.transform = CGAffineTransformIdentity;
        }];
    }else{
        
        [UIView animateWithDuration:0.1 animations:^{
            self.stateButton.transform = CGAffineTransformMakeScale(0.001, 0.001);
        } completion:^(BOOL finished) {
            self.stateButton.transform = CGAffineTransformIdentity;
            self.stateButton.hidden = YES;
        }];
    }
}

- (void)buttonClick:(UIButton *)sender {
    sender.enabled = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_CellStateChange" object:self];
}

@end
