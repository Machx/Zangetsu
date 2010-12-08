//
//  NSURLConnectionAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010 . All rights reserved.
//

#import "NSURLConnectionAdditions.h"


@implementation NSURLConnection (CWNSURLConnectionAdditions)

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
