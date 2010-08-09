//
//  BKBitmapImageRep-Utilities.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/06.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKBitmapImageRep-Utilities.h"
#import "BKColorSpace.h"

//Private
@interface BKBitmapImageRep ()
-(NSUInteger)_bitmapDataIndexAtX:(NSInteger)x y:(NSInteger)y;
@end

@implementation BKBitmapImageRep (Utilities)

//Reimplement
-(void)setColor:(UIColor *)color atX:(NSInteger)x y:(NSInteger)y{
	//The point is out of the image pixel. Nothing should be done.
	if (!CGRectContainsPoint(CGRectMake(0, 0, _pixelsWide, _pixelsHigh), CGPointMake(x, y))) {
		return;
	}
	
	NSUInteger index = [self _bitmapDataIndexAtX:x y:y];
	const CGFloat *samples = CGColorGetComponents(color.CGColor);

	if (_colorSpaceName == BKDeviceWhiteColorSpace) {
		_bitmapData[index + 0] = round(samples[0] * 255);
	}
	else{
		_bitmapData[index + 0] = round(samples[0] * 255);//r
		_bitmapData[index + 1] = round(samples[1] * 255);//g
		_bitmapData[index + 2] = round(samples[2] * 255);//b
		_bitmapData[index + 3] = round(samples[3] * 255);//a
	}
}

//Reimplement
-(UIColor *)colorAtX:(NSInteger)x y:(NSInteger)y{
	//The point is out of the image pixel. Nothing should be done.
	if (!CGRectContainsPoint(CGRectMake(0, 0, _pixelsWide, _pixelsHigh), CGPointMake(x, y))) {
		return nil;
	}
	
	NSUInteger index = [self _bitmapDataIndexAtX:x y:y];
	CGFloat r = _bitmapData[index + 0] / 255.0;
	CGFloat g = _bitmapData[index + 1] / 255.0;
	CGFloat b = _bitmapData[index + 2] / 255.0;
	CGFloat a = _bitmapData[index + 3] / 255.0;

	if (_colorSpaceName == BKDeviceWhiteColorSpace) {
		return [UIColor colorWithWhite:r alpha:1.0];
	}
	else{
		return [UIColor colorWithRed:r green:g blue:b alpha:a];			
	}
}

//Reimplement
-(void)setPixel:(NSUInteger[])pixelData atX:(NSInteger)x y:(NSInteger)y{
	//The point is out of the image pixel. Nothing should be done.
	if (!CGRectContainsPoint(CGRectMake(0, 0, _pixelsWide, _pixelsHigh), CGPointMake(x, y))) {
		return;
	}
	
	NSUInteger index = [self _bitmapDataIndexAtX:x y:y];
	
	if (_colorSpaceName == BKDeviceWhiteColorSpace) {
		_bitmapData[index + 0] = pixelData[0];
	}
	else{
		_bitmapData[index + 0] = pixelData[0];
		_bitmapData[index + 1] = pixelData[1];
		_bitmapData[index + 2] = pixelData[2];
		_bitmapData[index + 3] = pixelData[3];
	}
}

//Reimplement
-(void)getPixel:(NSUInteger[])pixelData atX:(NSInteger)x y:(NSInteger)y{
	//The point is out of the image pixel. Nothing should be done.
	if (!CGRectContainsPoint(CGRectMake(0, 0, _pixelsWide, _pixelsHigh), CGPointMake(x, y))) {
		return;
	}
	
	NSUInteger index = [self _bitmapDataIndexAtX:x y:y];
	int r = _bitmapData[index + 0];
	int g = _bitmapData[index + 1];
	int b = _bitmapData[index + 2];
	int a = _bitmapData[index + 3];
	
	if (_colorSpaceName == BKDeviceWhiteColorSpace) {
		pixelData[0] = r;
	}
	else{
		pixelData[0] = r;
		pixelData[1] = g;
		pixelData[2] = b;
		pixelData[3] = a;
	}
}

#pragma mark -
#pragma mark Private

//Avoid the boundary problem.
//x can be in the range between 0 and _pixelWide, while pixel indices in a given row are from 0 to (_pixelWide -1), y respectively.
-(NSUInteger)_bitmapDataIndexAtX:(NSInteger)x y:(NSInteger)y{
	int bytesPerPixel = _bitsPerPixel / 8;
	
	if (x >= _pixelsWide){
		x = _pixelsWide - 1;
	}
	
	if (y >= _pixelsHigh){
		y = _pixelsHigh - 1;
	}
	
	return _bytesPerRow * y + bytesPerPixel * x;
}

@end
