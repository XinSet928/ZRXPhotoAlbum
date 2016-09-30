//
//  JumpViewController.m
//  ZRXPhotoAlbum
//
//  Created by mac on 16/7/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JumpViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height


@interface JumpViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *_collectionView;
    UIScrollView *scrollView;
    UIImageView *imageView;
}

@end

@implementation JumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight);
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    
    
    [self.view addSubview:_collectionView];
    //注册
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //实现点击跳转后出现的图片就是点击的那张图片
    [_collectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    scrollView = [[UIScrollView alloc]initWithFrame:cell.bounds];
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 1.0;
    scrollView.maximumZoomScale = 2.0;
    scrollView.tag = 1000;
    [cell.contentView addSubview:scrollView];
    
    //添加手势
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTouch:)];
    tapGest.numberOfTapsRequired = 2;//点击的次数
    tapGest.numberOfTouchesRequired = 1;//手指的个数
    [scrollView addGestureRecognizer:tapGest];
    
    
    imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSURL *url = [NSURL URLWithString:_imageArray[indexPath.item]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    imageView.image = [UIImage imageWithData:data];
    
    [scrollView addSubview:imageView];
    
    return cell;
    
}

#pragma mark -滑动视图的手势实现
-(void)scrollTouch:(UITapGestureRecognizer *)tag{
    if (scrollView.zoomScale>1.0) {
        [scrollView setZoomScale:1.0 animated:YES];
    }else{
        [scrollView setZoomScale:2.0 animated:YES];
    }
}

#pragma mark -单元格消失后恢复原样
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //将cell上的scrollView变为1.0
    UIScrollView *scrollViews = [cell.contentView viewWithTag:1000];
    [scrollViews setZoomScale:1.0 animated:YES];
    //防止其再放大后的再出现
    [scrollViews removeFromSuperview];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return imageView;
    
}



@end
