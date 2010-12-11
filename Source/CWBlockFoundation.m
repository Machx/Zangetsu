//
//  CWBlockFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//

#import "CWBlockFoundation.h"


@implementation CWBlockFoundation

@end

void inAutoreleasePool(VoidBlock block)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	block();
	[pool drain];
}
