//
//  TestVC-UIImagePickerControllerDelegate.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/06.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "TestVC-UIImagePickerControllerDelegate.h"
#import "BKBitmapImageRep.h"
#import "BKColorSpace.h"
 
//Private
@interface TestVC ()
-(void)_dismissImagePicker:(UIImagePickerController *)picker;
-(void)_allocateImageDirectlyFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView;
-(void)_allocateImageByPasteboardFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView;
-(void)_allocateImageByImageRepFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView;
-(void)_allocateImageByPasteboardAndImageRepFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView;
@end

@implementation TestVC (UIImagePickerControllerDelegate)

- (void)imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *) info{
	//NSLog(@"%s", __FUNCTION__);
	
	UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	//[self _allocateImageDirectlyFromImage:originalImage toImageView:self.imageView];
	//[self _allocateImageByImageRepFromImage:originalImage toImageView:self.imageView];
	//[self _allocateImageByPasteboardFromImage:originalImage toImageView:self.imageView];
	[self _allocateImageByPasteboardAndImageRepFromImage:originalImage toImageView:self.imageView];
	
	[self _dismissImagePicker:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) picker{
	[self _dismissImagePicker:picker];
}

#pragma mark -
#pragma mark Private

-(void)_dismissImagePicker:(UIImagePickerController *)picker{
	if (_idiom == UIUserInterfaceIdiomPad){
		//ipad
		[self.imagePickerPopover dismissPopoverAnimated:YES];
	}
	else{
		//iphone
		[picker dismissModalViewControllerAnimated:YES];
	}
}

-(void)_allocateImageDirectlyFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView{
	NSLog(@"%s", __FUNCTION__);
	
	toImageView.image = anImage;
}

-(void)_allocateImageByImageRepFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView{
	NSLog(@"%s", __FUNCTION__);
	
	self.imageRep = [[[BKBitmapImageRep alloc] initWithImage:anImage] autorelease];
	toImageView.image = self.imageRep.image;
}

-(void)_allocateImageByPasteboardFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView{
	NSLog(@"%s", __FUNCTION__);
	
	[[UIPasteboard generalPasteboard] setImage:anImage];
	toImageView.image = [[UIPasteboard generalPasteboard] image];
}

-(void)_allocateImageByPasteboardAndImageRepFromImage:(UIImage *)anImage toImageView:(UIImageView *)toImageView{
	NSLog(@"%s", __FUNCTION__);
	
	//[[UIPasteboard generalPasteboard] setData:UIImagePNGRepresentation(anImage) forPasteboardType:@"imageData"];
	[[UIPasteboard generalPasteboard] setImage:anImage];
	//[[UIPasteboard generalPasteboard] setValue:@"aaa" forPasteboardType:@"bbb"];//Test
	
	self.imageRep = [BKBitmapImageRep imageRepWithPasteboard:[UIPasteboard generalPasteboard]];
	toImageView.image = self.imageRep.image;
}
@end
