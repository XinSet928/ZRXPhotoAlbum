//
//  JumpViewController.h
//  ZRXPhotoAlbum
//
//  Created by mac on 16/7/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JumpViewController : UIViewController

//设置这两个属性用于传递数据
@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,strong)NSMutableArray *imageArray;


@end
