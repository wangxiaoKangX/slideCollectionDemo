//
//  SlideModel.h
//  CollectionDemoSlide
//
//  Created by wangxiaokang on 16/12/6.
//  Copyright © 2016年 王晓康. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    ServeAdd = 0,
    ServeSelected
}ServeButtonStates;

@interface SlideModel : NSObject

@property (nonatomic, strong) UIColor *backGroundColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) ServeButtonStates state;
@property (nonatomic, assign) BOOL isSectionOne;
@property (nonatomic, assign) BOOL isNewAdd;

@end
