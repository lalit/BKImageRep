//
//  BKBitmapImageRep.m
//  BKBitmapImageRep
//
//  Created by boreal-kiss.com on 10/05/05.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKBitmapImageRep.h"
#import "BKBitmapImageRep-PixelFormats.h"
#import "BKImageRep.h"
#import "BKColorSpace.h"

//Private
static const int DefaultBitsPerSample	= 8;
static const int DefaultSamplesPerPixel = 4;//RGBA
static const int BitsPerByte			= 8;

//Private
@interface BKBitmapImageRep ()
-(void)_bkInitIvars;
-(void)_bkInitIvarsWithImage:(UIImage *)anImage;
-(void)_bkResetColorSpaceNameWithImageRep:(BKBitmapImageRep *)imageRep;
-(void)_bkResetBitmapInfo;
-(void)_bkSetAlphaLast;
@end

@implementation BKBitmapImageRep
@synthesize samplesPerPixel = _samplesPerPixel;
@synthesize bitsPerPixel = _bitsPerPixel;
@synthesize bytesPerRow = _bytesPerRow;
@synthesize bitmapData = _bitmapData;
@dynamic image;
@dynamic isPlanar;
@dynamic numberOfPlanes;
@dynamic bytesPerPlane;
@synthesize colorSpace = _colorSpace;
@dynamic bitmapFormat;

- (BKBitmapImageRep *)bitmapImageRepByRetaggingWithColorSpace:(BKColorSpace *) newSpace{
	//NSLog(@"%s", __FUNCTION__);
	
	self.colorSpace = newSpace;
	[self _bkResetColorSpaceNameWithImageRep:self];
	return self;
}

-(id)initWithPixelsWide:(int)w pixelsHigh:(int)h bitsPerSample:(int)bps samplesPerPixel:(int)spp hasAlpha:(BOOL)a colorSpaceName:(NSString *)csn{
	//NSLog(@"%s", __FUNCTION__);
	
	if (self = [super init]){
		_pixelsWide = w;
		_pixelsHigh = h;
		_bitsPerSample = bps;
		_samplesPerPixel = spp;
		_hasAlpha = a;
		self.colorSpaceName = csn;
		_bitsPerPixel = _bitsPerSample * _samplesPerPixel;
		_bytesPerRow = _pixelsWide * _bitsPerPixel / BitsPerByte;
		_bitmapData = calloc(1, _pixelsHigh * _bytesPerRow);
		[self _bkInitIvars];
	}
	return self;
}

-(id)initWithPixelsWide:(int)w pixelsHigh:(int)h hasAlpha:(BOOL)a{
	return [self initWithPixelsWide:w 
						 pixelsHigh:h 
					  bitsPerSample:DefaultBitsPerSample 
				   samplesPerPixel:DefaultSamplesPerPixel 
						   hasAlpha:a 
					 colorSpaceName:BKDeviceRGBColorSpace];
}

-(id)initWithImage:(UIImage *)anImage{
	NSLog(@"%s", __FUNCTION__);
	
	if (self = [super init]) {
		CGImageRef cgImage = anImage.CGImage;
		_pixelsWide = CGImageGetWidth(cgImage);
		_pixelsHigh = CGImageGetHeight(cgImage);
		_bitsPerSample = CGImageGetBitsPerComponent(cgImage);
		_bitsPerPixel = CGImageGetBitsPerPixel(cgImage);
		_bytesPerRow = CGImageGetBytesPerRow(cgImage);
		_bitmapInfo = CGImageGetAlphaInfo(cgImage);
		_bitmapData = calloc(1, _pixelsHigh * _bytesPerRow);
		_colorSpace = [[BKColorSpace alloc] initWithCGColorSpace:CGImageGetColorSpace(cgImage)];
		
		//New
		[self _bkArrangePixelFormatProperly];
		//NSLog(@"w: %d h: %d bps: %d bpp: %d bpr: %d", _pixelsWide, _pixelsHigh, _bitsPerSample, _bitsPerPixel, _bytesPerRow);
		
		[self _bkInitIvarsWithImage:anImage];
	}
	return self;
}

- (id)initWithData:(NSData *) bitmapData{
	UIImage *anImage = [UIImage imageWithData:bitmapData];
	
	if (anImage) {
		return [self initWithImage:anImage];
	}
	return nil;
}

-(void)setColor:(UIColor *)color atX:(NSInteger)x y:(NSInteger)y{
	NSLog(@"%s must be reimplemented in categories.", __FUNCTION__);
}

-(UIColor *)colorAtX:(NSInteger)x y:(NSInteger)y{
	NSLog(@"%s must be reimplemented in categories.", __FUNCTION__);
	return nil;
}

-(void)setPixel:(NSUInteger[])pixelData atX:(NSInteger)x y:(NSInteger)y{
	NSLog(@"%s must be reimplemented in categories.", __FUNCTION__);
}

-(void)getPixel:(NSUInteger[])pixelData atX:(NSInteger)x y:(NSInteger)y{
	NSLog(@"%s must be reimplemented in categories.", __FUNCTION__);
}

+ (NSArray *)imageRepsWithData:(NSData *) bitmapData{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+ (id)imageRepWithData:(NSData *) bitmapData{
	return [[[[self class] alloc] initWithData:bitmapData] autorelease];
}

-(void)dealloc{
	free(_bitmapData);
	self.colorSpace = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Private

-(void)_bkInitIvars{
	if (_bitsPerPixel == DefaultBitsPerSample) {
		//1 component, 8 bits per pixel.
		if (_hasAlpha) {
			_bitmapInfo = kCGImageAlphaOnly;
			return;
		}
		_bitmapInfo = kCGImageAlphaNone;
	}
	else if (_bitsPerPixel == DefaultBitsPerSample * DefaultSamplesPerPixel) {
		//4 components, 8 bits per pixel.
		if (_hasAlpha) {
			_bitmapInfo = kCGImageAlphaPremultipliedLast;
			return;
		}
		_bitmapInfo = kCGImageAlphaNoneSkipLast;
	}
	else{
		//Others, e.g., 32 bits per pixel.
		NSLog(@"%s, the bits configuration is currently not supported.", __FUNCTION__);
		return;
	}
}

-(void)_bkInitIvarsWithImage:(UIImage *)anImage{
	//NSLog(@"%s", __FUNCTION__);

	[self _bkResetColorSpaceNameWithImageRep:self];
	[self _bkResetBitmapInfo];
	self.image = anImage;
}

-(void)_bkResetColorSpaceNameWithImageRep:(BKBitmapImageRep *)imageRep{
	//NSLog(@"%s", __FUNCTION__);
	
	//This implementation must be reconsidered.
	static NSString *colorSpaceNotSupported = @"Color space not supported";
	
	switch (imageRep.colorSpace.colorSpaceModel) {
		case BKUnknownColorSpaceModel:
			imageRep.colorSpaceName = colorSpaceNotSupported;
			break;
		case BKGrayColorSpaceModel:
			imageRep.colorSpaceName = BKDeviceWhiteColorSpace;
			break;
		case BKRGBColorSpaceModel:
			imageRep.colorSpaceName = BKDeviceRGBColorSpace;
			break;
		case BKCMYKColorSpaceModel:
			imageRep.colorSpaceName = BKDeviceCMYKColorSpace;
			break;
		case BKLABColorSpaceModel:
			imageRep.colorSpaceName = colorSpaceNotSupported;
			break;
		case BKDeviceNColorSpaceModel:
			imageRep.colorSpaceName = colorSpaceNotSupported;
			break;
		case BKIndexedColorSpaceModel:
			imageRep.colorSpaceName = colorSpaceNotSupported;
			break;
		case BKPatternColorSpaceModel:
			imageRep.colorSpaceName = BKPatternColorSpace;
			break;	
		default:
			imageRep.colorSpaceName = colorSpaceNotSupported;
			break;
	}
}

//New
-(void)_bkResetBitmapInfo{
	NSLog(@"%s", __FUNCTION__);
	
	if (_bitmapInfo == kCGImageAlphaNone) {
		//NSLog(@"kCGImageAlphaNone");
		_hasAlpha = NO;
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaPremultipliedLast) {
		//NSLog(@"kCGImageAlphaPremultipliedLast");
		_hasAlpha = YES;
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaPremultipliedFirst) {
		//NSLog(@"kCGImageAlphaPremultipliedFirst");
		_hasAlpha = YES;
		[self _bkSetAlphaLast];
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaLast) {
		//NSLog(@"kCGImageAlphaLast");
		
		//Modification neccesiated as this pixel format is not supported in CGBitmapContext.
		_bitmapInfo = kCGImageAlphaPremultipliedLast;
		
		_hasAlpha = YES;
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaFirst) {
		//NSLog(@"kCGImageAlphaFirst");
		
		//Modification neccesiated as this pixel format is not supported in CGBitmapContext.
		_bitmapInfo = kCGImageAlphaPremultipliedFirst;
		
		_hasAlpha = YES;
		[self _bkSetAlphaLast];
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaNoneSkipLast) {
		//NSLog(@"kCGImageAlphaNoneSkipLast");
		_hasAlpha = NO;
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaNoneSkipFirst) {
		//NSLog(@"kCGImageAlphaNoneSkipFirst");
		_hasAlpha = NO;
		[self _bkSetAlphaLast];
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaOnly) {
		//NSLog(@"kCGImageAlphaOnly");
		_hasAlpha = YES;
		return;
	}
}

//ARGB => RGBA
-(void)_bkSetAlphaLast{
	NSLog(@"%s", __FUNCTION__);
	
	int iMax = _pixelsHigh * _bytesPerRow;
	for (int i=0; i<iMax; i+=4) {
		int a = _bitmapData[i + 0];
		int r = _bitmapData[i + 1];
		int g = _bitmapData[i + 2];
		int b = _bitmapData[i + 3];
		
		_bitmapData[i + 0] = r;
		_bitmapData[i + 1] = g;
		_bitmapData[i + 2] = b;
		_bitmapData[i + 3] = a;
	}
	
	if (_bitmapInfo == kCGImageAlphaPremultipliedFirst) {
		_bitmapInfo = kCGImageAlphaPremultipliedLast;
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaFirst) {
		_bitmapInfo = kCGImageAlphaLast;
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaNoneSkipFirst) {
		_bitmapInfo = kCGImageAlphaNoneSkipLast;
		return;
	}
}


@end
