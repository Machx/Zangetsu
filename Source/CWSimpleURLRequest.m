/*
//  CWSimpleURLRequest.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/13/11.
//  Copyright (c) 2011. All rights reserved.
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
 
/**
 This is the class that eventually will replace (become) CWURLRequest. As 
 CWURLRequest was writen over a period of time so too this class will take
 a while to ramp up to replace all/most of CWURLRequests methods.
 */

#import "CWSimpleURLRequest.h"

@interface CWSimpleURLRequest()
//Public Readonly rewritten
@property(nonatomic, readwrite, retain) NSString *urlHost;
//Private only
@property(nonatomic, retain) NSString *httpAuthorizationHeader;
-(NSURLRequest *)_createInternalURLRequest;
@end

@implementation CWSimpleURLRequest

@synthesize urlHost;
@synthesize httpAuthorizationHeader;

-(id)initWithHost:(NSString *)host {
	self = [super init];
	if (self) {
		urlHost = host;
		httpAuthorizationHeader = nil;
	}
	return self;
}

-(void)setAuthorizationHeaderLogin:(NSString *)login 
					   andPassword:(NSString *)passwd {
	if (login && passwd) {
		NSString *base64AuthString = CWURLAuthorizationHeaderString(login, passwd);
		if (base64AuthString) {
			[self setHttpAuthorizationHeader:base64AuthString];
		}
	}
}

-(NSURLRequest *)_createInternalURLRequest {
	if ([self urlHost]) {
		NSURL *url = [NSURL URLWithString:[self urlHost]];
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
		if ([self httpAuthorizationHeader]) {
			[request cw_setHTTPAuthorizationHeaderFieldString:[self httpAuthorizationHeader]];
		}
		return (NSURLRequest *)request;
	}
	return nil;
}

-(NSData *)startSynchronousConnectionWithError:(NSError **)error {
	
	NSURLRequest *request = [self _createInternalURLRequest];
	if (request) {
		NSURLResponse *resp;
		
		NSData *requestData = nil;
		requestData = [NSURLConnection sendSynchronousRequest:request
											returningResponse:&resp
														error:error];
		return requestData;
	}
	
	return nil;
}

@end
