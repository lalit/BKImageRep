//
//  TestVC.h
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/06.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BKBitmapImageRep;

/**
 * Test view cotroller for BKImageRep library.
 */
@interface TestVC : UIViewController {
	IBOutlet UIImageView *_imageView;
	BKBitmapImageRep *_imageRep;
	UIPopoverController *_imagePickerPopover;
	UIUserInterfaceIdiom _idiom;
}
@property (nonatomic, assign) UIImageView *imageView;
@property (nonatomic, retain) BKBitmapImageRep *imageRep;
@property (nonatomic, retain) UIPopoverController *imagePickerPopover;

-(IBAction)buttonPressed:(id)sender;
@end

#import "TestVC-UIPopoverControllerDelegate.h"
#import "TestVC-UIImagePickerControllerDelegate.h"