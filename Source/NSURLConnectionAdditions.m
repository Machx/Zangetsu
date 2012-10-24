/*
//  NSURLConnectionAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010 . All rights reserved.
//
 
 */

#import "NSURLConnectionAdditions.h"


@implementation NSURLConnection (CWNSURLConnectionAdditions)

+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						  onGCDQueue:(dispatch_queue_t)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block
{
	NSParameterAssert(request);
	NSParameterAssert(queue);
	
	dispatch_async(queue, ^{
		
		NSURLResponse *_response = nil;
		NSError *_urlError;
		NSData *_data = [NSURLConnection sendSynchronousRequest:request
											  returningResponse:&_response 
														  error:&_urlError];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			block(_data,_response,_urlError);
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
	__block NSError *err;
	
	dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		data = [NSURLConnection sendSynchronousRequest:request 
									 returningResponse:&resp 
												 error:&err];
	});
	
	*response = resp;
	if (*error) { *error = err; }
	
	return data;
}

@end
