//
//  SLCNormalCardView.h
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/11.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLCNormalCardView;

@protocol SLCNormalCardViewDataSource<NSObject>

- (NSInteger)SLCNormalCardViewNumberOfItems:(SLCNormalCardView *)cardView;

- (UICollectionViewCell *)SLCNormalCardView:(SLCNormalCardView *)cardView
                                   itemAtIndex:(NSInteger)index;
@end

@protocol SLCNormalCardViewDelegate<NSObject>

- (void)SLCNormalCardView:(SLCNormalCardView *)cardView
      didSelectItemAtIndex:(NSInteger)index;

- (void)SLCNormalCardView:(SLCNormalCardView *)cardView
      currentIndexChanged:(NSInteger)currentIndex;

@end

@interface SLCNormalCardView : UIView
/**数据源*/
@property (nonatomic, weak) id<SLCNormalCardViewDataSource> dataSource;
/**代理*/
@property (nonatomic, weak) id<SLCNormalCardViewDelegate> delegate;

/**横间距*/
@property (nonatomic, assign) CGFloat lineSpacing;
/**纵间距*/
@property (nonatomic, assign) CGFloat interitemSpacing;
/**边距*/
@property (nonatomic, assign) UIEdgeInsets sectionInsert;
/**正常size*/
@property (nonatomic, assign) CGSize itemSize;

/**背景图*/
@property (nonatomic, strong) UIImage * backgroundImage;
/**翻页*/
@property (nonatomic, assign) BOOL pageEnable;
/**collectionView边距*/
@property (nonatomic, assign) UIEdgeInsets contentInsert;


/**是否无限循环 -- 默认NO*/
@property (nonatomic, assign) BOOL loopEnable;


/**注册*/
- (void)registerClass:(Class)aClass
forCellWithReuseIdentifier:(NSString *)identify;

/**缓存池取*/
- (UICollectionViewCell *)dequeueReusableItemWithReuseIdentifier:(NSString *)identify
                                                        forIndex:(NSInteger)index;
/**刷新数据*/
- (void)reloadData;

/**滑行到指定某个*/
- (void)scrollToItemAtIndex:(NSInteger)index
                   animated:(BOOL)animated;

/**自动移动*/
- (void)autoAnmitionWithDuration:(CGFloat)duration;
@end
