//
//  SLCFixCardPagingPositionManager.m
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/10.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "SLCFixCardPagingPositionManager.h"

@interface SLCFixCardPagingPositionManager()
@property (nonatomic, assign) CGFloat dragStartX;
@property (nonatomic, assign) CGFloat dragEndX;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation SLCFixCardPagingPositionManager

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    if (self = [super init]) {
        self.collectionView = collectionView;
    }
    return self;
}

- (void)fixBegingDragging {
    if (!self.collectionView.pagingEnabled) return;
    self.dragStartX = self.collectionView.contentOffset.x;
}

- (void)fixEndDragging {
    if (!self.collectionView.pagingEnabled) return;
    _dragEndX = self.collectionView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        float dragMiniDistance = self.collectionView.bounds.size.width/20.0f;
        if (self.dragStartX -  self.dragEndX >= dragMiniDistance) {
            self.selectedIndex -= 1;//向右
        }else if(self.dragEndX -  self.dragStartX >= dragMiniDistance){
            self.selectedIndex += 1;//向左
        }
        NSInteger maxIndex = [self.collectionView numberOfItemsInSection:0] - 1;
        self.selectedIndex = self.selectedIndex <= 0 ? 0 : self.selectedIndex;
        self.selectedIndex = self.selectedIndex >= maxIndex ? maxIndex : self.selectedIndex;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    });
}

- (void)fixScroll {
    if (!self.collectionView.pagingEnabled) return;
    if (!self.collectionView.visibleCells.count) return;
    if (!self.collectionView.isDragging) return;
    CGRect currentRect = self.collectionView.bounds;
    currentRect.origin.x = self.collectionView.contentOffset.x;
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        if (CGRectContainsRect(currentRect, cell.frame)) {
            NSInteger index = [_collectionView indexPathForCell:cell].row;
            if (index != self.selectedIndex) {
                self.selectedIndex = index;
            }
        }
    }
}



@end
