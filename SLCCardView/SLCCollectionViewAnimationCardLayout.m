//
//  SLCCollectionViewAnimationCardLayout.m
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/10.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "SLCCollectionViewAnimationCardLayout.h"

@interface SLCCollectionViewAnimationCardLayout()


@end

@implementation SLCCollectionViewAnimationCardLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2 * [self cellWidth];
    bigRect.origin.x = rect.origin.x - [self cellWidth];
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

- (CGFloat)cellWidth {
    return self.collectionView.bounds.size.width * self.widthScale;
}

- (CGSize)itemSize {
    return CGSizeMake([self cellWidth],self.collectionView.bounds.size.height * self.heightScale);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated {
     [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
}
@end
