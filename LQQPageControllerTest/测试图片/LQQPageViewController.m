//
//  LQQPageViewController.m
//  LQQPageControllerTest
//
//  Created by Artron_LQQ on 15/12/26.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//
/**
 *  @author LQQ, 15-12-26 18:12:23
 *
 *  此类主要是用于创建UIPageViewController 以及控制显示的内容
 *
 *  因为需要翻转视图90°,如果不使用xib,而且使用view.frame CGRectMake ,会使视图显示不正常
 
 *  所以可以选择使用xib,或者masonry添加约束也可
 *
 *  @return return value description
 */


#import "LQQPageViewController.h"
#import "LQQContentViewController.h"

@interface LQQPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic,retain) UIPageViewController *LQQ_pageViewController;

@end

@implementation LQQPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupMainView];
    [self setupNavigationBar];
}
#warning 设置导航,可根据需求自定义
-(void)setupNavigationBar
{
    //导航背景
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //标题
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLab.text = @"预览";
    titleLab.center = CGPointMake(self.view.frame.size.width/2.0, 44);
    titleLab.bounds = CGRectMake(0, 0, 150, 40);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:16];
    [view addSubview:titleLab];
    
    //左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 60, 44);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:leftBtn];
}
//返回按钮点击事件
-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupMainView
{
    //    初始化pageController
    /**
     *  @author LQQ, 15-12-26 18:12:44
     *
     *  UIPageViewControllerSpineLocationMin 单页显示
     
        UIPageViewControllerSpineLocationMid 双页显示
     */
    NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    self.LQQ_pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:(UIPageViewControllerTransitionStylePageCurl) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:options];
    
    /**
     *  @author LQQ, 15-12-26 19:12:51
     *
     *  此属性默认是NO,当options中选择UIPageViewControllerSpineLocationMid时,其值默认为YES
     */
//    self.LQQ_pageViewController.doubleSided = NO;
    
    self.LQQ_pageViewController.dataSource = self;
    self.LQQ_pageViewController.delegate = self;
    
    LQQContentViewController * initialViewController = [self viewCintrollerAtIndex:0];
    LQQContentViewController * endViewController = [self viewCintrollerAtIndex:1];
    
    NSArray * viewControllers = [NSArray arrayWithObjects:initialViewController,endViewController,nil];
    
    [self.LQQ_pageViewController setViewControllers:viewControllers direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
    
    [self addChildViewController:self.LQQ_pageViewController];
    [self.view addSubview:self.LQQ_pageViewController.view];
    [self.LQQ_pageViewController didMoveToParentViewController:self];

#warning -- 以下主要是设置pageViewController的位置及大小,可根据需求更改
    self.LQQ_pageViewController.view.center = CGPointMake(self.view.center.x, self.view.center.y + 32);
    self.LQQ_pageViewController.view.bounds = CGRectMake(0, 0, self.view.frame.size.height - 104, self.view.frame.size.width - 20);
    self.LQQ_pageViewController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
}
//返回一个视图
- (LQQContentViewController *)viewCintrollerAtIndex:(NSUInteger)index
{
    if ([self.LQQ_pageContent count] == 0 || (index >= [self.LQQ_pageContent count]))
    {
        return nil;
    }
    
    LQQContentViewController * dataViewController = [[LQQContentViewController alloc]init];
    
    //如果去掉这个if-else 照片无法正常显示,原因暂不明确
    if (index == 0 || index == self.LQQ_pageContent.count - 1)
    {
#warning 如果不需要显示第一页和最后一页,就将第一页的背景色与viewController一致,或者隐藏掉,这样才会有看到书的封面和封底的效果
        dataViewController.view.backgroundColor = [UIColor greenColor];
    }
    else
    {
#warning 其他页的一些设置,即使不需要设置什么,也要随机设置个背景色或者其他属性,否则会显示不正常
        dataViewController.view.backgroundColor = [UIColor purpleColor];
    }

#warning -- 配置数据源
    dataViewController.LQQ_imageView.image = [self.LQQ_pageContent objectAtIndex:index];
    
    //这句必须有,且只能这么写
    dataViewController.LQQ_dataObject = [self.LQQ_pageContent objectAtIndex:index];
    
    return dataViewController;
}
//获取当前页的索引
- (NSUInteger)indexOfViewController:(LQQContentViewController*)viewController
{
    return  [self.LQQ_pageContent indexOfObject:viewController.LQQ_dataObject];
}

#pragma mark -- UIPageViewController 数据源方法
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(LQQContentViewController *)viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index --;
    return [self viewCintrollerAtIndex:index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(LQQContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.LQQ_pageContent count]) {
        return nil;
    }
    return [self viewCintrollerAtIndex:index];
}

/**
 *  @author LQQ, 16-12-28 14:12:32
 *
 *  在点击翻页过快时会出现,控制台输出:Unbalanced calls to begin/end appearance transitions for <LQQContentViewController: 0x7fe4e2e35e20>
 *
 *  这是因为上一个控制器的动画还未完成,就开始了下一个控制器的动画
 *  解决的方法是在上一个控制器动画的时候,暂时关闭视图的交互性,在动画结束后再打开
 *  主要用到了他的下面两个代理方法
 */
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    // 将要开始动画的时候关闭视图的交互性
    pageViewController.view.userInteractionEnabled = NO;
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //动画结束后打开交互
    if (finished) {
        pageViewController.view.userInteractionEnabled = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
