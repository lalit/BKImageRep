//
//  TestVC-UIPopoverControllerDelegate.h
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/06/10.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestVC.h"

@interface TestVC (UIPopoverControllerDelegate) <UIPopoverControllerDelegate>

-(void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item;
@end
