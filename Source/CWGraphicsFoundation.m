/*
//  CWGraphicsFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
//

Copyright (c) 2011 Colin Wheeler

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

CGRect CWCenteredRect(CGRect smallRect, CGRect largeRect) {
	CGRect centeredRect;
	centeredRect.size = smallRect.size;
	centeredRect.origin.x = (largeRect.size.width - smallRect.size.width) / 2.0;
	centeredRect.origin.y = (largeRect.size.height - smallRect.size.height) / 2.0;
	return centeredRect;
}

/**
 Easy way to return the CGContextRef inside a NSView
 */
inline CGContextRef CWCurrentCGContext() {
#if !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
#else
	return UIGraphicsGetCurrentContext();
#endif
}

/**
 Adds a rounded rect path to a CGContextRef
 */
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
