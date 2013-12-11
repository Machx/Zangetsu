/*
 *  CWMacros.h
 *  Gitty
 *
 *  Created by Colin Wheeler on 5/17/09.
 *  Copyright 2009. All rights reserved.
 *
 
 Copyright (c) 2013, Colin Wheeler
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#define Z_OS_IS_OSX !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#pragma mark - General Functions
#define NSSET(...) [NSSet setWithObjects: __VA_ARGS__, nil]

#if !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
#define NSCOLOR(r,g,b,a) [NSColor colorWithCalibratedRed:r green:g blue:b alpha:a]
#define NSDEVICECOLOR(r,g,b,a) [NSColor colorWithDeviceRed:r green:g blue:b alpha:a]
#endif

#pragma mark - Log Functions

#ifdef DEBUG
#	define CWPrintClassAndMethod() NSLog(@"%s L#%i:\n",__PRETTY_FUNCTION__,__LINE__)
#else
#	define CWPrintClassAndMethod() /**/
#endif

#define CWLogMethodAndLine() NSLog(@"%s L#%i",__PRETTY_FUNCTION__,__LINE__)

#define CWConditionalLog(cond,args...) \
do { \
	if((cond)){ \
		NSLog(@"%s L#%i: %@",__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args]); \
	} \
} while(0);
	

#pragma mark - GCD Macros

#define CWGCDPriorityQueueLow() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0)
#define CWGCDPriorityQueueNormal() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define CWGCDPriorityQueueHigh() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)
#define CWGCDPriorityQueueBackground() dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0)
