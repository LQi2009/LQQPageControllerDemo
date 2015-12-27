//
//  PhotoReviewViewController.h
//  ArtronUp
//
//  Created by Artron_LQQ on 15/12/21.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoReviewViewController : UIViewController<UIPageViewControllerDataSource>
{
    UIPageViewController * pageController;
    NSMutableArray * pageContent;
}
@property(strong,nonatomic)UIPageViewController * pageController;
@property(strong,nonatomic)NSMutableArray * pageContent;

@property (strong,nonatomic)NSMutableArray *assetsArray;


@property (nonatomic,copy)NSString *flyleafStrig;
@end
