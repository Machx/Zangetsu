/*
 //  CWBlockTimer.h
 //  ObjC_Playground
 //
 //  Created by Colin Wheeler on 7/25/13.
 //  Copyright (c) 2013 Colin Wheeler. All rights reserved.
 //
 
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

#import <Foundation/Foundation.h>

/**
 CWBlockTimer is a simple class that is designed to be a minimal wrapper around
 Grand Central Dispatch and its dispatch_source timer API. Internally it sets
 up a dispatch_source_t object and configures it with the time interval, queue
 and block you give it. Then it will immediately begin firing the block at the
 time interval you give it.
 
 To stop the timer forever, call the -invalidate method which will take care of
 that, or just let ARC dealloc a CWBlockTimer instance and that will also
 stop the timer.
 
 Do not call -init on CWBlockTimer as it will just log a message warning you
 that you called the wrong init method and return nil. Call one of the
 initializers listed below.
 */

@interface CWBlockTimer : NSObject

/**
 Creates a new CWBlockTimer instance
 
 This creates a new timer instance set to fire the block passed in on the queue
 given every interval seconds. This default timer also gives the system a
 default leeway of half a second for the system delaying the timer. If you want
 to set the leeway for the timer yourself you should use the alternate init
 method that lets you specify the leeway for the timer.
 
 @param interval seconds between timer firing
 @param queue block should be executed on. Must not be null
 @param block to be executed by the timer
 @return a new CWBlockTimer configured instance
 */
- (id)initWithTimeInterval:(NSTimeInterval)interval
				   onQueue:(dispatch_queue_t)queue
				 withBlock:(dispatch_block_t)block;

/**
 Creates a new CWBlockTimer instance
 
 This creates a new timer instance set to fire the block passed in on the queue
 given every interval seconds.
 
 @param interval seconds between timer firing
 @param leeway the time in nanoseconds that the system can deferr the timer
 @param queue block should be executed on. Must not be null
 @param block to be executed by the timer
 @return a new CWBlockTimer configured instance
 */
- (id)initWithTimeInterval:(NSTimeInterval)interval
					leeway:(uint64_t)leeway
				   onQueue:(dispatch_queue_t)queue
				 withBlock:(dispatch_block_t)block;

/**
 Invalidates the timer so it stops firing.
 
 Once the timer has been invalidated it will never fire again. You must dealloc
 the instance and create a new instance.
 */
-(void)invalidate;

@end
