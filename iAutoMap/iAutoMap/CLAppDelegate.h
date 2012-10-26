//
//  CLAppDelegate.h
//  iAutoMap
//
//  Created by Oleg Kalashnik on 26.10.12.
//  Copyright (c) 2012 Oleg Kalashnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLViewController;

@interface CLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CLViewController *viewController;

@end
