//
//  ViewController.m
//  LQQPageControllerTest
//
//  Created by Artron_LQQ on 15/12/26.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//
/**
 *  @author LQQ, 15-12-26 17:12:52
 *
 *  假设需求:
      以书本翻页的形式展示内容(以图片为例,可以修改需要展示的Viewcontroller内容)
 *
 *  @return
 */


#import "ViewController.h"
#import "LQQPageViewController.h"

@interface ViewController ()
{
    NSMutableArray *previewImageArray;
    
    NSMutableArray *dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.\
    
    previewImageArray = [[NSMutableArray alloc]init];

    dataArray = [[NSMutableArray alloc]init];
    [dataArray addObject:[UIImage imageNamed:@"1.jpg"]];
    
    [dataArray addObject:[UIImage imageNamed:@"3.jpg"]];
    [dataArray addObject:[UIImage imageNamed:@"4.jpg"]];
    [dataArray addObject:[UIImage imageNamed:@"77.jpg"]];
    [dataArray addObject:[UIImage imageNamed:@"33.jpg"]];
    [dataArray addObject:[UIImage imageNamed:@"rr.jpg"]];
    [dataArray addObject:[UIImage imageNamed:@"88.jpg"]];
    [dataArray addObject:[UIImage imageNamed:@"2.jpg"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)btnClick
{
    [self resetPreviewImageArray];
    
    LQQPageViewController *page = [[LQQPageViewController alloc]init];
    page.LQQ_pageContent = previewImageArray;
    [self presentViewController:page animated:YES completion:nil];
}

/**
 *  @author LQQ, 15-12-26 17:12:20
 *
 *  创建需要传给pageController的数据源,只针对本demo
 1.pageViewController每次需返回2个控制器,因此传入的数组必须是偶数个
 2.因为要获得书本的形式展示内容,所以需要有空白页来填充数组,一是保证数组为偶数个;二是保证书本的合并与开启效果
 
 */
-(void)resetPreviewImageArray
{
    //移除原数组中所有对象
    [previewImageArray removeAllObjects];
    
    //先加入空的image对象
    int flog = 0;
    if (dataArray.count %2 == 1) {
        flog = 3;
    }
    else
    {
        flog = 4;
    }
    for (int i = 0; i < flog; i++) {
        UIImage *img = [[UIImage alloc]init];
        
        [previewImageArray addObject:img];
    }
    
    for (int i = 0; i < dataArray.count; i++) {
        [previewImageArray insertObject:[dataArray objectAtIndex:i] atIndex:i + 2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
