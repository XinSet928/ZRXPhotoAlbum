//
//  MainViewController.m
//  ZRXPhotoAlbum
//
//  Created by mac on 16/7/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainViewController.h"
#import "JumpViewController.h"
#import "UIImageView+WebCache.h"

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    NSArray *_array;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInfo];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.815 blue:0.831 alpha:1.000];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.itemSize = CGSizeMake(80, 70);
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    //注册
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}


-(void)loadInfo{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_list.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    NSString *string = [_array[indexPath.item] objectForKey:@"image"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:string]];
    [cell.contentView addSubview:imageView];
    
    return cell;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",indexPath.item);
    
    JumpViewController *jumpVC = [[JumpViewController alloc] init];
    
    jumpVC.imageArray = _array.mutableCopy;
  
    NSMutableArray *mut = [NSMutableArray array];
    for (int i=0; i<_array.count; i++) {
        NSString *url = [_array[i] objectForKey:@"image"];
        [mut addObject:url];
    }
    //传值
    jumpVC.imageArray = mut;
    jumpVC.indexPath = indexPath;
    [self.navigationController pushViewController:jumpVC animated:YES];
    
}


@end
