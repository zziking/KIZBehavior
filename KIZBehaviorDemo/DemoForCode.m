//
//  DemoForCode.m
//  KIZBehaviorDemo
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 kingizz. All rights reserved.
//

#import "DemoForCode.h"
#import "KIZNavBarGradientBehavior.h"
#import "KIZParallaxHeaderBehavior.h"
#import "KIZMultipleProxyBehavior.h"

@interface DemoForCode ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KIZParallaxHeaderBehavior *parallaxBehavior;
@property (nonatomic, strong) KIZNavBarGradientBehavior *navBehavior;
@property (nonatomic, strong) KIZMultipleProxyBehavior *behaviors;

@end

@implementation DemoForCode

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hashiqi"]];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    [self.view addSubview:imageView];
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    tableHeader.backgroundColor = [UIColor clearColor];
    
    //视图放大缩小视差效果
    KIZParallaxHeaderBehavior *parallaxBehavior = [[KIZParallaxHeaderBehavior alloc] init];
    parallaxBehavior.targetView = imageView;
    self.parallaxBehavior = parallaxBehavior;
    
    //导航栏渐变效果
    KIZNavBarGradientBehavior *navBehavior = [[KIZNavBarGradientBehavior alloc] init];
//    navBehavior.criticalOffset = 400;
    navBehavior.owner = self;
    self.navBehavior = navBehavior;
    
    //代理转发的目标，会将事件转发到所有能处理事件的代理对象，因为多重代理对象内部不会强引用数组中的对象，所以数组中的self不会用循环引用，同时，其他behavior需要在此controller中强引用，防止被释放
    NSArray *delegates = @[self, parallaxBehavior, navBehavior];
    KIZMultipleProxyBehavior *behaviors = [[KIZMultipleProxyBehavior alloc] init];
    behaviors.delegateTargets = delegates;
    self.behaviors = behaviors;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = (id<UITableViewDataSource>)self.behaviors;
    tableView.delegate   = (id<UITableViewDelegate>)self.behaviors;
    tableView.tableHeaderView = tableHeader;
    tableView.backgroundColor = [UIColor clearColor];
//    [tableView insertSubview:imageView atIndex:0];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navBehavior onViewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navBehavior onViewWillDisAppear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

@end
