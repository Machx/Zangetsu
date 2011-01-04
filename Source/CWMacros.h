/*
 *  CWMacros.h
 *  Gitty
 *
 *  Created by Colin Wheeler on 5/17/09.
 *  Copyright 2009. All rights reserved.
 *
 */

#pragma mark General Functions

#define NSDICT(...) [NSDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]
#define NSARRAY(...) [NSArray arrayWithObjects: __VA_ARGS__, nil]
#define NSBOOL(_X_) [NSNumber numberWithBool:(_X_)]
#define NSSET(...) [NSSet setWithObjects: __VA_ARGS__, nil]

#pragma mark -
#pragma mark Log Functions

#ifdef DEBUG
#	define CWPrintClassAndMethod() NSLog(@"%s%i:\n",__PRETTY_FUNCTION__,__LINE__)
#	define CWLog(args...) NSLog(@"%s%i: %@",__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])
#else
#	define CWPrintClassAndMethod() /**/
#	define CWLog(args...) /**/
#endif

#pragma mark -
#pragma mark NSAssert Functions

#ifdef DEBUG
#	define CWAssert(cond,desc) NSAssert(cond,desc)
#	define CWAssert1(cond,desc,a1) NSAssert1(cond,desc,a1)
#	define CWAssert2(cond,desc,a1,a2) NSAssert2(cond,desc,a1,a2)
#	define CWAssert3(cond,desc,a1,a2,a3) NSAssert3(cond,desc,a1,a2,a3)
#	define CWAssert4(cond,desc,a1,a2,a3,a4) NSAssert4(cond,desc,a1,a2,a3,a4)
#	define CWAssert5(cond,desc,a1,a2,a3,a4,a5) NSAssert5(cond,desc,a1,a2,a3,a4,a5)
#else
#	define CWAssert(...) /**/
#	define CWAssert1(...) /**/
#	define CWAssert2(...) /**/
#	define CWAssert3(...) /**/
#	define CWAssert4(...) /**/
#	define CWAssert5(...) /**/
#endif

#pragma mark -
#pragma mark Garbage Collection

#define CWDefaultCollector() [NSGarbageCollector defaultCollector]
#define CWGCCollectIfNeeded() [[NSGarbageCollector defaultCollector] collectIfNeeded]
#define CWGCCollectExaustively() [[NSGarbageCollector defaultCollector] collectExhaustively]
