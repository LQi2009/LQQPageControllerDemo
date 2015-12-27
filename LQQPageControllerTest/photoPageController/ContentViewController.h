//
//  ContentViewController.h
//  ArtronUp
//
//  Created by Artron_LQQ on 15/12/21.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

//@property (nonatomic,retain)UIImage *showImage;
@property (retain,nonatomic)id dataObject;

@property (strong,nonatomic) UIImageView *showImageView;
@property (strong,nonatomic) UILabel *flyleafLabel;
//@property (strong,nonatomic) UILabel *pageLabel;
@end
