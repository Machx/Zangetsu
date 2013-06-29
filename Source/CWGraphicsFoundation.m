/*
//  CWGraphicsFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
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

#import "CWGraphicsFoundation.h"

inline CGContextRef CWCurrentCGContext()
{
#if Z_HOST_OS_IS_MAC_OS_X
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
#else
	return UIGraphicsGetCurrentContext();
#endif
}

CGRect CWCenteredRect(CGRect smallRect, CGRect largeRect) {
	CGRect centeredRect;
	centeredRect.size = smallRect.size;
	centeredRect.origin.x = (largeRect.size.width - smallRect.size.width) * 0.5;
	centeredRect.origin.y = (largeRect.size.height - smallRect.size.height) * 0.5;
	return centeredRect;
}

void CWAddRoundedRectToPath(CGContextRef context,
						  CGRect rect,
						  float ovalWidth,
						  float ovalHeight) {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
	
	CWSaveAndRestoreCGContextState(context, ^{
		float fw, fh;
		
		CGContextTranslateCTM (context, CGRectGetMinX(rect),CGRectGetMinY(rect));
		CGContextScaleCTM (context, ovalWidth, ovalHeight);
		
		fw = CGRectGetWidth (rect) / ovalWidth;
		fh = CGRectGetHeight (rect) / ovalHeight;
		
		CGContextMoveToPoint(context, fw, fh/2);
		CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
		CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
		CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
		CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
		CGContextClosePath(context);
	});
}

void CWSaveAndRestoreCGContextState(CGContextRef ctx, void(^block)(void)) {
	CGContextSaveGState(ctx);
	block();
	CGContextRestoreGState(ctx);
}

void CWContextDrawLinearGradientBetweenPoints(CGContextRef context,
											  CGPoint point1, CGFloat color1[4],
											  CGPoint point2, CGFloat color2[4]) {
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGFloat components[] = { color1[0], color1[1], color1[2], color1[3], color2[0], color2[1], color2[2], color2[3] };
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL, 2);
	CGContextDrawLinearGradient(context, gradient, point1, point2, 0);
	CGGradientRelease(gradient);
	CGColorSpaceRelease(space);
}

CGContextRef CWImageContextWithSize(NSInteger width, NSInteger height) {
	CGContextRef ref = NULL;
	CGColorSpaceRef space =
#if Z_HOST_OS_IS_MAC_OS_X
	CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
#else
	CGColorSpaceCreateDeviceRGB();
#endif
	NSInteger bytesPerRow = (width * 4);
	
	ref = CGBitmapContextCreate(NULL,
								width, height,
								8, bytesPerRow,
								space, kCGImageAlphaPremultipliedLast);
	if (ref == NULL) {
		CGColorSpaceRelease(space);
		CWLogInfo(@"CWGraphicsFoundation: CGBitmapContext not allocated");
		return NULL;
	}
	CGColorSpaceRelease(space);
	return ref;
}

CGColorRef CWCreateCGColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGColorRef color = CWCreateCGColorWithSpace(r, g, b, a, space);
	CGColorSpaceRelease(space);
	return color;
}

CGColorRef CWCreateCGColorWithSpace(CGFloat r, CGFloat g, CGFloat b, CGFloat a, CGColorSpaceRef cspace) {
	if(cspace == NULL) { return NULL; }
	CGFloat components[4];
	components[0] = r; components[1] = g; components[2] = b; components[3] = a;
	CGColorRef colorRef = CGColorCreate(cspace, components);
	return colorRef;
}

#define CWCGColor(_name_,red,blue,green) \
CGColorRef CWCGColor##_name_(CGFloat alpha) \
{ \
	CGFloat r = CWCGColorFloat(red); \
	CGFloat g = CWCGColorFloat(green); \
	CGFloat b = CWCGColorFloat(blue); \
	CGFloat a = alpha; \
	CGColorRef color = CWCreateCGColor(r,g,b,a); \
	return color; \
}

CWCGColor(LightGray, 211, 211, 211);
CWCGColor(Gray,190,190,190);
CWCGColor(DarkGray,105,105,105);
CWCGColor(Blue,0,0,255);

#undef CWCGColor
