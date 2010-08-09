//
//  BKImageRep-Accessors.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/05/06.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKImageRep-Accessors.h"

@implementation BKImageRep (Accessors)

-(CGSize)size{
	return CGSizeMake(_pixelsWide, _pixelsHigh);
}

-(void)setSize:(CGSize)aSize{
	_pixelsWide = aSize.width;
	_pixelsHigh = aSize.height;
}

-(BOOL)isOpaque{
	return YES;
}

-(void)setOpaque:(BOOL)opaque{
	NSLog(@"%s is currently disabled.", __FUNCTION__);
}

-(void)setAlpha:(BOOL)flag{
	NSLog(@"%s is currently disabled.", __FUNCTION__);
}

@end