//
//  DetailViewController.h
//  FMYouTubePlayerViewController
//
//  Created by fm.tonakai on 2012/08/26.
//  Copyright (c) 2012年 fm.tonakai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
