//
//  BKBitmapImageRep-PixelFormats.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/07/09.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKBitmapImageRep-PixelFormats.h"
#import "BKColorSpace.h"

//Private
static const int Number5	= 5;
static const int Number8	= 8;
static const int Number16	= 16;
static const int Number32	= 32;
static const int Number64	= 64;
static const int Number128	= 128;

@implementation BKBitmapImageRep (PixelFormats)

-(void)_bkArrangePixelFormatProperly{
	NSLog(@"%s", __FUNCTION__);
	
	if ([self _bkIsSupportedPixelFormat]){
		return;
	}
	
	NSLog(@"%s pixel format not supported. Will be rearranged.", __FUNCTION__);
	
	if (_colorSpace.colorSpaceModel == BKRGBColorSpaceModel) {
		if (_bitmapInfo == kCGImageAlphaNone) {
			
			//Modification neccesiated as the current pixel format is not supported in CGBitmapContext.
			_bitmapInfo = kCGImageAlphaNoneSkipLast;
			
			_bitsPerPixel = Number32;
			_bitsPerSample = Number8;
		}
	}
	
	if (_bitmapData != NULL) {
		free(_bitmapData);
	}
	
	_bytesPerRow = _pixelsWide * _bitsPerPixel / Number8;
	_bitmapData = calloc(1, _pixelsHigh * _bytesPerRow);
}

-(BOOL)_bkIsSupportedPixelFormat{
	NSLog(@"%s", __FUNCTION__);
	
	//Gray
	if (_bitsPerPixel == Number8 && _bitsPerSample == Number8 && _bitmapInfo == kCGImageAlphaNone) {
		return YES;
	}
	
	//Null
	if (_bitsPerPixel == Number8 && _bitsPerSample == Number8 && _bitmapInfo == kCGImageAlphaOnly) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number16 && _bitsPerSample == Number5 && _bitmapInfo == kCGImageAlphaNoneSkipFirst) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number32 && _bitsPerSample == Number8 && _bitmapInfo == kCGImageAlphaNoneSkipFirst) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number32 && _bitsPerSample == Number8 && _bitmapInfo == kCGImageAlphaNoneSkipLast) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number32 && _bitsPerSample == Number8 && _bitmapInfo == kCGImageAlphaPremultipliedFirst) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number32 && _bitsPerSample == Number8 && _bitmapInfo == kCGImageAlphaPremultipliedLast) {
		return YES;
	}
	
	//CMYK
	if (_bitsPerPixel == Number32 && _bitsPerSample == Number8 && _bitmapInfo == kCGImageAlphaNone) {
		return YES;
	}
	
	//Gray
	if (_bitsPerPixel == Number32 && _bitsPerSample == Number32 && _bitmapInfo == (kCGImageAlphaNone | kCGBitmapFloatComponents)) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number128 && _bitsPerSample == Number32 && _bitmapInfo == (kCGImageAlphaNoneSkipLast | kCGBitmapFloatComponents)) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number128 && _bitsPerSample == Number32 && _bitmapInfo == (kCGImageAlphaPremultipliedLast | kCGBitmapFloatComponents)) {
		return YES;
	}
	
	//CMYK
	if (_bitsPerPixel == Number128 && _bitsPerSample == Number32 && _bitmapInfo == (kCGImageAlphaNone | kCGBitmapFloatComponents)) {
		return YES;
	}
	
	//Gray
	if (_bitsPerPixel == Number16 && _bitsPerSample == Number16 && _bitmapInfo == kCGImageAlphaNone) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number64 && _bitsPerSample == Number16 && _bitmapInfo == kCGImageAlphaPremultipliedLast) {
		return YES;
	}
	
	//RGB
	if (_bitsPerPixel == Number64 && _bitsPerSample == Number16 && _bitmapInfo == kCGImageAlphaNoneSkipLast) {
		return YES;
	}
	
	//CMYK
	if (_bitsPerPixel == Number64 && _bitsPerSample == Number16 && _bitmapInfo == kCGImageAlphaNone) {
		return YES;
	}
	
	//Others
	return NO;
}

@end
