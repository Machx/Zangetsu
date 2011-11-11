/*
//  CWURLRequest.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2011. All rights reserved.
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

#import "CWURLRequest.h"

@interface CWURLRequest()
@property(nonatomic, retain, readwrite) NSString *host;
@property(nonatomic, retain) NSURLConnection *connection;
@property(nonatomic, retain) NSURLRequest *urlRequest;
@property(nonatomic, retain) NSMutableData *urlData;
@property(nonatomic, assign) BOOL isFinished;
@property(nonatomic, retain, readwrite) NSError *urlError;
@property(nonatomic, retain) NSString *authName;
@property(nonatomic, retain) NSString *authPassword;
@property(nonatomic, assign) BOOL authHeader;
-(void)setAuthorizationHeaderIfApplicableWithRequest:(NSMutableURLRequest *)request;
@end

@implementation CWURLRequest

@synthesize host;
@synthesize connection;
@synthesize urlRequest;
@synthesize urlData;
@synthesize isFinished;
@synthesize urlError;
@synthesize authName;
@synthesize authPassword;
@synthesize authHeader;
@synthesize cachePolicy;
@synthesize timeoutInterval;

/**
 initializes a CWURLRequest object
 
 Initializes a CWURLRequest object with appropriate values and sets the host to nil. 
 If you call this on a CWURLRequest instance you will have to call setHost on it or 
 call -initWithURLString which you should call instead of this method. This method 
 only exists to properly initialize a CWURLRequest object that doesn't have a host
 
 @return a fully initialized CWURLRequest object with no url host set
 */
-(id)init {
    self = [super init];
    if (self) {
        host = nil;
        connection = nil;
        urlRequest = nil;
        urlData = nil;
        isFinished = NO;
        urlError = nil;
        authName = nil;
        authPassword = nil;
        authHeader = NO;
        cachePolicy = NSURLRequestUseProtocolCachePolicy;
        timeoutInterval = 30.0;
    }
    return self;
}

/**
 Designated initializer 
 
 Initializes the CWURLRequest object with the host 
 
 @param the URL you want to request data from (should not be nil)
 @return a fully initialized CWURLRequest oject
 */
-(id)initWithURLString:(NSString *)urlHost
{
    self = [super init];
    if (self) {
        host = urlHost;
        connection = nil;
        urlRequest = nil;
        urlData = [[NSMutableData alloc] init];
        isFinished = NO;
        urlError = nil;
        authName = nil;
        authPassword = nil;
        authHeader = NO;
        cachePolicy = NSURLRequestUseProtocolCachePolicy;
        timeoutInterval = 30.0;
    }
    
    return self;
}

/**
 Returns a debug description of the CWURLRequest object
 
 @return a NSString describing the current state & even some private internal information for the CWURLRequest instance
 */
-(NSString *)description {
    NSString *_isFinished = CWBOOLString(self->isFinished);
    NSString *_usesHTTPAuthHeader = CWBOOLString(self->authHeader);
    
    return [NSString stringWithFormat:@"CWURLRequest Host: %@\nHas Finished: %@\nUsing HTTP Auth Header: %@\nTimeout Interval:%f\nError: %@",
			self->host,
			_isFinished,
			_usesHTTPAuthHeader,
			self->timeoutInterval,
			self->urlError];
}

/**
 Exposes NSURLConnection API to CWURLRequest allowing you to see if a CWURLRequest can handle a request
 
 @return a BOOL indicating if a CWURLRequest instance can handle a request
 */
-(BOOL)canHandleRequest {
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:CWURL(self->host)
												  cachePolicy:self->cachePolicy
											  timeoutInterval:self->timeoutInterval];
	BOOL ableToHandleRequest = [NSURLConnection canHandleRequest:request];
	
	return ableToHandleRequest;
}

//MARK: -
//MARK: Authorization Attribute Methods

/**
 Sets the login and password credentials for the Authentication Challenge
 
 If you set this then the CWURLRequest will not use the http authorization header if 
 it was previously turned on.
 
 @param uLogin a NSString with the login
 @param uPassword a NSString containing the password
 */
-(void)setAuthenticationChallengeLogin:(NSString *)uLogin 
                           andPassword:(NSString *)uPassword {
    NSParameterAssert(uLogin);
    NSParameterAssert(uPassword);
    
    [self setAuthName:uLogin];
    [self setAuthPassword:uPassword];
    [self setAuthHeader:NO];
}

/**
 Sets the credentials for the http authorization header
 
 If you set this then CWURLRequest will (when it starts its NSURLConnection) create a
 http authorization header with Base64 encoding and will not respond to authentication
 challenges if that was previously turned on.
 
 @param uLogin a NSString with the login
 @param uPassword a NSString containing the password
 */
-(void)setAuthenticationHTTPHeaderLogin:(NSString *)login 
                            andPassword:(NSString *)password {
    NSParameterAssert(login);
    NSParameterAssert(password);
    
    [self setAuthName:login];
    [self setAuthPassword:password];
    [self setAuthHeader:YES];
}

/**
 private internal method
 
 sets the httpd authorization header if the credentials are set and if 
 the CWURLReqeust is supposed to use the http authorization header
 */
-(void)setAuthorizationHeaderIfApplicableWithRequest:(NSMutableURLRequest *)request {
    NSParameterAssert(request);
    if ([self authHeader]) {
		NSString *credentialsString = CWURLAuthorizationHeaderString(self->authName, self->authPassword);
        if (credentialsString) {
			[request addValue:credentialsString forHTTPHeaderField:@"Authorization"];
		}
    }
}

//MARK: -
//MARK: Download Methods

/**
 synchronously starts the connection and waits for it to finish setting ourself as the delegate
 then executes the block when completed
 
 @param block the block to be executed once the NSURLRequest has completed
 */
-(void)startSynchronousDownloadWithCompletionBlock:(void (^)(NSData *data, NSError *error))block {
    NSParameterAssert([self host]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:CWURL([self host])
                                                                cachePolicy:[self cachePolicy]
                                                            timeoutInterval:[self timeoutInterval]];
    [self setAuthorizationHeaderIfApplicableWithRequest:request];
    [self setUrlRequest:request];
    
    if (request) {
		NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:[self urlRequest] 
																		 delegate:self];
		[self setConnection:urlConnection];
		
		[urlConnection start];
		
		while ([self isFinished] == NO) {
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		}
		
		block([self urlData],[self urlError]);
	} else {
		//TODO: make name & document CWURLRequestErrors in the public header...
		block(nil,CWCreateError(1, nil, @"URL Request could not be created"));
	}
}

/**
 creates the urlrequest and then starts the connection on a gcd queue and waits till it has
 finished and then executes the block on the main thread
 
 @param queue a gcd queue ( dispatch_queue_t ) to execute the block on, must not be NULL
 @param block a block to be executed on the main thread once the connection has finished
 */
-(void)startAsynchronousDownloadOnQueue:(dispatch_queue_t)queue
                    withCompletionBlock:(void (^)(NSData *data, NSError *error))block {
    NSParameterAssert([self host]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:CWURL([self host])
                                                                cachePolicy:[self cachePolicy]
                                                            timeoutInterval:[self timeoutInterval]];
    [self setAuthorizationHeaderIfApplicableWithRequest:request];
    [self setUrlRequest:request];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:[self urlRequest] delegate:self];
    [self setConnection:urlConnection];
    
    dispatch_async(queue, ^(void) {
        [urlConnection start];
        
        while ([self isFinished] == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            block([self urlData],[self urlError]);
        });
    });
}

/**
 creates the urlrequest and then starts the connection on a NSOperationQueue and waits till it has
 finished and then executes the block on the main thread
 
 @param queue a NSOperationQueue to execute the block on, must not be NULL
 @param block a block to be executed on the main thread once the connection has finished
 */
-(void)startAsynchronousDownloadOnNSOperationQueue:(NSOperationQueue *)queue
                               withCompletionBlock:(void (^)(NSData *data, NSError *error))block {
    NSParameterAssert([self host]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:CWURL([self host])
                                                                cachePolicy:[self cachePolicy]
                                                            timeoutInterval:[self timeoutInterval]];
    [self setAuthorizationHeaderIfApplicableWithRequest:request];
    [self setUrlRequest:request];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:[self urlRequest] delegate:self];
    [self setConnection:urlConnection];
    
    [queue addOperationWithBlock:^(void) {
        
        [urlConnection start];
        
        while ([self isFinished] == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
            block([self urlData],[self urlError]);
        }];
    }];
}

//MARK: -
//MARK: NSURLConnection Delegate Methods

- (NSURLRequest *)connection:(NSURLConnection *)inConnection 
             willSendRequest:(NSURLRequest *)request 
            redirectResponse:(NSURLResponse *)redirectResponse {
    if (redirectResponse) {
        NSMutableURLRequest *req = [self->urlRequest mutableCopy];
        [req setURL:[request URL]];
        [self setUrlRequest:req];
        return [self urlRequest];
    } else {
        return request;
    }
}

- (void)connection:(NSURLConnection *)inConnection didReceiveData:(NSData *)data {
    [[self urlData] appendData:data];
}

/**
 if the connection is ours then mark ourselfs as finished and exit
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)inConnection {
    if ([[self connection] isEqual:inConnection]) {
        [self setIsFinished:YES];
    }
}

/**
 mark ourself as finished and copy the error before we finish....
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self setUrlError:[error copy]];
    [self setIsFinished:YES];
}

//MARK: -
//MARK: Authentication Challenge Methods

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    //CWDebugLog(@"Asked about authenticating against protection space %@ port: %ld",[protectionSpace host],[protectionSpace port]);
    if ([self authName] && [self authPassword] && ([self authHeader] == NO)) {
        return YES;
    }
    return NO;
}

/**
 respond to authentication challenges here...
 */
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        if ([self authName] && [self authPassword] && ([self authHeader] == NO)) {
            NSURLCredential *urlCredential = nil;
            urlCredential = [NSURLCredential credentialWithUser:[self authName]
                                                       password:[self authPassword]
                                                    persistence:NSURLCredentialPersistenceNone];
            
            [[challenge sender] useCredential:urlCredential 
                   forAuthenticationChallenge:challenge];
            
            //CWDebugLog(@"Did supply username %@ and password %@ for credential challenge",[self authName],[self authPassword]);
        } else {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    } else {
        [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

@end
