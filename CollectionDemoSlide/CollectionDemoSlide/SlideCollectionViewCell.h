//
//  SlideCollectionViewCell.h
//  CollectionDemoSlide
//
//  Created by wangxiaokang on 16/12/6.
//  Copyright © 2016年 王晓康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideModel.h"

@interface SlideCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SlideModel *data;

- (void)resetModel:(SlideModel *)data :(NSIndexPath *)indexPath;

@end
