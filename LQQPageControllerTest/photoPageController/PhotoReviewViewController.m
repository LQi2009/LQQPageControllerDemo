//
//  PhotoReviewViewController.m
//  ArtronUp
//
//  Created by Artron_LQQ on 15/12/21.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//
/*
 
 以实物翻书的形式展示照片书的翻页效果
 
 */
#import "PhotoReviewViewController.h"
#import "ContentViewController.h"

@interface PhotoReviewViewController ()

@end

@implementation PhotoReviewViewController
@synthesize pageContent,pageController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupNavigationBar];
    [self creatBackgroundView];
    
}

-(void)setupNavigationBar
{
    //导航背景
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //标题
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectZero];
    
    //    CGRect rect = [titleLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 200, 44) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleLab.font} context:nil];
    titleLab.text = @"预览";
    titleLab.center = CGPointMake(self.view.frame.size.width/2.0, 44);
    titleLab.bounds = CGRectMake(0, 0, 150, 40);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:16];
    //    titleLab.textColor = kUIColorFromRGB(0x3A3A3A);
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
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatBackgroundView
{
    
    //    初始化pageController
    NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageController = [[UIPageViewController alloc]initWithTransitionStyle:(UIPageViewControllerTransitionStylePageCurl) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:options];
    pageController.dataSource = self;
    
    ContentViewController * initialViewController = [self viewCintrollerAtIndex:0];
    ContentViewController * endViewController = [self viewCintrollerAtIndex:1];
    
    //    pageController.doubleSided = YES;
    
    NSArray * viewControllers = [NSArray arrayWithObjects:initialViewController,endViewController,nil];
    [pageController setViewControllers:viewControllers direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
    
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    [pageController didMoveToParentViewController:self];
    
    pageController.view.center = self.view.center;
    pageController.view.bounds = CGRectMake(0, 0, 300/480.0 * self.view.frame.size.height, 200/320.0 * self.view.frame.size.width);
    
    pageController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    

//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.bounds = CGRectMake(0, 0, 60, 30);
//    backBtn.center = CGPointMake(pageController.view.center.x + pageController.view.frame.size.width/2.0 + backBtn.bounds.size.width/2.0 ,pageController.view.center.y - pageController.view.frame.size.height/2.0);
//    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//    //    backBtn.backgroundColor = [UIColor redColor];
//    [backBtn addTarget:self action:@selector(backBtnClick1) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
//    [self.view addSubview:backBtn];
    
}
-(void)backBtnClick1
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (ContentViewController *)viewCintrollerAtIndex:(NSUInteger)index{
    if ([self.pageContent count] == 0 || (index >= [self.pageContent count])) {
        return nil;
    }
    //    if (index == 0) {
    //        ContentImageViewVC * dataViewController = [[ContentImageViewVC alloc]initWithNibName:@"ContentImageViewVC" bundle:nil];
    //        dataViewController.view.backgroundColor = [UIColor lightGrayColor];
    //
    //        dataViewController.dataObject = [self.pageContent objectAtIndex:0];
    //
    //        return dataViewController;
    //    }
    //    else
    {
        ContentViewController * dataViewController = [[ContentViewController alloc]init];
        
        
        if (index == 0 || index == self.pageContent.count - 1) {
            
            dataViewController.view.backgroundColor = [UIColor lightGrayColor];
        }
        else
        {
            dataViewController.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.0  green:arc4random() % 255 /255.0 blue:arc4random() % 255 /255.0 alpha:1];
        }
        
        dataViewController.showImageView.image = [self.pageContent objectAtIndex:index];
        
        if (index == 1) {
            
        }
        else if (index == 3)
        {
            dataViewController.showImageView.hidden = YES;
//            dataViewController.flyleafLabel.text = self.flyleafStrig;
        }
        
        else if (index < self.pageContent.count - 2 && index > 2)
        {
//            dataViewController.pageLabel.text = [NSString stringWithFormat:@"%d",index - 3];
        }
        else if (index == self.pageContent.count - 2)
        {
//            dataViewController.pageLabel.text = @"封底";
        }
        else
        {
//            dataViewController.pageLabel.text = @"";
        }
        dataViewController.dataObject = [self.pageContent objectAtIndex:index];
        
        return dataViewController;
        
    }
}
- (NSUInteger)indexOfViewController:(ContentViewController*)viewController
{
    return  [self.pageContent indexOfObject:viewController.dataObject];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewCintrollerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index --;
    return [self viewCintrollerAtIndex:index];
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
