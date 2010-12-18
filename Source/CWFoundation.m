//
//  CWFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/16/10.
//  Copyright 2010. All rights reserved.
//

#import "CWFoundation.h"

/**
 Until true weak linking classes comes to the Mac OS X & iOS SDKs
 this will be necessary to determine if a class exists or not
 */
BOOL CWClassExists(NSString * class)
{
	Class _class = NSClassFromString(class);
	
	return (_class) ? YES : NO;
}
