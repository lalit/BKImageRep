//
//  BKBitmapImageRep.h
//  BKBitmapImageRep
//
//  Created by boreal-kiss.com on 10/05/05.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKImageRep.h"

//New
typedef enum BKImageRepLoadStatus{
	BKImageRepLoadStatusUnknownType     = -1,
	BKImageRepLoadStatusReadingHeader   = -2,
	BKImageRepLoadStatusWillNeedAllData = -3,
	BKImageRepLoadStatusInvalidData		= -4,
	BKImageRepLoadStatusUnexpectedEOF	= -5,
	BKImageRepLoadStatusCompleted		= -6
} BKImageRepLoadStatus;

//New
typedef enum BKBitmapFormat{
	BKAlphaFirstBitmapFormat            = 1 << 0,
	BKAlphaNonpremultipliedBitmapFormat = 1 << 1,
	BKFloatingPointSamplesBitmapFormat  = 1 << 2
} BKBitmapFormat;

@class BKColorSpace;

/**
 * The class renders an image from bitmap data.
 * The planar configuration of bits is not supported.
 */
@interface BKBitmapImageRep : BKImageRep {
	int _samplesPerPixel;
	int _bitsPerPixel;
	int _bytesPerRow;
	unsigned char *_bitmapData;
	CGBitmapInfo _bitmapInfo;
	BKColorSpace *_colorSpace;
}

/**
 * Returns a pointer to the bitmap data.
 */
@property (readonly) unsigned char *bitmapData;

/*
 * Returns the bitmap format of the receiver.
 * Note that the implementation is IMCOMPLETE.
 */
@property (readonly) BKBitmapFormat bitmapFormat;

/**
 * Returns the number of bits allocated for each pixel.
 */
@property (readonly) int bitsPerPixel;

/**
 * Returns the number of bytes in each plane.
 * Note that the return value  is always equivallent to the total bytes of image data, 
 * as the planar confuguration is not currently supported.
 */
@property (readonly) NSInteger bytesPerPlane;

/**
 * Returns the minimum number of bytes required to specify a scan line.
 * This is equivalent to the pixelWide property assuming resolution of 72 dpi.
 */
@property (readonly) int bytesPerRow;

/**
 * Returns the image rep’s colorSpace.
 */
@property (nonatomic, retain) BKColorSpace *colorSpace;

/**
 * Always retuns NO as the planar configuration is not currently supported.
 */
@property (readonly) BOOL isPlanar;

/**
 * Alway returns 1 indicating the data is meshed.
 */
@property (readonly) NSInteger numberOfPlanes;

/**
 * Returns the number of components in the data.
 */
@property (readonly) int samplesPerPixel;

/**
 * Returns an image object from the receiver’s current bitmap data.
 */
@property (nonatomic, retain) UIImage *image;

//- (NSBitmapImageRep *)bitmapImageRepByConvertingToColorSpace:(NSColorSpace *) targetSpace renderingIntent:(NSColorRenderingIntent) renderingIntent;

/**
 * Changes the colorSpace tag of the receiver.
 * Returned object is the receiver itself.
 */
- (BKBitmapImageRep *)bitmapImageRepByRetaggingWithColorSpace:(BKColorSpace *) newSpace;
//- (BOOL)canBeCompressedUsing:(NSTIFFCompression) compression;
//- (CGImageRef)CGImage;

/**
 * Returns the color of the pixel at the specified coordinates.
 */
-(UIColor *)colorAtX:(NSInteger)x y:(NSInteger)y;
//- (void)colorizeByMappingGray:(CGFloat) midPoint toColor:(NSColor *) midPointColor blackMapping:(NSColor *) shadowColor whiteMapping:(NSColor *) lightColor;
//- (void)getBitmapDataPlanes:(unsigned char **) data;
//- (void)getCompression:(NSTIFFCompression *) compression factor:(float *) factor;

/**
 * Returns by indirection the pixel data for the specified location in the receiver.
 */
-(void)getPixel:(NSUInteger[])pixelData atX:(NSInteger)x y:(NSInteger)y;
//- (NSInteger)incrementalLoadFromData:(NSData *) data complete:(BOOL) complete;
//- (id)initForIncrementalLoad;

/**
 * The designated initializer.
 */
-(id)initWithPixelsWide:(int)w pixelsHigh:(int)h bitsPerSample:(int)bps samplesPerPixel:(int)spp hasAlpha:(BOOL)a colorSpaceName:(NSString *)csn;

/**
 * The designated initializer with less arguments.
 */
-(id)initWithPixelsWide:(int)w pixelsHigh:(int)h hasAlpha:(BOOL)a;
//- (id)initWithCGImage:(CGImageRef) cgImage;
//- (id)initWithCIImage:(CIImage *) ciImage;

/**
 * Initializes a newly allocated object created from a UIImage object.
 */
-(id)initWithImage:(UIImage *)anImage;

/**
 * Initializes a newly allocated object from the provided data.
 */
- (id)initWithData:(NSData *) bitmapData;
//- (id)initWithFocusedViewRect:(NSRect) rec;
//- (NSData *)representationUsingType:(NSBitmapImageFileType) storageType properties:(NSDictionary *) properties;

/**
 * Changes the color of the pixel at the specified coordinates.
 */
-(void)setColor:(UIColor *)color atX:(NSInteger)x y:(NSInteger)y;
//- (void)setCompression:(NSTIFFCompression) compression factor:(float) factor;

/**
 * Sets the receiver's pixel at the specified coordinates to the specified raw pixel values.
 */
-(void)setPixel:(NSUInteger[])pixelData atX:(NSInteger)x y:(NSInteger)y;
//- (void)setProperty:(NSString *) property withValue:(id) value;
//- (NSData *)TIFFRepresentation;
//- (NSData *)TIFFRepresentationUsingCompression:(NSTIFFCompression) compression factor:(float) factor;
//- (id)valueForProperty:(NSString *) property;


//+ (void)getTIFFCompressionTypes:(const NSTIFFCompression **) list count:(NSInteger *) numTypes;

/**
 * Creates and returns an array of initialized objects corresponding to the images in the supplied data.
 */
+ (NSArray *)imageRepsWithData:(NSData *) bitmapData;

/**
 * Creates and returns an object initialized with the first image in the supplied data.
 */
+ (id)imageRepWithData:(NSData *) bitmapData;
//+ (NSString *)localizedNameForTIFFCompressionType:(NSTIFFCompression) compression;
//+ (NSData *)representationOfImageRepsInArray:(NSArray *) imageReps usingType:(NSBitmapImageFileType) storageType properties:(NSDictionary *) properties;
//+ (NSData *)TIFFRepresentationOfImageRepsInArray:(NSArray *) array;
//+ (NSData *)TIFFRepresentationOfImageRepsInArray:(NSArray *) array usingCompression:(NSTIFFCompression) compression factor:(float) factor;

@end