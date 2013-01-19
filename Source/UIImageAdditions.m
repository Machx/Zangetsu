/*
//  UIImage+CWUIImageAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/12/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/
 
#import "UIImageAdditions.h"

@implementation UIImage (CWUIImageAdditions)

-(UIImage *)cw_imageResizedToSize:(CGSize)size
{
	UIImage *result = [self cw_imageResizedToSize:size 
						 withInterpolationQuality:kCGInterpolationHigh];
	return result;
}

-(UIImage *)cw_imageResizedToSize:(CGSize)size 
		 withInterpolationQuality:(CGInterpolationQuality)quality
{
	CGImageRef image = self.CGImage;
	CGRect rect = { CGPointZero, size };
	
	CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 
												 CGImageGetBitsPerComponent(image), 0,
												 CGImageGetColorSpace(image), 
												 kCGImageAlphaPremultipliedLast);
	if (context == NULL) {
		CWDebugLog(@"ERROR: Received NULL CGContextRef");
		return nil;
	}
	
	CGContextSetInterpolationQuality(context, quality);
	CGContextDrawImage(context, rect, image);
	
	CGImageRef cgImage = CGBitmapContextCreateImage(context);
	UIImage *result = [UIImage imageWithCGImage:cgImage];
	
	CGImageRelease(cgImage);
	CGContextRelease(context);
	
	return result;
}

@end
