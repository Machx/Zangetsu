/*
//  CWBlockTimer.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/10/12.
//
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

@interface CWBlockTimer ()
@property(copy) dispatch_block_t invocationBlock;
@property(readwrite,retain) NSTimer *internalTimer;
-(void)p_internalInvokeBlock:(NSTimer *)timer;
@end

@implementation CWBlockTimer

- (id)init {
    self = [super init];
    if (self) {
		_internalTimer = nil;
		_invocationBlock = nil;
    }
    return self;
}

+(CWBlockTimer *)timerWithTimeInterval:(NSTimeInterval)interval
							   repeats:(BOOL)repeats
								 block:(dispatch_block_t)block {
	CWAssert(block != nil);
	
	CWBlockTimer *timer = [CWBlockTimer new];
	timer.internalTimer = [NSTimer scheduledTimerWithTimeInterval:interval
														   target:timer
														 selector:@selector(p_internalInvokeBlock:)
														 userInfo:nil
														  repeats:repeats];
	timer.invocationBlock = block;
	return timer;
}

-(void)fire {
	[self p_internalInvokeBlock:self.internalTimer];
}

-(void)invalidate {
	[self.internalTimer invalidate];
}

-(BOOL)isValid {
	return self.internalTimer.isValid;
}
				   
-(void)p_internalInvokeBlock:(NSTimer *)timer {
	if ([timer isEqual:self.internalTimer] && self.invocationBlock) {
		self.invocationBlock();
	} else {
		CWLogInfo(@"ERROR: No invocation block to invoke for timer...");
	}
}

-(void)dealloc {
	[_internalTimer invalidate];
}

@end
