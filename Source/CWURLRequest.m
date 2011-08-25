//
//  CWURLRequest.m
//  Zangetsu
//
//  Created by Colin Wheeler on 8/13/11.
//  Copyright 2011. All rights reserved.
//

#import "CWURLRequest.h"

@interface CWURLRequest()
@property(nonatomic, retain, readwrite) NSString *host;
@property(nonatomic, retain) NSURLConnection *connection;
@property(nonatomic, retain) NSURLRequest *urlRequest;
@property(nonatomic, retain) NSMutableData *urlData;
@property(nonatomic, assign) BOOL isFinished;
@property(nonatomic, retain) NSError *urlError;
@end

@implementation CWURLRequest

@synthesize host;
@synthesize connection;
@synthesize urlRequest;
@synthesize urlData;
@synthesize isFinished;
@synthesize urlError;

-(id)init {
    self = [super init];
    if (self) {
        host = nil;
        connection = nil;
        urlRequest = nil;
        urlData = nil;
        isFinished = NO;
        urlError = nil;
    }
    return self;
}

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
    }
    
    return self;
}

-(void)startSynchronousDownloadWithCompletionBlock:(void (^)(NSData *data, NSError *error))block {
    NSParameterAssert([self host]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:CWURL([self host])];
    [self setUrlRequest:request];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self setConnection:urlConnection];
    
    [urlConnection start];
    
    while ([self isFinished] == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
    }
    
    block([self urlData],[self urlError]);
}

-(void)startAsynchronousDownloadOnQueue:(dispatch_queue_t)queue
                    withCompletionBlock:(void (^)(NSData *data, NSError *error))block {
    NSParameterAssert([self host]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:CWURL([self host])];
    [self setUrlRequest:request];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self setConnection:urlConnection];
    
    dispatch_async(queue, ^(void) {
        [urlConnection start];
        
        while ([self isFinished] == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            block([self urlData],[self urlError]);
        });
    });
}

-(void)startAsynchronousDownloadOnNSOperationQueue:(NSOperationQueue *)queue
                               withCompletionBlock:(void (^)(NSData *data, NSError *error))block {
    NSParameterAssert([self host]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:CWURL([self host])];
    [self setUrlRequest:request];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self setConnection:urlConnection];
    
    [queue addOperationWithBlock:^(void) {
        
        [urlConnection start];
        
        while ([self isFinished] == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
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

- (void)connectionDidFinishLoading:(NSURLConnection *)inConnection {
    if ([[self connection] isEqual:inConnection]) {
        [self setIsFinished:YES];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self setUrlError:[error copy]];
}

@end
