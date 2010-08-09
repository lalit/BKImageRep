//
//  BKColorSpace.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/07.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKColorSpace.h"

//Public
NSString * const BKCalibratedWhiteColorSpace	= @"BKCalibratedWhiteColorSpace";
NSString * const BKCalibratedBlackColorSpace	= @"BKCalibratedBlackColorSpace";
NSString * const BKCalibratedRGBColorSpace		= @"BKCalibratedRGBColorSpace";
NSString * const BKDeviceWhiteColorSpace		= @"BKDeviceWhiteColorSpace";
NSString * const BKDeviceBlackColorSpace		= @"BKDeviceBlackColorSpace";
NSString * const BKDeviceRGBColorSpace			= @"BKDeviceRGBColorSpace";
NSString * const BKDeviceCMYKColorSpace			= @"BKDeviceCMYKColorSpace";
NSString * const BKNamedColorSpace				= @"BKNamedColorSpace";
NSString * const BKPatternColorSpace			= @"BKPatternColorSpace";
NSString * const BKCustomColorSpace				= @"BKCustomColorSpace";

@implementation BKColorSpace
@synthesize CGColorSpace = _CGColorSpace;
@dynamic colorSpaceModel;
@dynamic numberOfColorComponents;

-(id)initWithCGColorSpace:(CGColorSpaceRef)cgColorSpace{
	if (self = [super init]) {
		_CGColorSpace = cgColorSpace;
		CGColorSpaceRelease(_CGColorSpace);
	}
	return self;
}

+(id)deviceCMYKColorSpace{
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceCMYK();
	id colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
	CGColorSpaceRelease(colorSpaceRef);
	return [colorSpace autorelease];
}

+(id)deviceGrayColorSpace{
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
	id colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
	CGColorSpaceRelease(colorSpaceRef);
	return [colorSpace autorelease];
}

+(id)deviceRGBColorSpace{
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	id colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
	CGColorSpaceRelease(colorSpaceRef);
	return [colorSpace autorelease];
}

-(void)dealloc{
	CGColorSpaceRelease(_CGColorSpace);
	[super dealloc];
}

#pragma mark -
#pragma mark Not implemented.

-(void *)colorSyncProfile{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

-(NSData *)ICCProfileData{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

-(id)initWithColorSyncProfile:(void *)prof{
	NSLog(@"%s is currently disabled in this version. Use -initWithCGColorSpace:.", __FUNCTION__);
	return nil;
}

-(id)initWithICCProfileData:(NSData *)iccData{
	NSLog(@"%s is currently disabled in this version. Use -initWithCGColorSpace:.", __FUNCTION__);
	return nil;
}

-(NSString *)localizedName{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+(BKColorSpace *)adobeRGB1998ColorSpace{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+(NSArray *)availableColorSpacesWithModel:(BKColorSpaceModel)model{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+(BKColorSpace *)genericCMYKColorSpace{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+(BKColorSpace *)genericGamma22GrayColorSpace{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+(BKColorSpace *)genericGrayColorSpace{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+(BKColorSpace *)genericRGBColorSpace{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

+(BKColorSpace *)sRGBColorSpace{
	NSLog(@"%s is currently disabled in this version. Will be implemented in the future.", __FUNCTION__);
	return nil;
}

@end
