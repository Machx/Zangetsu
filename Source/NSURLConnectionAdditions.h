//
//  NSURLConnectionAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSURLConnection (CWNSURLConnectionAdditions)

+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						  onGCDQueue:(dispatch_queue_t)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block;

+(NSData *)cw_performGCDSynchronousRequest:(NSURLRequest *)request 
								  response:(NSURLResponse **)response 
								  andError:(NSError **)error;

@end
