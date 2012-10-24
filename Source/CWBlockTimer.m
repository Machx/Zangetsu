/*
//  CWBlockTimer.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/10/12.
//
//
 
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

+(CWBlockTimer *)timerWithTimeInterval:(NSTimeInterval)interval
							   repeats:(BOOL)repeats
								 block:(dispatch_block_t)block
{
	NSParameterAssert(block);
	
	CWBlockTimer *timer = [CWBlockTimer new];
	timer.internalTimer = [NSTimer scheduledTimerWithTimeInterval:interval
														   target:timer
														 selector:@selector(_invokeBlock:)
														 userInfo:nil
														  repeats:repeats];
	timer.invocationBlock = block;
	return timer;
}

-(void)fire
{
	[self _invokeBlock:self.internalTimer];
}

-(void)invalidate
{
	[self.internalTimer invalidate];
}

-(BOOL)isValid
{
	return [self.internalTimer isValid];
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
