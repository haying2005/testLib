//
//  WY_WaterFallFlowLayout.h
//  sdfs
//
//  Created by fangwenyu on 2016/11/4.
//  Copyright © 2016年 fangwenyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGSize(^SizeCaculateBlock)(NSInteger index);


@interface WY_WaterFallFlowLayout : UICollectionViewFlowLayout

- (void)setSizeCaculateBlock:(SizeCaculateBlock)block;

@end
