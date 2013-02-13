//
//  CWNSColorAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWNSColorAdditionsTests.h"
#import "NSColorAdditions.h"

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
