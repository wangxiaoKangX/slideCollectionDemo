//
//  ViewController.m
//  CollectionDemoSlide
//
//  Created by 王晓康 on 2016/12/5.
//  Copyright © 2016年 王晓康. All rights reserved.
//

#import "ViewController.h"
#import "DragCellCollectionView.h"
#import "SlideCollectionViewCell.h"
#import "DataManager.h"
#import "SlideModel.h"
#import "CollectionReusableHeaderView.h"
#import "CollectionReusableFooterView.h"

@interface ViewController ()<DragCellCollectionViewDataSource, DragCellCollectionViewDelegate>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, weak) DragCellCollectionView *mainView;
//@property (nonatomic, assign) UIBarButtonItem *editButton;
@property (nonatomic, strong) DataManager *sourceManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    [self creatUI];
    
}

- (void) creatUI
{
    self.title = @"校长Demo";
    // 创建layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout  alloc] init];
    // 设置垂直方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置每个item的大小
    float cellWidth = floorf((self.view.bounds.size.width - 50)/3);
    layout.itemSize = CGSizeMake(cellWidth, 60);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    DragCellCollectionView *mainView = [[DragCellCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = [UIColor whiteColor];
    
    [mainView registerClass:[SlideCollectionViewCell class] forCellWithReuseIdentifier:@"SlideCollectionViewCell"];
    
    [mainView registerClass:[CollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [mainView registerClass:[CollectionReusableFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];

    
    _mainView = mainView;
    [self.view addSubview:_mainView];
    
    
    self.sourceManager = [DataManager shareDataManager];
    _mainView.beginEditing = YES; // 一直处于可编辑状态
}

#pragma mark - <DragCellCollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sourceManager.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sec = self.sourceManager.dataArray[section];
    return sec.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SlideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SlideCollectionViewCell" forIndexPath:indexPath];
    [cell resetModel:self.sourceManager.dataArray[indexPath.section][indexPath.item] :indexPath];
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(DragCellCollectionView *)collectionView{
    return self.sourceManager.dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size;
    if (section == 0&&[DataManager shareDataManager].isShowHeaderMessage) {
        size= CGSizeMake(self.view.bounds.size.width, 60);
    }else {
        size= CGSizeMake(self.view.bounds.size.width, 25);
    }
    return size;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size= CGSizeMake(self.view.bounds.size.width, 15);
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        CollectionReusableHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headView.title = [DataManager shareDataManager].titleArray[indexPath.section];
        if (indexPath.section == 0&&[DataManager shareDataManager].isShowHeaderMessage) {
            headView.isShowMessage = YES;
        }else if(indexPath.section == 0&& ![DataManager shareDataManager].isShowHeaderMessage) {
            headView.isShowMessage = NO;
        }else {
            headView.isShowMessage = NO;
        }
        
        reusableView = headView;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        CollectionReusableFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            footerView.isShowTopLine = YES;
            footerView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
        }else {
            footerView.backgroundColor = [UIColor whiteColor];
            footerView.isShowTopLine = NO;
            
        }
        reusableView = footerView;
    }
    return reusableView;
}

// 当cell马上进去屏幕的时候,就会调用willDisplayCell方法,在这个方法里面我们还可以修改cell,为进入屏幕做最后的准备工作;
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(SlideCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (cell.data.isNewAdd &&indexPath.section == 0) {
        cell.transform = CGAffineTransformMakeScale(0.001, 0.001);
        [UIView animateWithDuration:0.2 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            cell.data.isNewAdd = NO;
        }];
    }
}

#pragma mark - <DragCellCollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@" ---item.name = %@",self.sourceManager.dataArray[indexPath.section][indexPath.item]);
    SlideModel * model = self.sourceManager.dataArray[indexPath.section][indexPath.item];
    NSLog(@" -- model.name = %@",model.title);
    
}

// 实现必须实现的一个Delegate代理方法：（在该方法中将重拍好的新数据源设为当前数据源）(例如 :_data = newDataArray)
- (void)dragCellCollectionView:(DragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    self.sourceManager.dataArray = newDataArray.mutableCopy;
}

// 某个cell将要开始移动的时候调用
- (void)dragCellCollectionView:(DragCellCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
    //拖动时候最后禁用掉编辑按钮的点击
//    _editButton.enabled = NO;
}

// cell移动完毕，并成功移动到新位置的时候调用
- (void)dragCellCollectionViewCellEndMoving:(DragCellCollectionView *)collectionView{
//    _editButton.enabled = YES;
}

@end
