//
//  CWRuntimeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/13.
//
//

#import "CWRuntimeTests.h"

static const NSInteger code1 = 100;
static const NSInteger code2 = 200;

@interface CWTestFoo : NSObject
-(void)setError1:(NSError **)error;
-(void)setError2:(NSError **)error;
@end

@implementation CWTestFoo

-(void)setError1:(NSError **)error {
	if (error) {
		*error = [NSError errorWithDomain:@"domain" code:code1 userInfo:nil];
	}
}
-(void)setError2:(NSError **)error {
	if (error) {
		*error = [NSError errorWithDomain:@"domain" code:code2 userInfo:nil];
	}
}

@end

SpecBegin(CWRuntime)

it(@"should swizzle instance methods", ^{
	CWTestFoo *foo __attribute__((objc_precise_lifetime)) = [CWTestFoo new];
	
	NSError *error1;
	[foo setError1:&error1];
	expect(error1.domain).to.equal(@"domain");
	expect(error1.code == code1).to.beTruthy();
	
	NSError *error2;
	[foo setError2:&error2];
	expect(error2.domain).to.equal(@"domain");
	expect(error2.code == code2).to.beTruthy();
	
	NSError *swizzleError;
	CWSwizzleInstanceMethods([foo class], @selector(setError1:), @selector(setError2:), &swizzleError);
	if(swizzleError != nil) NSLog(@"Swizzle Error: %@",swizzleError);
	
	NSError *error3;
	[foo setError1:&error3];
	expect(error3.domain).to.equal(@"domain");
	expect(error3.code == code2).to.beTruthy();
	
	NSError *error4;
	[foo setError2:&error4];
	expect(error4.domain).to.equal(@"domain");
	expect(error4.code == code1).to.beTruthy();
});

SpecEnd
