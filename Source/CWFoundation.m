//
//  CWFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/16/10.
//  Copyright 2010. All rights reserved.
//

#import "CWFoundation.h"

BOOL CWClassExists(NSString * class)
{
	Class _class = NSClassFromString(class);
	
	return (_class) ? YES : NO;
}

@implementation CWFoundation

@end
