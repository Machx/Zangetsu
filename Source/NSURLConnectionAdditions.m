/*
//  NSURLConnectionAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010 . All rights reserved.
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

#import "NSURLConnectionAdditions.h"


@implementation NSURLConnection (CWNSURLConnectionAdditions)

+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						  onGCDQueue:(dispatch_queue_t)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block {
	CWAssert(request != nil);
	CWAssert(queue != nil);
	dispatch_async(queue, ^{
		NSURLResponse *aResponse = nil;
		NSError *urlError;
		NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
											  returningResponse:&aResponse
														  error:&urlError];
		dispatch_async(dispatch_get_main_queue(), ^{
			block(receivedData,aResponse,urlError);
		});
	});
}

+(NSData *)cw_performGCDSynchronousRequest:(NSURLRequest *)request 
								  response:(NSURLResponse **)response 
								  andError:(NSError **)error {
	CWAssert(request != nil);
	__block NSData *data;
	__block NSURLResponse *resp;
	__block NSError *err;
	dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		data = [NSURLConnection sendSynchronousRequest:request 
									 returningResponse:&resp 
												 error:&err];
	});
	if(response) *response = resp;
	if(error) *error = err;
	return data;
}

@end
