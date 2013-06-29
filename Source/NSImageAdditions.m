/*
//  NSImage+CW.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/7/12.
//  Copyright (c) 2012. All rights reserved.
//

Copyright (c) 2012 Colin Wheeler

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#import "NSImageAdditions.h"

@implementation NSImage (CWNSImageAdditions)

-(NSImage *)cw_imageResizedToSize:(CGSize)size {
	return [self cw_imageResizedToSize:size 
			  withInterpolationQuality:kCGInterpolationHigh];
}

-(NSImage *)cw_imageResizedToSize:(CGSize)size 
		 withInterpolationQuality:(CGInterpolationQuality)quality {
	CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)[self TIFFRepresentation], NULL);
	CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
	CGRect rect = { CGPointZero, size };
	CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 
												 CGImageGetBitsPerComponent(image), 0,
												 CGImageGetColorSpace(image), 
												 kCGImageAlphaPremultipliedLast);
	if (context == NULL) {
		CWLogInfo(@"ERROR: Received NULL CGContextRef");
		CFRelease(imageSource);
		CGImageRelease(image);
		return nil;
	}
	
	CGContextSetInterpolationQuality(context, quality);
	CGContextDrawImage(context, rect, image);
	CGImageRef cgImage = CGBitmapContextCreateImage(context);
	NSImage *nsimage = [[NSImage alloc] initWithCGImage:cgImage size:size];
	
	CGImageRelease(cgImage);
	CGContextRelease(context);
	CFRelease(imageSource);
	CGImageRelease(image);
	
	return nsimage;
}

@end
