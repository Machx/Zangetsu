/*
//  CWURLRequest.m
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

#import "CWURLRequest.h"

static NSString * const kCWURLRequestErrorDomain = @"com.Zangetsu.CWSimpleURLRequest";

@interface CWURLRequest() <NSURLConnectionDelegate>
//Public Readonly rewritten
@property(nonatomic, readwrite, retain) NSString *urlHost;
@property(nonatomic, readwrite, retain) NSURLResponse *connectionResponse;
@property(nonatomic, readwrite, retain) NSError *connectionError;
//Private only
@property(nonatomic, retain) NSString *httpAuthorizationHeader;
@property(nonatomic, retain) NSURLConnection *instanceConnection;
@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, assign) BOOL connectionIsFinished;
-(NSMutableURLRequest *)_createInternalURLRequest;
@end

@implementation CWURLRequest

@synthesize urlHost = _urlHost;
@synthesize httpAuthorizationHeader = _httpAuthorizationHeader;
@synthesize instanceConnection = _instanceConnection;
@synthesize connectionIsFinished = _connectionIsFinished;
@synthesize receivedData = _receivedData;
@synthesize connectionResponse = _connectionResponse;
@synthesize connectionError = _connectionError;

/**
 Designated Initializer
 */
-(id)initWithHost:(NSString *)host {
	self = [super init];
	if (self) {
		_urlHost = host;
		_httpAuthorizationHeader = nil;
		_instanceConnection = nil;
		_receivedData = [[NSMutableData alloc] init];
		_connectionResponse = nil;
		_connectionError = nil;
	}
	return self;
}

/**
 A request object initialized this way is unusable.
 This is here just to give an error message when this 
 class is initialized incorrectly.
 */
-(id)init {
	self = [super init];
	if (self) {
		_urlHost = nil;
		_httpAuthorizationHeader = nil;
		_instanceConnection = nil;
		_connectionIsFinished = NO;
		_receivedData = nil;
		_connectionResponse = nil;
		_connectionError = CWCreateError(kCWURLRequestErrorDomain, kCWSimpleURLRequestNoHostError,
										@"Host is nil and therefore cannot be used for a connection");
	}
	return self;
}

/**
 Returns a debug description of the instance request class
 
 @return a NSString with debug information of the instance request class
 */
-(NSString *)description {
	return [NSString stringWithFormat:@"%@: Host: %@\nAuth Header: %@\nIs Finished Connecting: %@",
			NSStringFromClass([self class]),
			[self urlHost],
			[self httpAuthorizationHeader],
			CWBOOLString([self connectionIsFinished])];
}

#if !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
/**
 Creates the Base64 encoded http authorization header for the instance request
 
 Creates the authorization header string for the instance request. If either 
 login or passwd are nil then this method does nothing. Otherwise it creates
 a Base64 encoded http header string and will be used when this class creates
 it NSMutableURLRequest.
 
 @param login a NSString with the login to the website you making a request from
 @param password a NSString with the password to the website you are making a request from
 */
-(void)setAuthorizationHeaderLogin:(NSString *)login 
					   andPassword:(NSString *)passwd {
	if (login && passwd) {
		NSString *base64AuthString = CWURLAuthorizationHeaderString(login, passwd);
		if (base64AuthString) {
			[self setHttpAuthorizationHeader:base64AuthString];
		}
	}
}	
#endif

-(NSMutableURLRequest *)_createInternalURLRequest {
	/**
	 private internal method, creates the NSMutableURLRequest & applies any http
	 headers or other attributes that need to be applied
	 */
	if ([self urlHost]) {
		NSURL *url = [NSURL URLWithString:[self urlHost]];
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
		if ([self httpAuthorizationHeader]) {
			#if !(TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
			[request cw_setHTTPAuthorizationHeaderFieldString:[self httpAuthorizationHeader]];
			#endif
		}
		return request;
	}
	return nil;
}

//MARK: Connection Initiaton Methods

/**
 Starts the connection request on the receiving instance
 
 This method causes the receiving object to create the internal NSMutableURLRequest and
 then creates a NSURLConnection object that references the request object.The connection 
 is then scheduled to run on the current runloop this method is being invoked on and then
 the connection is started. After this time whatever data is received and whatever error
 is encountered is stored on the instance object. If the data is nil or if you need to debug
 an issue check the instances -connectionErrror and -connectionResponse objects.
 
 @return NSData received from the NSURLConnection
 */
-(NSData *)startSynchronousConnection {
	NSMutableURLRequest *request = [self _createInternalURLRequest];
	if (request) {
		NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		[connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[self setInstanceConnection:connection];
		[[self instanceConnection] start];
		
		while ([self connectionIsFinished] == NO) {
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[[NSDate date] dateByAddingTimeInterval:10]];
		}
		return [self receivedData];
	}
	NSError *noHostError = CWCreateError(kCWURLRequestErrorDomain, kCWSimpleURLRequestNoHostError,
										 @"Host is nil and therefore cannot be used for a connection");
	[self setConnectionError:noHostError];
	return nil;
}

/**
 Starts the connection request on the receving instance on another thread in the specified dispatch_queue_t queue
 
 This method is a conveneience method and is the same if you use dispatch async and then call 
 -startSynchronousRequest on that other thread and then used dispatch_async to get back to the
 main thread and passed the NSData, NSError and NSURLResponse objects back. See the notes on 
 -startSynchronousRequest for the implementation details of that method to know whats going on
 here in this one. 
 
 @param data the NSData data received from the connection
 @param error if a error was received during this connection is is passed back here
 @param the response received during the connection
 */
-(void)startAsynchronousConnectionOnGCDQueue:(dispatch_queue_t)queue 
						 withCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block {
	NSParameterAssert(queue);
	
	dispatch_async(queue, ^{
		NSData *data = [self startSynchronousConnection];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			block(data,[self connectionError],[self connectionResponse]);
		});
	});
}

/**
 Starts the connection request on the receving instance on another thread in the specified NSOperationQueue queue
 
 This method is a conveneience method and is the same if you use addOperationWithBLock and then call 
 -startSynchronousRequest on that other thread and then used addOperationWithBlock to get back to the
 main thread and passed the NSData, NSError and NSURLResponse objects back. See the notes on 
 -startSynchronousRequest for the implementation details of that method to know whats going on
 here in this one. 
 
 @param data the NSData data received from the connection
 @param error if a error was received during this connection is is passed back here
 @param the response received during the connection
 */
-(void)startAsynchronousConnectionOnQueue:(NSOperationQueue *)queue 
					  withCompletionBlock:(void (^)(NSData *data, NSError *error, NSURLResponse *response))block {
	NSParameterAssert(queue);
	
	[queue addOperationWithBlock:^{
		NSData *data = [self startSynchronousConnection];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			block(data,[self connectionError],[self connectionResponse]);
		}];
	}];
}

//MARK: NSURLConnection Delegate Methods (Private)

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	if ([connection isEqual:[self instanceConnection]]) {
		[self setConnectionResponse:response];
	}
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	if ([connection isEqual:[self instanceConnection]]) {
		[[self receivedData] appendData:data];
	}
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	/**
	 when we get a notification that we are finished, we mark 
	 ourselves as finished so we don't keep running the runloop
	 and return the received data.
	 */
	if ([[self instanceConnection] isEqual:connection]) {
		[self setConnectionIsFinished:YES];
	}
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	/**
	 if we get a error during the connection, then what
	 this does is retain the error object and mark ourselves
	 as finished and log the error.
	 */
	if ([[self instanceConnection] isEqual:connection]) {
		[self setConnectionError:error];
		[self setConnectionIsFinished:YES];
		CWLogError(error);
	}
}

@end
