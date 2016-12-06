//
//  DataManager.h
//  CollectionDemoSlide
//
//  Created by wangxiaokang on 16/12/6.
//  Copyright © 2016年 王晓康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *headArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, assign) BOOL isShowHeaderMessage;
@property (nonatomic, assign) BOOL isEditing;

+ (DataManager *)shareDataManager;

@end
