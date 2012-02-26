/*
//  CWBlockQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/23/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

#import "CWLightBlockQueue.h"

@interface CWLightBlockOperation()
@property(nonatomic,copy) dispatch_block_t operationBlock;
@end

@implementation CWLightBlockOperation

@synthesize operationBlock = _operationBlock;
@synthesize completionBlock = _completionBlock;

- (id)init
{
    self = [super init];
    if (self) {
        _operationBlock = NULL;
		_completionBlock = NULL;
    }
    return self;
}

+(CWLightBlockOperation *)blockOperationWithBlock:(dispatch_block_t)block
{
	CWLightBlockOperation *operation = [[CWLightBlockOperation alloc] init];
	if (operation) {
		[operation setOperationBlock:block];
		return operation;
	}
	return nil;
}

@end

@interface CWLightBlockQueue()
@property(atomic,assign) BOOL shouldProcessBlocks;
@property(atomic,retain) CWQueue *queue;
@property(readwrite,assign) BOOL isProcessingBlocks;
-(void)_processBlocks;
@end

@implementation CWLightBlockQueue

@synthesize queue = _queue;
@synthesize shouldProcessBlocks = _shouldProcessBlocks;
@synthesize isProcessingBlocks = _isProcessingBlocks;

- (id)init
{
    self = [super init];
    if (self) {
        _queue = [[CWQueue alloc] init];
		_shouldProcessBlocks = NO;
		_isProcessingBlocks = NO;
    }
    return self;
}

-(id)initWithBlockOperationObjects:(NSArray *)blockOperations 
				processImmediately:(BOOL)startImmediately
{
	self = [super init];
	if (self) {
		_queue = [[CWQueue alloc] initWithObjectsFromArray:blockOperations];
		_shouldProcessBlocks = startImmediately;
		_isProcessingBlocks = NO;
		if (_shouldProcessBlocks == YES) {
			[self performSelector:@selector(_processBlocks) 
					   withObject:nil 
					   afterDelay:0];
		}
	}
	return self;
}

-(void)startProcessingBlocks
{
	if ([self shouldProcessBlocks] == NO) {
		[self setShouldProcessBlocks:YES];
		[self performSelector:@selector(_processBlocks) 
				   withObject:nil
				   afterDelay:0];
	}
}

-(void)stopProcessingBlocks
{
	[self setShouldProcessBlocks:NO];
}

-(void)addOperationwithBlock:(dispatch_block_t)block
{
	CWLightBlockOperation *op = [CWLightBlockOperation blockOperationWithBlock:block];
	if (op) {
		[[self queue] addObject:op];
		[self startProcessingBlocks];
	}
}

-(void)_processBlocks
{
	[self setIsProcessingBlocks:YES];
	while ([self shouldProcessBlocks] == YES) {
		@autoreleasepool {
			id blockOp = [[self queue] dequeueTopObject];
			if (blockOp && [blockOp isMemberOfClass:[CWLightBlockOperation class]]) {
				CWLightBlockOperation *operation = (CWLightBlockOperation *)blockOp;
				[operation operationBlock]();
				if ([operation completionBlock]) {
					[operation completionBlock]();
				}
			} else {
				[self setIsProcessingBlocks:NO];
				break;
			}
		}
	}
}

-(void)waitUntilAllBlocksHaveProcessed
{
	if (([[self queue] count] > 0) && [self shouldProcessBlocks]) {
		while ([self isProcessingBlocks]) {
			[[NSRunLoop currentRunLoop] run];
		}
		return;
	}
	CWDebugLog(@"Nothing to process...");
}

@end
