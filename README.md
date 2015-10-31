KIZBehavior
==================

KIZBehavior是基于组合设计模式，并且充分利用Interface Builder来实现某些功能的代码集，旨在通过低耦合、低侵入、组件化、少代码甚至无代码化的形式来实现一些功能。

KIZBehavior遵循组合模式，代码遵循功能单一原则并且可以使我们的类简化，可以通过组合多个behavior来定制较为复杂的效果，并且在Interface Builder中提供丰富的参数设置，无需编码也可以通过参数来调整效果。

更多关于Behavior模式的信息请看这篇文章：[iOS中的行为](http://objccn.io/issue-13-3/)  英文原版:[Behaviors in iOS Apps](https://www.objc.io/issues/13-architecture/behaviors/)

目前KIZBehavior实现的功能有：

1. `KIZParallaxHeaderBehavior`: UIScrollView 头部图片视差效果
2. `KIZNavBarGradientBehavior`: NavigationBar 透明渐变动画效果

###KIZParallaxHeaderBehavior
UIScrollView头部图片拉伸效果
####features

- [x] 0行代码集成
- [x] 图片等比例拉伸
- [x] IB设置视差效果参数

####How to Use
在IB中设置UIScrollView的delegate为KIZParallaxHeaderBehavior即可

![parallax header](http://7xjsf4.com1.z0.glb.clouddn.com/git_KIZBehavior_parallax.gif)


###KIZNavBarGradientBehavior
导航栏渐变动画效果
####features：

- [x] 导航栏透明度渐变
- [x] 导航栏上文字及图表的颜色渐变
- [x] 状态栏颜色变化
- [x] 自动保存初始及离开界面时的状态，退出或返回界面时自动恢复原来状态
- [x] IB设置相关参数

####How to use
在controller的`viewWillAppear ` 和 `viewWillDisappear `中分别调用两个方法，并且设置UISCrollView的delegate为KIZNavBarGradientBehavior即可

```Objective-C
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navBarBehavior onViewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navBarBehavior onViewWillDisAppear];
}
```

![NavigationBar animation](http://7xjsf4.com1.z0.glb.clouddn.com/git_KIZBehavior_navigationBar.gif)


###KIZParallaxHeaderBehavior + KIZNavBarGradientBehavior
组合效果
####How to use
需要设置UIScrollView的delegate为KIZMultipleProxyBehavior，并且将需要组合的behavior添加到MultipleProxyBehavior中即可。
![Parallax + NavigationBar](http://7xjsf4.com1.z0.glb.clouddn.com/git_KIZBehavior_parallax_nav.gif)
