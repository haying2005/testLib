//
//  WY_WaterFallFlowLayout.m
//  sdfs
//
//  Created by fangwenyu on 2016/11/4.
//  Copyright © 2016年 fangwenyu. All rights reserved.
//

#import "WY_WaterFallFlowLayout.h"

@interface GapCell:NSObject

@property (nonatomic, strong)UICollectionViewLayoutAttributes *attr;
@property (nonatomic, assign)CGFloat left;
@property (nonatomic, assign)CGFloat right;

@end

@implementation GapCell



@end

@interface WY_WaterFallFlowLayout()

{
    SizeCaculateBlock _sizeCaculateBlock;
    NSMutableArray *_attributesArray;
    
    CGFloat maxY;
    
    NSMutableSet *gapCellSet;
}

@end

@implementation WY_WaterFallFlowLayout

- (void)setSizeCaculateBlock:(SizeCaculateBlock)block {
    _sizeCaculateBlock = block;
}


- (void)prepareLayout {
    
    _attributesArray = [NSMutableArray array];
    
    [super prepareLayout];
    
    if ([self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView] > 1) {
        NSLog(@"暂时只支持单section");
        return;
    }
    
    NSInteger count = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    if (!count) {
        return;
    }
    
    NSInteger atRow = 0;
    NSInteger atCol = 0;
    maxY = 0;
    CGFloat maxX = self.sectionInset.left;
    CGFloat sectionWidth = self.collectionView.bounds.size.width;
    
    for (int i = 0; i < count; i ++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexpath];
        CGFloat width = attr.size.width;
        CGFloat height = attr.size.height;
        CGFloat x;
        CGFloat y;
        if (sectionWidth - maxX - self.sectionInset.right - (atCol == 0 ? 0 : self.minimumInteritemSpacing) < width) {
            atRow ++;
            atCol = 0;
            maxX = self.sectionInset.left;
        }
        
        x = maxX + (atCol == 0 ? 0 : self.minimumInteritemSpacing);
        y = self.sectionInset.top + (height + self.minimumLineSpacing)*atRow;
        maxX = width + x;
        atCol ++;
        attr.frame = CGRectMake(x, y, width, height);
        [_attributesArray addObject:attr];
        
        if (maxY < CGRectGetMaxY(attr.frame) + self.sectionInset.bottom) {
            maxY = CGRectGetMaxY(attr.frame) + self.sectionInset.bottom;
        }
        
        [gapCellSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            GapCell *gap = (GapCell *)obj;
            
        }];

    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (!_sizeCaculateBlock) {
        
        attr.size = CGSizeZero;
        NSLog(@"请设置_sizeCaculateBlock");
    }
    attr.size = _sizeCaculateBlock(indexPath.row);
    
    return attr;
}

- (CGSize)collectionViewContentSize {
   
    return CGSizeMake(self.collectionView.bounds.size.width, maxY);
}

@end
