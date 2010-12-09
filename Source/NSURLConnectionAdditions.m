//
//  NSURLConnectionAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010 . All rights reserved.
//

#import "NSURLConnectionAdditions.h"


@implementation NSURLConnection (CWNSURLConnectionAdditions)

/**
 Checks the request & Queue parameters then adds an operation with
 a block onto the passed in queue and executes a synchronous request
 once the request is complete the method adds a block opertaion back
 on the main thread and executes the block
 */
+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						   onNSQueue:(NSOperationQueue *)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block
{
	NSParameterAssert(request);
	NSParameterAssert(queue);
	
	[queue addOperationWithBlock:^() {
		
		NSURLResponse *_response = nil;
		NSError *_error = nil;
		
		NSData *_data = [NSURLConnection sendSynchronousRequest:request
											  returningResponse:&_response 
														  error:&_error];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^() {
			block(_data,_response,_error);
		}];
	}];
}

/**
 Checks the Queue and request parameters then dispatches a block onto
 the passed in queue, executes a synchronous request and then dispatches
 a block back onto the main thread and executes the block passed in
 */
+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						  onGCDQueue:(dispatch_queue_t)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block
{
	NSParameterAssert(request);
	NSParameterAssert(queue);
	
	dispatch_async(queue, ^{
		
		NSURLResponse *_response = nil;
		NSError *_error = nil;
		
		NSData *_data = [NSURLConnection sendSynchronousRequest:request
											  returningResponse:&_response 
														  error:&_error];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			block(_data,_response,_error);
		});
	});
}

/**
 Checks the passed in NSURLRequest and then uses dispatch_sync to 
 perform the syncrhonous request. In general this is used only in 
 some specific cercumstances otherwise this could potentially
 block the main thread (if you are executing this method on there.)
 */
+(NSData *)cw_performGCDSynchronousRequest:(NSURLRequest *)request 
								  response:(NSURLResponse **)response 
								  andError:(NSError **)error
{
	NSParameterAssert(request);
	
	__block NSData *data = nil;
	__block NSURLResponse *resp = nil;
	__block NSError *err = nil;
	
	dispatch_sync(dispatch_get_global_queue(0, 0), ^{
		data = [NSURLConnection sendSynchronousRequest:request 
									 returningResponse:&resp 
												 error:&err];
	});
	
	*response = resp;
	*error = err;
	
	return data;
}

@end
