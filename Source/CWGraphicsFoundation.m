//
//  CWGraphicsFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
//

#import "CWGraphicsFoundation.h"

/**
 Easy way to return the CGContextRef inside a NSView
 */
inline CGContextRef CWCurrentCGContext()
{
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
}

/**
 Allows you to pass in a CGContextRef and issue comamnds to it (via block) & automatically have its previous state restored
 
 @param context the CGContextRef you want to operate on
 @param block the block to be executed after saving the current state of the context & before restoring the previous state
 */
void CWExecuteAndRestoreCGContext(CGContextRef context,ContextBlock block) {
	CGContextSaveGState(context);
	block();
	CGContextRestoreGState(context);
}

/**
 Adds a rounded rect path to a CGContextRef
 */
void CWAddRoundedRectToPath(CGContextRef context,
						  CGRect rect,
						  float ovalWidth,
						  float ovalHeight)
{
    float fw, fh;
	
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
	
    CGContextSaveGState(context);
	
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
	
    CGContextRestoreGState(context);
}
