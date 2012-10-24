/*
 *  CWMacros.h
 *  Gitty
 *
 *  Created by Colin Wheeler on 5/17/09.
 *  Copyright 2009. All rights reserved.
 *
 
 */
#define Z_HOST_OS_IS_MAC_OS_X !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#pragma mark - General Functions
#define NSSET(...) [NSSet setWithObjects: __VA_ARGS__, nil]

#define NSCOLOR(r,g,b,a) [NSColor colorWithCalibratedRed:r green:g blue:b alpha:a]
#define NSDEVICECOLOR(r,g,b,a) [NSColor colorWithDeviceRed:r green:g blue:b alpha:a]

#pragma mark - Log Functions

#ifdef DEBUG
#	define CWPrintClassAndMethod() NSLog(@"%s%i:\n",__PRETTY_FUNCTION__,__LINE__)
#	define CWDebugLog(args...) NSLog(@"%s%i: %@",__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])
#else
#	define CWPrintClassAndMethod() /**/
#	define CWDebugLog(args...) /**/
#endif

#define CWLog(args...) NSLog(@"%s%i: %@",__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])

#define CWDebugLocationString() [NSString stringWithFormat:@"%s[%i]",__PRETTY_FUNCTION__,__LINE__]

#define CWConditionalLog(cond,args...) \
do { \
	if((cond)){ \
		NSLog(@"%s%i: %@",__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args]); \
	} \
} while(0);
	

#pragma mark - GCD Macros

#define CWGCDQueueLow() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0)
#define CWGCDQueueNormal() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define CWGCDQueueHigh() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)
#define CWGCDQueueBackground() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0)
