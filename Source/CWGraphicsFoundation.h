/*
//  CWGraphicsFoundation.h
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


#if Z_OS_IS_OSX
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
 Saves the CGContext state, executes the block & then restores the context State
 
 @param ctx a CGContextRef you wish to operate on
 @param block a block to execute between saving & restoring CGContextRef state
 */
extern void CWSaveAndRestoreCGContextState(CGContextRef ctx, void(^block)(void));

/**
 Creates a CGContextRef for drawing images into with the width & height provided
 
 The object that is returned is your responsibility to free when done with it.
 
 @param width the width of the context in pixels
 @param height the height of the context in pixels
 @return CGContextRef for drawing images into that you must free
 */
extern CGContextRef CWImageContextWithSize(NSInteger width, NSInteger height) CF_RETURNS_RETAINED;

/**
 Draws a Linear gradient between 2 points using Core Graphics
 
 @param context the CGContextRef the drawing is to occurr on
 @param point1 the starting point for where the gradient should be drawn
 @param point2 the ending point for where the gradient should be drawn
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
 @return a CGColorRef object that you must free when done with it
 */
extern CGColorRef CWCreateCGColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a);

/**
 Easy way to Create a CGColorRef
 
 @param r a CGFloat representing the red component of the CGColorRef
 @param g a CGFloat representing the blue component of the CGColorRef
 @param b a CGFloat representing the green component of the CGColorRef
 @param a a CGFloat representing the alpha component of the CGColorRef
 @param cspace color space to use, this cannot be NULL.
 @return a CGColorRef object that you must free when done or NULL
 */
extern CGColorRef CWCreateCGColorWithSpace(CGFloat r, CGFloat g, CGFloat b, CGFloat a, CGColorSpaceRef cspace);

#define CWCGColorMethod(_name_) extern CGColorRef CWCGColor##_name_(CGFloat alpha) CF_RETURNS_RETAINED

CWCGColorMethod(LightGray);
CWCGColorMethod(Gray);
CWCGColorMethod(DarkGray);
CWCGColorMethod(Blue);

#undef CWCGColorMethod
