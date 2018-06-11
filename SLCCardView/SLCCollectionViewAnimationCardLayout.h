//
//  SLCCollectionViewAnimationCardLayout.h
//  WKCCollectionViewFlowLayout
//
//  Created by 魏昆超 on 2018/6/10.
//  Copyright © 2018年 WeiKunChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLCFixCardPagingPositionManager.h"

@interface SLCCollectionViewAnimationCardLayout : UICollectionViewFlowLayout

/**宽度比例 -- 放大占总体的*/
@property (nonatomic, assign) CGFloat widthScale;
/**高度比 -- 放大占总体的*/
@property (nonatomic, assign) CGFloat heightScale;


/**指定滑行*/
- (void)scrollToItemAtIndex:(NSInteger)index
                   animated:(BOOL)animated;

@end
