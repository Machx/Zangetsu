/*
//  NSColor+CWNSColorAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/12.
//  Copyright (c) 2012. All rights reserved.
//
 	*/
 
#import <AppKit/AppKit.h>

@interface NSColor (CWNSColorAdditions)
/**
 Converts a NSColor to its equivalent CGColorRef
 
 Given a valid NSColor object, this method takes that NSColor object and creates
 an equivalent CGColorRef object from it. This method returns an owned 
 CGColorRef object which you must free when you are done with it.
 
 @return a CGColorRef object equivalent to the receiving NSColor object	*/
-(CGColorRef)cw_CGColor CF_RETURNS_RETAINED;
@end
