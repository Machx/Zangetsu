/*
//  CWGraphicsFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
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

#import "CWGraphicsFoundation.h"

inline CGContextRef CWCurrentCGContext()
{
#if Z_HOST_OS_IS_MAC_OS_X
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
#else
	return UIGraphicsGetCurrentContext();
#endif
}

CGRect CWCenteredRect(CGRect smallRect, CGRect largeRect) 
{
	CGRect centeredRect;
	centeredRect.size = smallRect.size;
	centeredRect.origin.x = (largeRect.size.width - smallRect.size.width) * 0.5;
	centeredRect.origin.y = (largeRect.size.height - smallRect.size.height) * 0.5;
	return centeredRect;
}

void CWAddRoundedRectToPath(CGContextRef context,
						  CGRect rect,
						  float ovalWidth,
						  float ovalHeight) 
{	
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

void CWSaveAndRestoreCGContextState(CGContextRef ctx, void(^block)(void)) 
{
	CGContextSaveGState(ctx);
	block();
	CGContextRestoreGState(ctx);
}

void CWContextDrawLinearGradientBetweenPoints(CGContextRef context,
											  CGPoint point1, CGFloat color1[4],
											  CGPoint point2, CGFloat color2[4])
{
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGFloat components[] = { color1[0], color1[1], color1[2], color1[3], color2[0], color2[1], color2[2], color2[3] };
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL, 2);
	CGContextDrawLinearGradient(context, gradient, point1, point2, 0);
	CGGradientRelease(gradient);
	CGColorSpaceRelease(space);
}

CGContextRef CWImageContextWithSize(NSInteger width, NSInteger height)
{
	CGContextRef ref = NULL;
	CGColorSpaceRef space = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
	NSInteger bytesPerRow = (width * 4);
	
	ref = CGBitmapContextCreate(NULL,
								width, height,
								8, bytesPerRow,
								space, kCGImageAlphaPremultipliedLast);
	if (ref == NULL) {
		CGColorSpaceRelease(space);
		CWDebugLog(@"CWGraphicsFoundation: CGBitmapContext not allocated");
		return NULL;
	}
	CGColorSpaceRelease(space);
	return ref;
}

CGColorRef CWCreateCGColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGColorRef color = CWCreateCGColorWithSpace(r, g, b, a, space);
	CGColorSpaceRelease(space);
	return color;
}

CGColorRef CWCreateCGColorWithSpace(CGFloat r, CGFloat g, CGFloat b, CGFloat a, CGColorSpaceRef cspace)
{
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
