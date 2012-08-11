/*
//  CWBlockTimer.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/10/12.
//
//
 
 Copyright (c) 2012 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "CWBlockTimer.h"

@interface CWBlockTimer ()
@property(copy) dispatch_block_t invocationBlock;
@property(readwrite,retain) NSTimer *internalTimer;
-(void)_invokeBlock:(NSTimer *)timer;
@end

@implementation CWBlockTimer

- (id)init
{
    self = [super init];
    if (self) {
		_internalTimer = nil;
		_invocationBlock = nil;
    }
    return self;
}

+(CWBlockTimer *)timerWithTimeInterval:(NSTimeInterval)interval block:(dispatch_block_t)block repeats:(BOOL)repeats
{
	CWBlockTimer *timer = [CWBlockTimer new];
	timer.internalTimer = [NSTimer scheduledTimerWithTimeInterval:interval
														   target:timer
														 selector:@selector(_invokeBlock:)
														 userInfo:nil
														  repeats:repeats];
	timer.invocationBlock = block;
	return timer;
}
				   
-(void)_invokeBlock:(NSTimer *)timer
{
	if (self.invocationBlock && [timer isEqual:self.internalTimer]) {
		self.invocationBlock();
	} else {
		CWDebugLog(@"ERROR: No invocation block to invoke for timer...");
	}
}

-(void)dealloc
{
	[_internalTimer invalidate];
}

@end
