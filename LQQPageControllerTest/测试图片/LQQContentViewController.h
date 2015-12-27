//
//  LQQContentViewController.h
//  LQQPageControllerTest
//
//  Created by Artron_LQQ on 15/12/26.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//
/**
 *  @author LQQ, 15-12-26 19:12:41
 *
 *  此类为需要展示的视图,可根据需求定制
 *  可在此类中直接增加需要显示的元素,只要在创建是配置好数据即可
 *
 *
 *
 *  @return return value description
 */
#import <UIKit/UIKit.h>

@interface LQQContentViewController : UIViewController

/**
 *  @author LQQ, 15-12-26 18:12:19
 *
 *  这个属性主要是用于返回创建的对象在数据源数组中的索引,不属于显示的内容,但是必须要有
 */
@property (retain,nonatomic)id LQQ_dataObject;

/**
 *  @author LQQ, 15-12-26 18:12:51
 *
 *  自定义布局的内容
 */
@property (weak, nonatomic) IBOutlet UIImageView *LQQ_imageView;
//@property (nonatomic,weak)IBOutlet UIImage *LQQ_image;
@end
