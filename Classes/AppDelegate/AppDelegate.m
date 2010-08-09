//
//  AppDelegate.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/05.
//  Copyright boreal-kiss.com 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "TestVC.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	_window.backgroundColor = [UIColor whiteColor];
	_viewController = [[TestVC alloc] init];
	[_window addSubview:_viewController.view];
    [_window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [_viewController release];
    [_window release];
    [super dealloc];
}


@end
