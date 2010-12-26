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
CGContextRef CWCurrentCGContext()
{
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
}
