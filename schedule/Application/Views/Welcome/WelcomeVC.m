//
//  WelcomeVC.m
//  schedule
//
//  Created by Prince on 5/30/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import "WelcomeVC.h"

@interface WelcomeVC ()

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController *welcomeFirstVC  = [self viewControllerAtIndex:0];
    UIViewController *welcomeSecondVC = [self viewControllerAtIndex:0];
    
    self.pages = @[welcomeFirstVC, welcomeSecondVC];
    
    NSArray *viewControllers = @[welcomeFirstVC];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.startButton.frame.origin.y);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    UIViewController *viewController;
    
    switch (index) {
        case 1:
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeSecondVC"];
            break;
        default:
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeFirstVC"];
            break;
    }
    
    return viewController;
}

#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    NSInteger index = [self.pages indexOfObject:viewController];
    
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.pages indexOfObject:viewController];
    
    if (index == self.pages.count - 1 || index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    return [self viewControllerAtIndex:index];
}

#pragma mark - Page Indicator

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.pages.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
