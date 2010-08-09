//
//  BKBitmapImageRep-Override.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/07/01.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKBitmapImageRep-Override.h"
#import "BKColorSpace.h"

//Private
@interface BKBitmapImageRep ()
-(void)_bkResetBitmapData;
@end

@implementation BKBitmapImageRep (Override)

//Override
+ (NSArray *)imageRepsWithPasteboard:(UIPasteboard *) pasteboard{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

//Override
/*
 * Return any object that can be initialized from objects in the pasteboard.
 */
+ (id)imageRepWithPasteboard:(UIPasteboard *) pasteboard{
	NSLog(@"%s", __FUNCTION__);
	
	if ([[self class] canInitWithPasteboard:pasteboard]) {
		for (NSDictionary *aDict in [pasteboard items]){
			//The dictionary object always contains only one item.
			id obj = [[aDict allValues] lastObject];
			
			if ([obj isKindOfClass:[UIImage class]]) {
				//NSLog(@"obj is image");
				return [[[[self class] alloc] initWithImage:(UIImage *)obj] autorelease];
			}
			
			//NSLog(@"obj is data");
			return [[self class] imageRepWithData:(NSData *)obj];
		}
	}
	
	return nil;
}

//Override
+(BOOL)canInitWithData:(NSData *) data{
	NSLog(@"%s", __FUNCTION__);
	
	if ([UIImage imageWithData:data]) {
		return YES;
	}
	
	return NO;
} 

//Override
+(BOOL)canInitWithPasteboard:(UIPasteboard *) pasteboard{
	NSLog(@"%s", __FUNCTION__);
	
	//If the pasteboard contains image objects.
	if ([pasteboard containsPasteboardTypes:[[self class] imageUnfilteredPasteboardTypes]]) {
		return YES;
	}
	
	//If the pasteboard contains image data.
	for (NSDictionary *aDict in [pasteboard items]){
		//The dictionary object always contains only one item.
		id obj = [[aDict allValues] lastObject];
		
		if ([[self class] canInitWithData:(NSData *)obj]){
			return YES;
		}
	}
	
	return NO;
}

//Override
+ (NSArray *)imageUnfilteredFileTypes {
    static NSArray *types = nil;
	
	if (!types){
		types = [[NSArray alloc] initWithObjects:@"jpg", @"png", nil];
	}
	
	return types;
}

//Override
+ (NSArray *)imageUnfilteredTypes{
	static NSArray *types = nil;
	
	if (!types){
		types = [[NSArray alloc] initWithObjects:@"public.jpeg", @"public.png", nil];
	}
	
	return types;
}

//Override
+ (NSArray *)imageUnfilteredPasteboardTypes {
    static NSArray *types = nil;
	
	if (!types){
		types = [[NSArray alloc] initWithArray:UIPasteboardTypeListImage];
	}
	
	return types;
}

#pragma mark -
#pragma mark Accessors

-(void)setColorSpaceName:(NSString *)csn{
	_colorSpaceName = [csn copy];
	self.colorSpace = nil;
	
	if (_colorSpaceName == BKCalibratedWhiteColorSpace) {
		NSLog(@"%s, %@ is currently disabled.", BKCalibratedWhiteColorSpace);
		return;
	}
	
	if (_colorSpaceName == BKCalibratedBlackColorSpace) {
		NSLog(@"%s, %@ is currently disabled.", BKCalibratedBlackColorSpace);
		return;
	}
	
	if (_colorSpaceName == BKCalibratedRGBColorSpace) {
		NSLog(@"%s, %@ is currently disabled.", BKCalibratedRGBColorSpace);
		return;
	}
	
	if (_colorSpaceName == BKDeviceWhiteColorSpace) {
		self.colorSpace = [BKColorSpace deviceGrayColorSpace];
		return;
	}
	
	if (_colorSpaceName == BKDeviceBlackColorSpace) {
		NSLog(@"%s, %@ is currently disabled.", BKDeviceBlackColorSpace);
		return;
	}
	
	if (_colorSpaceName == BKDeviceRGBColorSpace) {
		self.colorSpace = [BKColorSpace deviceRGBColorSpace];
		return;
	}
	
	if (_colorSpaceName == BKDeviceCMYKColorSpace) {
		self.colorSpace = [BKColorSpace deviceCMYKColorSpace];
		return;
	}
	
	if (_colorSpaceName == BKNamedColorSpace) {
		NSLog(@"%s, %@ is currently disabled.", BKNamedColorSpace);
		return;
	}
	
	if (_colorSpaceName == BKPatternColorSpace) {
		NSLog(@"%s, %@ is currently disabled.", BKPatternColorSpace);
		return;
	}
	
	if (_colorSpaceName == BKCustomColorSpace) {
		NSLog(@"%s, %@ is currently disabled.", BKCustomColorSpace);
		return;
	}
}

//Override
-(void)setBitsPerSample:(int)bps{
	[super setBitsPerSample:bps];
	[self _bkResetBitmapData];
}

//Override
-(void)setPixelWide:(int)w{
	[super setPixelsWide:w];
	[self _bkResetBitmapData];
}

//Override
-(void)setPixelHigh:(int)h{
	[super setPixelsHigh:h];
	[self _bkResetBitmapData];
}

//Override
-(void)setSize:(CGSize)aSize{
	[super setSize:aSize];
	[self _bkResetBitmapData];
}

#pragma mark -
#pragma mark Private

-(void)_bkResetBitmapData{
	_bitsPerPixel = _bitsPerSample * _samplesPerPixel;
	_bytesPerRow = _pixelsWide * _bitsPerPixel / 8;
	
	if (_bitmapData) {
		free(_bitmapData);
	}
	
	_bitmapData = calloc(1, _pixelsHigh * _bytesPerRow);
}


@end
