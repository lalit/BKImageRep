//
//  BKImageRep.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/05.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKImageRep.h"
#import "BKImageRep-Accessors.h"

@implementation BKImageRep
@synthesize pixelsWide = _pixelsWide;
@synthesize pixelsHigh = _pixelsHigh;
@synthesize bitsPerSample = _bitsPerSample;
@synthesize colorSpaceName = _colorSpaceName;
@synthesize hasAlpha = _hasAlpha;
@synthesize isOpaque = _isOpaque;
@dynamic size;

-(void)dealloc{
	self.colorSpaceName = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Not implemented methods.

+(BOOL)canInitWithData:(NSData *) data{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return NO;
}

+(BOOL)canInitWithPasteboard:(UIPasteboard *) pasteboard{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return NO;
}

+ (NSArray *)imageFileTypes{
	return [[self class] imageUnfilteredFileTypes];
}

+ (NSArray *)imagePasteboardTypes{
	return [[self class] imageUnfilteredPasteboardTypes];
}

+ (Class)imageRepClassForData:(NSData *) data{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+ (Class)imageRepClassForFileType:(NSString *) type{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+ (Class)imageRepClassForPasteboardType:(NSString *) type{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+ (Class)imageRepClassForType:(NSString *) type{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+ (NSArray *)imageRepsWithContentsOfFile:(NSString *) filename{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (NSArray *)imageRepsWithContentsOfURL:(NSURL *) aURL{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (NSArray *)imageRepsWithPasteboard:(UIPasteboard *) pasteboard{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (id)imageRepWithContentsOfFile:(NSString *) filename{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (id)imageRepWithContentsOfURL:(NSURL *) aURL{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (id)imageRepWithPasteboard:(UIPasteboard *) pasteboard{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (NSArray *)imageTypes{
	return [[self class] imageUnfilteredTypes];
}

+ (NSArray *)imageUnfilteredFileTypes{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (NSArray *)imageUnfilteredPasteboardTypes{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (NSArray *)imageUnfilteredTypes{
	NSLog(@"%s must be overriden in subclasses", __FUNCTION__);
	return nil;
}

+ (NSArray *)registeredImageRepClasses{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+ (void)registerImageRepClass:(Class) imageRepClass{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
}

+ (void)unregisterImageRepClass:(Class) imageRepClass{
	NSLog(@"%s is currently disabled. Will be implemented in the future.", __FUNCTION__);
}

@end
