//
//  WelcomeVC.h
//  schedule
//
//  Created by Prince on 5/30/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeVC : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property NSArray *pages;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@end
