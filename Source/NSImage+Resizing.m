/*
//  NSImage+CW.m
//  Zangetsu
//
//  Created by Colin Wheeler on 7/7/12.
//  Copyright (c) 2012. All rights reserved.
//

 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "NSImage+Resizing.h"

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
												 kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
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
