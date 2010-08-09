//
//  TestVC.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/06.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "TestVC.h"
#import "BKBitmapImageRep.h"

//Private
@interface TestVC ()
-(void)_setup;
@end

@implementation TestVC
@synthesize imageView = _imageView;
@synthesize imageRep = _imageRep;
@synthesize imagePickerPopover = _imagePickerPopover;

//Override
-(id)init{
	//NSLog(@"%s", __FUNCTION__);
	
	UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
	
	if (idiom == UIUserInterfaceIdiomPad) {
		//ipad
		return [self initWithNibName:@"TestVC-iPad" bundle:nil];
	}
	else{
		//iphone
		return [self initWithNibName:@"TestVC" bundle:nil];
	}
	
	return nil;
}

//Override
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	//NSLog(@"%s", __FUNCTION__);
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
		[self _setup];
	}
	return self;
}

-(IBAction)buttonPressed:(id)sender{
	//NSLog(@"%s", __FUNCTION__);

	if (_idiom == UIUserInterfaceIdiomPad) {
		//ipad
		[self presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender];
	}
	else{
		//iphone
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
		imagePicker.allowsEditing = NO;
		imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:imagePicker animated:YES];
		[imagePicker release];
	}
}

- (void)dealloc {
	self.imageView = nil;
	self.imageRep = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Private

-(void)_setup{
	//NSLog(@"%s", __FUNCTION__);
	
	_idiom = [[UIDevice currentDevice] userInterfaceIdiom];
}

#pragma mark -
#pragma mark UIResponder

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event{
	NSLog(@"%s", __FUNCTION__);
	
	UITouch *touch = [touches anyObject];
	CGPoint p = [touch locationInView:self.imageView];
	
	
	NSUInteger pixelData[4];
	[self.imageRep getPixel:pixelData atX:p.x y:p.y];
	NSLog(@"r: %d g: %d b: %d a: %d", pixelData[0], pixelData[1], pixelData[2], pixelData[3]);
}

- (void)touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event{
	[self touchesBegan:touches withEvent:event];
}


@end
