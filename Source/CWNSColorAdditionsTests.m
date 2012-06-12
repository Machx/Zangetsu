//
//  CWNSColorAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 6/12/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "CWNSColorAdditionsTests.h"
#import "NSColorAdditions.h"

@implementation CWNSColorAdditionsTests

-(void)testRGBAValues
{
	NSColor *colorA = [NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1.0];
	
	CGColorRef colorB = [colorA cw_CGColor];
	
	int numberOfComponents = CGColorGetNumberOfComponents(colorB);
	STAssertTrue(numberOfComponents == 4,@"");
	
	const CGFloat *components = CGColorGetComponents(colorB);
	
	CGFloat colorARed = [colorA redComponent];
	CGFloat colorBRed = components[0];
	STAssertTrue(colorARed == colorBRed,@"");
	
	CGFloat colorAGreen = [colorA greenComponent];
	CGFloat colorBGreen = components[1];
	STAssertTrue(colorAGreen == colorBGreen,@"");
	
	CGFloat colorABlue = [colorA blueComponent];
	CGFloat colorBBlue = components[2];
	STAssertTrue(colorABlue == colorBBlue,@"");
	
	CGFloat colorAAlpha = [colorA alphaComponent];
	CGFloat colorBAlpha = components[3];
	STAssertTrue(colorAAlpha == colorBAlpha,@"");
	
	CGColorRelease(colorB);
}

@end
