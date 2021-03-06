//
//  SLCAnimationCardView.h
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/11.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLCAnimationCardView;

@protocol SLCAnimationCardViewDataSource<NSObject>

- (NSInteger)SLCAnimationCardViewNumberOfItems:(SLCAnimationCardView *)cardView;

- (UICollectionViewCell *)SLCAnimationCardView:(SLCAnimationCardView *)cardView
                                   itemAtIndex:(NSInteger)index;
@end

@protocol SLCAnimationCardViewDelegate<NSObject>

@optional;

- (void)SLCAnimationCardView:(SLCAnimationCardView *)cardView
  didSelectItemAtIndex:(NSInteger)index;

- (void)SLCAnimationCardView:(SLCAnimationCardView *)cardView
         currentIndexChanged:(NSInteger)currentIndex;
@end

@interface SLCAnimationCardView : UIView

/**数据源*/
@property (nonatomic, weak) id<SLCAnimationCardViewDataSource> dataSource;
/**代理*/
@property (nonatomic, weak) id<SLCAnimationCardViewDelegate> delegate;

/**宽度比例 -- 放大占总体的*/
@property (nonatomic, assign) CGFloat widthScale;
/**高度比 -- 放大占总体的*/
@property (nonatomic, assign) CGFloat heightScale;
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
@end
