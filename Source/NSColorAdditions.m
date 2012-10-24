/*
//  NSColor+CWNSColorAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 */

#import "NSColorAdditions.h"

@implementation NSColor (CWNSColorAdditions)

-(CGColorRef)cw_CGColor
{
	NSColor *nscolor = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	CGFloat components[4];
	[nscolor getRed:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
	CGColorSpaceRef space = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
	CGColorRef cgColor = CGColorCreate(space, components);
	CGColorSpaceRelease(space);
	return cgColor;
}

@end
