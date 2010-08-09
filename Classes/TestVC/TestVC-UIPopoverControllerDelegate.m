//
//  TestVC-UIPopoverControllerDelegate.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/06/10.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "TestVC-UIPopoverControllerDelegate.h"


@implementation TestVC (UIPopoverControllerDelegate) 

-(void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item{
	[self.imagePickerPopover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark -
#pragma mark UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *) popoverController{
	
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *) popoverController{
	return YES;
}

#pragma mark -
#pragma mark Accessors

-(UIPopoverController *)imagePickerPopover{
	if (_imagePickerPopover == nil) {
		
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
		imagePicker.allowsEditing = NO;
		imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		
		_imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
		_imagePickerPopover.delegate = self;
		_imagePickerPopover.popoverContentSize = CGSizeMake(320, 216);//Size of a default picker.
		
		[imagePicker release];
	}
	return _imagePickerPopover;
}

@end
