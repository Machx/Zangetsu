//
//  CWFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/16/10.
//  Copyright 2010. All rights reserved.
//

#import "CWFoundation.h"

/**
 Determines if an Objective-C Class exists in the Objective-C Runtime
 
 Until true weak linking classes comes to the Mac OS X & iOS SDKs
 this will be necessary to determine if a class exists or not. Internally
 this uses NSClassFromString() if a Class object is returned the class 
 does exist in the runtime, otherwise it doesn't.
 
 @param class a NSString with the name of an Objective-C Class
 @return a BOOL with YES if the class exists or no if it doesn't
 */
BOOL CWClassExists(NSString * class)
{
	Class _class = NSClassFromString(class);
	
	return (_class) ? YES : NO;
}
