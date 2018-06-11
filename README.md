# SLCCardView

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) [![CocoaPods compatible](https://img.shields.io/cocoapods/v/SLCCardView.svg?style=flat)](https://cocoapods.org/pods/SLCCardView) [![License: MIT](https://img.shields.io/cocoapods/l/SLCCardView.svg?style=flat)](http://opensource.org/licenses/MIT)

横向滑动卡片视图

` pod 'SLCCardView' `
## 正常视图

` #import <SLCCardView/SLCNormalCardView.h> `
初始化,用法同CollectionView:
```
- (SLCNormalCardView *)normalCardView {
if (!_normalCardView) {
_normalCardView = [[SLCNormalCardView alloc] initWithFrame:self.view.bounds];
_normalCardView.delegate = self;
_normalCardView.dataSource = self;
_normalCardView.lineSpacing = 15;
_normalCardView.interitemSpacing = 15;
_normalCardView.sectionInsert = UIEdgeInsetsMake(0, 20, 0, 15);
_normalCardView.itemSize = CGSizeMake(300, 500);
_normalCardView.pageEnable = YES;

[_normalCardView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identify"];
}
return _normalCardView;
}
```
因为用UICollectionView完成的,注册的类需是UICollectionViewCell类型.
设置个数和视图:
```
- (NSInteger)SLCNormalCardViewNumberOfItems:(SLCNormalCardView *)cardView {
return 5;
}

- (UICollectionViewCell *)SLCNormalCardView:(SLCNormalCardView *)cardView itemAtIndex:(NSInteger)index {

UICollectionViewCell *cell = [cardView dequeueReusableItemWithReuseIdentifier:@"identify" forIndex:index];

if (index == 0) {
cell.backgroundColor = [UIColor redColor];
}else if (index == 1) {
cell.backgroundColor = [UIColor greenColor];
}else if (index == 2) {
cell.backgroundColor = [UIColor purpleColor];
}else if (index == 3) {
cell.backgroundColor = [UIColor blueColor];
}else if (index == 4) {
cell.backgroundColor = [UIColor blackColor];
}
return cell;
}
```
代理回调:(点击和正中坐标)
```
- (void)SLCNormalCardView:(SLCNormalCardView *)cardView didSelectItemAtIndex:(NSInteger)index {
NSLog(@"选了%ld",index);
}

- (void)SLCNormalCardView:(SLCNormalCardView *)cardView currentIndexChanged:(NSInteger)currentIndex {
NSLog(@"变了%ld",currentIndex);
}
```
![Alt text](https://github.com/WeiKunChao/SLCCardView/raw/master/screenShort/1.gif).

当设置`loopEnable属性为YES时`,开启无限循环.
` _normalCardView.loopEnable = YES; `

![Alt text](https://github.com/WeiKunChao/SLCCardView/raw/master/screenShort/2.gif).

当调用` autoAnmitionWithDuration: `方法,自动滚动.变量是时间间隔.

## 滑动缩放卡片效果
` #import <SLCCardView/SLCAnimationCardView.h> `
使用同上:
```
- (SLCAnimationCardView *)animationView {
if (!_animationView) {
_animationView = [[SLCAnimationCardView alloc] initWithFrame:self.view.bounds];
_animationView.dataSource = self;
_animationView.delegate = self;
_animationView.itemSize = CGSizeMake(300, 500);
_animationView.lineSpacing = 15;
_animationView.interitemSpacing = 15;
_animationView.sectionInsert = UIEdgeInsetsMake(0, 20, 0, 20);
_animationView.widthScale = 0.7;
_animationView.heightScale = 0.8;
_animationView.pageEnable = YES;

[_animationView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identify"];
}
return _animationView;
}
```
上述,`widthScale`属性和`heightScale`属性分别指放大的那个所占整个的比例.而itemSize指的是正常大小.

布局与代理都同上.

![Alt text](https://github.com/WeiKunChao/SLCCardView/raw/master/screenShort/3.gif).
