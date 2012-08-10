/*
//  CWGraphicsFoundation.h
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


#if Z_HOST_OS_IS_MAC_OS_X
#import <Cocoa/Cocoa.h>
#else
#import <UIKit/UIKit.h>
#endif

#define CWCGColorFloat(_x_) (_x_ / 255)

extern CGRect CWCenteredRect(CGRect smallRect, CGRect largeRect);

/**
 Easy way to return the CGContextRef inside a NSView
 */
extern CGContextRef CWCurrentCGContext();

/**
 Adds a rounded rect path to a CGContextRef
 */
extern void CWAddRoundedRectToPath(CGContextRef context,
								   CGRect rect,
								   float ovalWidth,
								   float ovalHeight);

/**
 Saves the CGContext state, executes the block and then restores the context State.
 
 @param ctx a CGContextRef you wish to operate on
 @param block a block containing code you wish to execute between saving & restoring the CGContextRef state
 */
extern void CWSaveAndRestoreCGContextState(CGContextRef ctx, void(^block)(void));

/**
 Draws a Linear gradient between 2 points using Core Graphics
 
 @param context the CGContextRef the drawing is to occurr on
 @param point1 a CGPoint, the starting point for where the gradient should be drawn
 @param point2 a CGPoint, the ending point for where the gradient should be drawn
 @param colora the starting Color for the gradient
 @param colorb the ending Color for the gradient
 */
extern void CWContextDrawLinearGradientBetweenPoints(CGContextRef context,
													 CGPoint point1, CGFloat color1[4],
													 CGPoint point2, CGFloat color2[4]);

/**
 Easy way to Create a CGColorRef using the Device RGB Colorspace.
 
 @param r a CGFloat representing the red component of the CGColorRef
 @param g a CGFloat representing the blue component of the CGColorRef
 @param b a CGFloat representing the green component of the CGColorRef
 @param a a CGFloat representing the alpha component of the CGColorRef
 @return a CGColorRef object created with the components specified in the parameters, you must release this object when done with it
 */
extern CGColorRef CWCreateCGColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a);

/**
 Easy way to Create a CGColorRef
 
 @param r a CGFloat representing the red component of the CGColorRef
 @param g a CGFloat representing the blue component of the CGColorRef
 @param b a CGFloat representing the green component of the CGColorRef
 @param a a CGFloat representing the alpha component of the CGColorRef
 @param cspace the CGColorSpaceRef you want the CGColorRef to be created with. This cannot be NULL, if it is NULL this method returns NULL.
 @return a CGColorRef object created with the components specified in the parameters, you must release this object when done with it
 */
extern CGColorRef CWCreateCGColorWithSpace(CGFloat r, CGFloat g, CGFloat b, CGFloat a, CGColorSpaceRef cspace);

#define CWCGColorMethod(_name_) extern CGColorRef CWCGColor##_name_(CGFloat alpha) CF_RETURNS_RETAINED

CWCGColorMethod(LightGray);
CWCGColorMethod(Gray);
CWCGColorMethod(DarkGray);
CWCGColorMethod(Blue);

#undef CWCGColorMethod
