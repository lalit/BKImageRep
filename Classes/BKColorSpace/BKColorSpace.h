//
//  BKColorSpace.h
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/07.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BKCalibratedWhiteColorSpace;
extern NSString * const BKCalibratedBlackColorSpace;
extern NSString * const BKCalibratedRGBColorSpace;
extern NSString * const BKDeviceWhiteColorSpace;
extern NSString * const BKDeviceBlackColorSpace;
extern NSString * const BKDeviceRGBColorSpace;
extern NSString * const BKDeviceCMYKColorSpace;
extern NSString * const BKNamedColorSpace;
extern NSString * const BKPatternColorSpace;
extern NSString * const BKCustomColorSpace;

typedef enum BKColorSpaceModel{
	BKUnknownColorSpaceModel = -1,
	BKGrayColorSpaceModel,
	BKRGBColorSpaceModel,
	BKCMYKColorSpaceModel,
	BKLABColorSpaceModel,
	BKDeviceNColorSpaceModel,
	BKIndexedColorSpaceModel,
	BKPatternColorSpaceModel
} BKColorSpaceModel;

@interface BKColorSpace : NSObject {
	CGColorSpaceRef _CGColorSpace;
}
@property (readonly) CGColorSpaceRef CGColorSpace;
@property (readonly) BKColorSpaceModel colorSpaceModel;
@property (readonly) NSInteger numberOfColorComponents;


/**
 * The designated initializer.
 */
-(id)initWithCGColorSpace:(CGColorSpaceRef)cgColorSpace;
+(id)deviceCMYKColorSpace;
+(id)deviceGrayColorSpace;
+(id)deviceRGBColorSpace;

//The followings must be implemented in the future.
-(void *)colorSyncProfile;
-(NSData *)ICCProfileData;
-(id)initWithColorSyncProfile:(void *)prof;
-(id)initWithICCProfileData:(NSData *)iccData;
-(NSString *)localizedName;
+(BKColorSpace *)adobeRGB1998ColorSpace;
+(NSArray *)availableColorSpacesWithModel:(BKColorSpaceModel)model;
+(BKColorSpace *)genericCMYKColorSpace;
+(BKColorSpace *)genericGamma22GrayColorSpace;
+(BKColorSpace *)genericGrayColorSpace;
+(BKColorSpace *)genericRGBColorSpace;
+(BKColorSpace *)sRGBColorSpace;
@end