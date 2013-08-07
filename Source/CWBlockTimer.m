/*
 //  CWBlockTimer.m
 //  Zangetsu
 //
 //  V2 - Rewritten using dispatch_source_t instead of NSTimer
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

#import "CWBlockTimer.h"
#import "CWAssertionMacros.h"

@interface CWBlockTimer ()
@property(nonatomic,assign) dispatch_source_t source;
@end

@implementation CWBlockTimer

- (id)init {
	NSLog(@"Wrong initializer for CWBlockTimer. Call -initWithTimeInterval:onQueue:withBlock:");
	return nil;
}

- (id)initWithTimeInterval:(NSTimeInterval)interval
				   onQueue:(dispatch_queue_t)queue
				 withBlock:(dispatch_block_t)block {
	CWAssert(queue != NULL);
	CWAssert(block != nil);
	
    self = [super init];
    if (self == nil) return self;
	
	_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	
	uint64_t nSec = (uint64_t)(interval * NSEC_PER_SEC);
	dispatch_source_set_timer(_source,
							  dispatch_time(DISPATCH_TIME_NOW, nSec),
							  nSec,
							  (0.5 * NSEC_PER_SEC));
	
	dispatch_source_set_event_handler(_source, block);
	dispatch_resume(_source);
	
    return self;
}

- (id)initWithTimeInterval:(NSTimeInterval)interval
					leeway:(uint64_t)leeway
				   onQueue:(dispatch_queue_t)queue
				 withBlock:(dispatch_block_t)block {
	CWAssert(queue != NULL);
	CWAssert(block != nil);
	
    self = [super init];
    if (self == nil) return self;
	
	_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	
	uint64_t nSec = (uint64_t)(interval * NSEC_PER_SEC);
	dispatch_source_set_timer(_source,
							  dispatch_time(DISPATCH_TIME_NOW, nSec),
							  nSec,
							  leeway);
	
	dispatch_source_set_event_handler(_source, block);
	dispatch_resume(_source);
	
    return self;
}

-(void)invalidate {
	if (self.source) {
		dispatch_source_cancel(self.source);
		dispatch_release(self.source);
		self.source = nil;
	}
}

- (void)dealloc {
    if (_source) {
		dispatch_source_cancel(_source);
		dispatch_release(_source);
		_source = nil;
	}
}

@end
