/*
//  CWFoundation.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/16/10.
//  Copyright 2010. All rights reserved.
//
 	*/
 
#import <Foundation/Foundation.h>

/**
 Determines if an Objective-C Class exists in the Objective-C Runtime
 
 Until true weak linking classes comes to the Mac OS X & iOS SDKs
 this will be necessary to determine if a class exists or not. Internally
 this uses NSClassFromString() if a Class object is returned the class 
 does exist in the runtime, otherwise it doesn't.
 
 @param class a NSString with the name of an Objective-C Class
 @return a BOOL with YES if the class exists or no if it doesn't	*/
BOOL CWClassExists(NSString * class);

/**
<<<<<<< HEAD
 Returns a NSString value of 'YES' or 'NO' corresponding to the bool value passed in
 
 @param value a BOOL value of YES or NO
 @return a NSString value of @"YES" if YES was passed in or @"NO" if NO was passed in	*/
NSString *CWBOOLString(BOOL value);

/**
 Returns a unique NSString prepended by the passed in string
 
 @param preString the string to be prepended on the unique string
 @return a string containing the preString argument prepended onto a unique string value	*/
=======
 Returns a unique NSString prepended by the passed in string
 
 @param preString the string to be prepended on the unique string
 @return NSString with a UUID String prepended with the prestring argument
 */
>>>>>>> upstream/master
NSString *CWUUIDStringPrependedWithString(NSString *preString);

/**
 Returns a unique c string prepended by the passed in string
 
 @param preString the string to be prepended on the unique string
<<<<<<< HEAD
 @return a string containing the preString argument prepended onto a unique string value	*/
=======
 @return C String with a UUID String prepended with the prestring argument
 */
>>>>>>> upstream/master
const char *CWUUIDCStringPrependedWithString(NSString *preString);

/**
 Schedules the block to be executed on the next run loop on the main thread
 
 @param block the block to be executed on the next runloop on the main thread	*/
void CWNextRunLoop(dispatch_block_t block);

/**
 Inspired by println in Go, Prints all the variables, space seperated,to NSLog()
 
 @args all the variables you want printed to NSLog()	*/
void CWPrintLine(NSArray *args);

/**
 Inspired by println in Go, Prints all the variable, space separated, to printf
 
 @args all the variables you want printed to printf()	*/
void CWPrintfLine(NSArray *args);
