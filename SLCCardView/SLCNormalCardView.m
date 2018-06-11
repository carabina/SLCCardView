//
//  SLCNormalCardView.m
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/11.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import "SLCNormalCardView.h"
#import "SLCFixCardPagingPositionManager.h"
@interface SLCNormalCardView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate> {
    NSInteger _items;
    NSInteger _realItems;
}
@property (nonatomic, strong) SLCFixCardPagingPositionManager * positionManager;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) BOOL isTimerStarting;
@property (nonatomic, assign) BOOL isCanAutoScroll;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation SLCNormalCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.loopEnable) {
        _realItems = [self.dataSource SLCNormalCardViewNumberOfItems:self];
        _items = _realItems * 10000;
    }else {
        _realItems = [self.dataSource SLCNormalCardViewNumberOfItems:self];
        _items = _realItems;
    }
    return _items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = 0;
    if (self.loopEnable) {
        index = indexPath.row % _realItems;
    }else {
        index = indexPath.row;
    }
    UICollectionViewCell *cell = [self.dataSource SLCNormalCardView:self itemAtIndex:index];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    NSInteger index = 0;
    if (self.loopEnable) {
        index = indexPath.row % _realItems;
    }else {
        index = indexPath.row;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SLCNormalCardView:didSelectItemAtIndex:)]) {
        [self.delegate SLCNormalCardView:self didSelectItemAtIndex:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.positionManager fixScroll];
    if (!self.isCanAutoScroll) {
        [self postCurrentIndexDelegateWithIndex:self.positionManager.selectedIndex];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.positionManager fixBegingDragging];
    if (self.isTimerStarting && self.isCanAutoScroll) [self endTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.positionManager fixEndDragging];
    if (!self.isTimerStarting && self.isCanAutoScroll) [self startTimerWithDuration:self.duration];
}

- (SLCFixCardPagingPositionManager *)positionManager {
    if (!_positionManager) {
        _positionManager = [[SLCFixCardPagingPositionManager alloc] initWithCollectionView:self.collectionView];
    }
    return _positionManager;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
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

- (void)setLoopEnable:(BOOL)loopEnable {
    _loopEnable = loopEnable;
    if (loopEnable) {
        NSInteger realNum = [self.dataSource SLCNormalCardViewNumberOfItems:self];
        NSInteger num = floor(realNum * 5000);
        [self scrollToItemAtIndex:num animated:NO];
    }
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
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    if (self.isCanAutoScroll) [self postCurrentIndexDelegateWithIndex:index];
}

- (void)postCurrentIndexDelegateWithIndex:(NSInteger)index {
    NSInteger realIndex = 0;
    if (self.loopEnable) {
        realIndex = index % _realItems;
    }else {
        realIndex = index;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(SLCNormalCardView:currentIndexChanged:)]) {
        [self.delegate SLCNormalCardView:self currentIndexChanged:realIndex];
    }
}

- (void)autoAnmitionWithDuration:(CGFloat)duration {
    self.duration = duration;
    self.pageEnable = YES;
    self.loopEnable = YES;
    self.isCanAutoScroll = YES;
    [self startTimerWithDuration:duration];
}

- (void)startTimerWithDuration:(CGFloat)duration {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(animationStart) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.isTimerStarting = YES;
}

- (void)endTimer {
    self.isTimerStarting = NO;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)animationStart {
    static NSInteger index = 1;
    NSInteger realNum = [self.dataSource SLCNormalCardViewNumberOfItems:self];
    NSInteger num = floor(realNum * 5000);
    [self scrollToItemAtIndex:(index + num) animated:YES];
    index ++;
}

- (void)dealloc {
    [self endTimer];
}



@end
