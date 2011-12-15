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

@interface CWSimpleURLRequest() <NSURLConnectionDelegate>
//Public Readonly rewritten
@property(nonatomic, readwrite, retain) NSString *urlHost;
//Private only
@property(nonatomic, retain) NSString *httpAuthorizationHeader;
@property(nonatomic, retain) NSURLConnection *instanceConnection;
@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, assign) BOOL connectionIsFinished;
-(NSMutableURLRequest *)_createInternalURLRequest;
@end

@implementation CWSimpleURLRequest

@synthesize urlHost;
@synthesize httpAuthorizationHeader;
@synthesize instanceConnection;
@synthesize connectionIsFinished;
@synthesize receivedData;

-(id)initWithHost:(NSString *)host {
	self = [super init];
	if (self) {
		urlHost = host;
		httpAuthorizationHeader = nil;
		instanceConnection = nil;
		receivedData = [[NSMutableData alloc] init];
	}
	return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@: Host: %@\nUses Auth Header: %@",
			NSStringFromClass([self class]),
			[self urlHost],
			CWBOOLString((BOOL)[self httpAuthorizationHeader])];
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

-(NSMutableURLRequest *)_createInternalURLRequest {
	if ([self urlHost]) {
		NSURL *url = [NSURL URLWithString:[self urlHost]];
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
		if ([self httpAuthorizationHeader]) {
			[request cw_setHTTPAuthorizationHeaderFieldString:[self httpAuthorizationHeader]];
		}
		return request;
	}
	return nil;
}

-(NSData *)startSynchronousConnectionWithError:(NSError **)error {
	NSMutableURLRequest *request = [self _createInternalURLRequest];
	if (request) {
		NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		[connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[self setInstanceConnection:connection];
		[[self instanceConnection] start];
		
		while ([self connectionIsFinished] == NO) {
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		}
		
		return [self receivedData];
	}
	if (*error) {
		*error = CWCreateError(404, @"com.Zangetsu.CWSimpleURLRequest", 
							   @"Host is nil and therefore cannot be used for a connection");
	}
	return nil;
}

//MARK: NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	if ([connection isEqual:[self instanceConnection]]) {
		[[self receivedData] appendData:data];
	}
}

-(NSURLRequest *)connection:(NSURLConnection *)connection 
			willSendRequest:(NSURLRequest *)request 
		   redirectResponse:(NSURLResponse *)response {
	if ([[self instanceConnection] isEqual:connection] && request) {
		NSURLRequest *newRequest = [[NSURLRequest alloc] initWithURL:[request URL]];
		return newRequest;
	}
	return nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if ([[self instanceConnection] isEqual:connection]) {
		[self setConnectionIsFinished:YES];
	}
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if ([[self instanceConnection] isEqual:connection]) {
		[self setConnectionIsFinished:YES];
		CWLogError(error);
	}
}

@end
