//
//  BKColorSpace-Accessors.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/07.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKColorSpace-Accessors.h"

@implementation BKColorSpace (Accessors)

-(NSInteger)numberOfColorComponents{
	return CGColorSpaceGetNumberOfComponents(_CGColorSpace);
}

-(BKColorSpaceModel)colorSpaceModel{
	CGColorSpaceModel csm = CGColorSpaceGetModel(_CGColorSpace);
	
	switch (csm) {
		case kCGColorSpaceModelMonochrome:
			return BKGrayColorSpaceModel;
			break;
		case kCGColorSpaceModelRGB:
			return BKRGBColorSpaceModel;
			break;
		case kCGColorSpaceModelCMYK:
			return BKCMYKColorSpaceModel;
			break;
		case kCGColorSpaceModelLab:
			return BKLABColorSpaceModel;
			break;
		case kCGColorSpaceModelDeviceN:
			return BKDeviceNColorSpaceModel;
			break;
		case kCGColorSpaceModelIndexed:
			return BKIndexedColorSpaceModel;
			break;
		case kCGColorSpaceModelPattern:
			return BKPatternColorSpaceModel;
			break;	
		default:
			return BKUnknownColorSpaceModel;
	}
}

@end
