//
//  BKBitmapImageRep-Test.m
//  BKImageRep
//
//  Created by boreal-kiss.com on 10/07/09.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "BKBitmapImageRep-Test.h"


@implementation BKBitmapImageRep (Test)

-(void)checkBitmapInfo{
	NSLog(@"%s", __FUNCTION__);
	
	if (_bitmapInfo == kCGImageAlphaNone) {
		NSLog(@"kCGImageAlphaNone");
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaPremultipliedLast) {
		NSLog(@"kCGImageAlphaPremultipliedLast");
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaPremultipliedFirst) {
		NSLog(@"kCGImageAlphaPremultipliedFirst");
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaLast) {
		NSLog(@"kCGImageAlphaLast");
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaFirst) {
		NSLog(@"kCGImageAlphaFirst");
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaNoneSkipLast) {
		NSLog(@"kCGImageAlphaNoneSkipLast");
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaNoneSkipFirst) {
		NSLog(@"kCGImageAlphaNoneSkipFirst");
		return;
	}
	
	if (_bitmapInfo == kCGImageAlphaOnly) {
		NSLog(@"kCGImageAlphaOnly");
		return;
	}
	
	NSLog(@"%s not supported configuration found.", __FUNCTION__);
}


@end
