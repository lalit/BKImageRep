//
//  BKBitmapImageRep-Accessors.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/06.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKBitmapImageRep-Accessors.h"
#import "BKColorSpace.h"

@implementation BKBitmapImageRep (Accessors)

//IMCOMPLETE!!
-(BKBitmapFormat)bitmapFormat{
	NSLog(@"%s is not completely implemented. Do not use.", __FUNCTION__);
	
	if (_bitmapInfo == kCGImageAlphaNone) {
	}
	
	if (_bitmapInfo == kCGImageAlphaPremultipliedLast) {
		return (~BKAlphaFirstBitmapFormat | ~BKAlphaNonpremultipliedBitmapFormat | ~BKFloatingPointSamplesBitmapFormat);
	}
	
	if (_bitmapInfo == kCGImageAlphaPremultipliedFirst) {
		return (BKAlphaFirstBitmapFormat | ~BKAlphaNonpremultipliedBitmapFormat | ~BKFloatingPointSamplesBitmapFormat);
	}
	
	if (_bitmapInfo == kCGImageAlphaLast) {
		return (~BKAlphaFirstBitmapFormat | BKAlphaNonpremultipliedBitmapFormat | ~BKFloatingPointSamplesBitmapFormat);
	}
	
	if (_bitmapInfo == kCGImageAlphaFirst) {
		return (BKAlphaFirstBitmapFormat | BKAlphaNonpremultipliedBitmapFormat | ~BKFloatingPointSamplesBitmapFormat);
	}
	
	if (_bitmapInfo == kCGImageAlphaNoneSkipLast) {
	}
	
	if (_bitmapInfo == kCGImageAlphaNoneSkipFirst) {
	}
	
	if (_bitmapInfo == kCGImageAlphaOnly) {
	}
	
	//Default format is equivallent to that defined as kCGImageAlphaPremultipliedLast.
	return (~BKAlphaFirstBitmapFormat | ~BKAlphaNonpremultipliedBitmapFormat | ~BKFloatingPointSamplesBitmapFormat);
}

-(BOOL)isPlanar{
	return NO;
}

-(NSInteger)numberOfPlanes{
	return 1;
}

-(NSInteger)bytesPerPlane{
	return _pixelsHigh * _bytesPerRow;
}

-(UIImage *)image{
	NSLog(@"%s", __FUNCTION__);
	
	CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, _bitmapData, _pixelsHigh * _bytesPerRow, NULL);
	CGImageRef cgImage = CGImageCreate(_pixelsWide, 
									   _pixelsHigh, 
									   _bitsPerSample, 
									   _bitsPerPixel, 
									   _bytesPerRow, 
									   _colorSpace.CGColorSpace, 
									   _bitmapInfo, 
									   dataProvider, 
									   NULL, 
									   YES, 
									   kCGRenderingIntentDefault);
	
	CGDataProviderRelease(dataProvider);
	UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
	CGImageRelease(cgImage);
	
	return uiImage;
}

-(void)setImage:(UIImage *)anImage{
	NSLog(@"%s", __FUNCTION__);
	
	CGImageRef cgImage = [anImage CGImage];
	CGContextRef context = CGBitmapContextCreate(_bitmapData, 
												 _pixelsWide, 
												 _pixelsHigh, 
												 _bitsPerSample, 
												 _bytesPerRow, 
												 _colorSpace.CGColorSpace, 
												 _bitmapInfo);
	
	//The image will be disproportionately drwan in the specific rectangle.
	CGContextDrawImage(context, CGRectMake(0, 0, _pixelsWide, _pixelsHigh), cgImage);
	CGContextRelease(context);
}
 
@end
