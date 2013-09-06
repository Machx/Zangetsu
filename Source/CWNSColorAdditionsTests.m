/*
//  CWNSColorAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/12/12.
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

#import "CWNSColorAdditionsTests.h"
#import "NSColor+CGColor.h"

SpecBegin(NSColorAdditions)

it(@"should create a correct CGColor object from a NSColor Object", ^{
	NSColor *colorA = [NSColor colorWithCalibratedRed:0.5
												green:0.5
												 blue:0.5
												alpha:1.0];
	CGColorRef colorB = [colorA cw_CGColor];
	
	int numberOfComponents = (int)CGColorGetNumberOfComponents(colorB);
	expect(numberOfComponents == 4).to.beTruthy();
	
	const CGFloat *components = CGColorGetComponents(colorB);
	
	CGFloat colorARed = [colorA redComponent];
	CGFloat colorBRed = components[0];
	expect(colorARed == colorBRed).to.beTruthy();
	
	CGFloat colorAGreen = [colorA greenComponent];
	CGFloat colorBGreen = components[1];
	expect(colorAGreen == colorBGreen).to.beTruthy();
	
	CGFloat colorABlue = [colorA blueComponent];
	CGFloat colorBBlue = components[2];
	expect(colorABlue == colorBBlue).to.beTruthy();
	
	CGFloat colorAAlpha = [colorA alphaComponent];
	CGFloat colorBAlpha = components[3];
	expect(colorAAlpha == colorBAlpha).to.beTruthy();
	
	CGColorRelease(colorB);
});

SpecEnd
