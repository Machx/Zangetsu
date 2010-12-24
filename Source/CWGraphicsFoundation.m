//
//  CWGraphicsFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
//

#import "CWGraphicsFoundation.h"

CGContextRef CWCurrentCGContext()
{
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
}
