//
//  BKBitmapImageRep-PixelFormats.h
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/07/09.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKBitmapImageRep.h"

/**
 * Private category.
 */
@interface BKBitmapImageRep (PixelFormats)

/**
 * Rearrange the pixel format if necessary.
 * This method is not completed.
 */
-(void)_bkArrangePixelFormatProperly;

/**
 * Check pixel formats for bitmap data creation.
 * Data from Apple - Quartz 2D Programming Guide.
 */
-(BOOL)_bkIsSupportedPixelFormat;
@end
