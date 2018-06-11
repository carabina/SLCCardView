//
//  SLCAnimationCardView.m
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/11.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "SLCAnimationCardView.h"
#import "SLCCollectionViewAnimationCardLayout.h"
@interface SLCAnimationCardView()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
   
}

@property (nonatomic, strong) SLCCollectionViewAnimationCardLayout * layout;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) SLCFixCardPagingPositionManager * positionManager;

@end

@implementation SLCAnimationCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource SLCAnimationCardViewNumberOfItems:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.dataSource SLCAnimationCardView:self itemAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(SLCAnimationCardView:didSelectItemAtIndex:)]) {
        [self.delegate SLCAnimationCardView:self didSelectItemAtIndex:indexPath.row];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.positionManager fixScroll];
    if (self.delegate && [self.delegate respondsToSelector:@selector(SLCAnimationCardView:currentIndexChanged:)]) {
        [self.delegate SLCAnimationCardView:self currentIndexChanged:self.positionManager.selectedIndex];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.positionManager fixBegingDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.positionManager fixEndDragging];
}

- (SLCCollectionViewAnimationCardLayout *)layout {
    if (!_layout) {
        _layout = [SLCCollectionViewAnimationCardLayout new];
    }
    return _layout;
}

- (SLCFixCardPagingPositionManager *)positionManager {
    if (!_positionManager) {
        _positionManager = [[SLCFixCardPagingPositionManager alloc] initWithCollectionView:self.collectionView];
    }
    return _positionManager;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

#pragma mark ---<Setter、Getter>---
- (void)setWidthScale:(CGFloat)widthScale {
    _widthScale = widthScale;
    self.layout.widthScale = widthScale;
}

- (void)setHeightScale:(CGFloat)heightScale {
    _heightScale = heightScale;
    self.layout.heightScale = heightScale;
}

- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    self.layout.minimumLineSpacing = lineSpacing;
}

- (void)setInteritemSpacing:(CGFloat)interitemSpacing {
    _interitemSpacing = interitemSpacing;
    self.layout.minimumInteritemSpacing = interitemSpacing;
}

- (void)setSectionInsert:(UIEdgeInsets)sectionInsert {
    _sectionInsert = sectionInsert;
    self.layout.sectionInset = sectionInsert;
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    self.layout.itemSize = itemSize;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.collectionView.bounds];
    imageView.image = backgroundImage;
    self.collectionView.backgroundView = imageView;
}

- (void)setPageEnable:(BOOL)pageEnable {
    _pageEnable = pageEnable;
    self.collectionView.pagingEnabled = pageEnable;
}

- (void)setContentInsert:(UIEdgeInsets)contentInsert {
    _contentInsert = contentInsert;
    self.collectionView.contentInset = contentInsert;
}

#pragma mark ---<Method>----

- (void)registerClass:(Class)aClass forCellWithReuseIdentifier:(NSString *)identify {
    [self.collectionView registerClass:aClass forCellWithReuseIdentifier:identify];
}

- (UICollectionViewCell *)dequeueReusableItemWithReuseIdentifier:(NSString *)identify forIndex:(NSInteger)index {
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.collectionView reloadData];
    });
}

- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated {
    [self.layout scrollToItemAtIndex:index animated:animated];
}


@end
