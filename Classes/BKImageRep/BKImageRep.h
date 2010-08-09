//
//  BKImageRep.h
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/05.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Semi-abstract class. Use it by subclassing.
 */
@interface BKImageRep : NSObject {
	int _pixelsWide;
	int _pixelsHigh;
	int _bitsPerSample;
	NSString *_colorSpaceName;
	BOOL _hasAlpha;
	BOOL _isOpaque;
}

/**
 * Returns the number of bits per sample in the receiver.
 */
@property (nonatomic, assign) int bitsPerSample;

/**
 * Returns the name of the receiver's color space in the NSString format.
 */
@property (nonatomic, copy) NSString *colorSpaceName;

/**
 * Returns a Boolean value indicating whether the receiver has an alpha channel.
 */
@property (nonatomic, assign, setter=setAlpha:) BOOL hasAlpha;

/**
 * Returns a Boolean value indicating whether the receiver is opaque.
 * Note that this always returns YES.
 */
@property (nonatomic, assign, setter=setOpaque:) BOOL isOpaque;

/**
 * Returns the height of the image, measured in pixels.
 */
@property (nonatomic, assign) int pixelsHigh;

/**
 * Returns the width of the image, measured in pixels.
 */
@property (nonatomic, assign) int pixelsWide;

/**
 * Returns the image size assuming the resolution of 72 dpi, 
 * i.e., the width and height of the size is eactly the same as pixel wide and high, respectively.
 */
@property (nonatomic, assign) CGSize size;

//- (CGImageRef)CGImageForProposedRect:(NSRect *) proposedDestRect context:(NSGraphicsContext *) context hints:(NSDictionary *) hints;
//- (BOOL)draw;
//- (BOOL)drawAtPoint:(CGPoint) aPoint;
//- (BOOL)drawInRect:(CGRect) rect;
//- (BOOL)drawInRect:(NSRect) dstSpacePortionRect fromRect:(NSRect) srcSpacePortionRect operation:(NSCompositingOperation) op fraction:(CGFloat) requestedAlpha respectFlipped:(BOOL) respectContextIsFlipped hints:(NSDictionary *) hints;

/**
 * Returns a Boolean value indicating whether the receiver can initialize itself from the specified data.
 */
+(BOOL)canInitWithData:(NSData *) data;

/**
 * Returns a Boolean value indicating whether the receiver can initialize itself from the data on the specified pasteboard.
 */
+(BOOL)canInitWithPasteboard:(UIPasteboard *) pasteboard;

/**
 * Returns file types supported by the receiver. 
 * The list includes the types returned by the imageUnfilteredFileTypes class method.
 */
+ (NSArray *)imageFileTypes;

/**
 * Returns pasteboard types supported by the receiver. 
 * The list includes the types returned by the imageUnfilteredPasteboardTypes class method.
 */
+ (NSArray *)imagePasteboardTypes;
+ (Class)imageRepClassForData:(NSData *) data;
+ (Class)imageRepClassForFileType:(NSString *) type;
+ (Class)imageRepClassForPasteboardType:(NSString *) type;
+ (Class)imageRepClassForType:(NSString *) type;
+ (NSArray *)imageRepsWithContentsOfFile:(NSString *) filename;
+ (NSArray *)imageRepsWithContentsOfURL:(NSURL *) aURL;
+ (NSArray *)imageRepsWithPasteboard:(UIPasteboard *) pasteboard;
+ (id)imageRepWithContentsOfFile:(NSString *) filename;
+ (id)imageRepWithContentsOfURL:(NSURL *) aURL;

/**
 * Returns any object that can be initialized from objects in the pasteboard.
 */
+ (id)imageRepWithPasteboard:(UIPasteboard *) pasteboard;

/**
 * Returns an array of UTI strings identifying the image types supported by the receiver.
 * The list includes types returned by the imageUnfilteredTypes class method.
 */
+ (NSArray *)imageTypes;

/**
 * Returns the list of file types supported directly by the receiver.
 */
+ (NSArray *)imageUnfilteredFileTypes;

/**
 * Returns the list of pasteboard types supported directly by the receiver.
 */
+ (NSArray *)imageUnfilteredPasteboardTypes;

/**
 * Returns an array of UTI strings identifying the image types supported directly by the receiver.
 */
+ (NSArray *)imageUnfilteredTypes;
+ (NSArray *)registeredImageRepClasses;
+ (void)registerImageRepClass:(Class) imageRepClass;
+ (void)unregisterImageRepClass:(Class) imageRepClass;
@end
