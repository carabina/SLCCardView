//
//  SLCFixCardPagingPositionManager.h
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/10.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SLCFixCardPagingPositionManager : NSObject
@property (nonatomic, assign) NSInteger selectedIndex;


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

- (void)fixBegingDragging;
- (void)fixEndDragging;
- (void)fixScroll;
@end
