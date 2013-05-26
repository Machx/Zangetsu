//
//  CWRuntimeTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/24/13.
//
//

#import "CWRuntimeTests.h"

static const NSInteger kInstanceCode1 = 100;
static const NSInteger kInstanceCode2 = 200;

static const NSInteger kClassCode1 = 300;
static const NSInteger kClassCode2 = 400;

@interface CWTestFoo : NSObject
-(NSInteger)instanceCode1;
-(NSInteger)instanceCode2;
+(NSInteger)classCode1;
+(NSInteger)classCode2;
@end

@implementation CWTestFoo

-(NSInteger)instanceCode1 {
	return kInstanceCode1;
}

-(NSInteger)instanceCode2 {
	return kInstanceCode2;
}

+(NSInteger)classCode1 {
	return kClassCode1;
}

+(NSInteger)classCode2 {
	return kClassCode2;
}

@end

SpecBegin(CWRuntime)

it(@"should swizzle instance methods", ^{
	CWTestFoo *foo = [CWTestFoo new];
	
	expect(foo.instanceCode1 == kInstanceCode1).to.beTruthy();
	
	expect(foo.instanceCode2 == kInstanceCode2).to.beTruthy();
	
	NSError *swizzleError;
	CWSwizzleInstanceMethods([foo class], @selector(instanceCode1), @selector(instanceCode2), &swizzleError);
	if(swizzleError) NSLog(@"Swizzle Error: %@",swizzleError);
	
	expect(foo.instanceCode1 == kInstanceCode2).to.beTruthy();
	
	expect(foo.instanceCode2 == kInstanceCode1).to.beTruthy();
});

it(@"should swizzle class methods", ^{
	expect([CWTestFoo classCode1] == kClassCode1).to.beTruthy();
	
	expect([CWTestFoo classCode2] == kClassCode2).to.beTruthy();
	
	NSError *swizzleError;
	CWSwizzleClassMethods([CWTestFoo class], @selector(classCode1), @selector(classCode2), &swizzleError);
	if(swizzleError) NSLog(@"Swizzle Error: %@",swizzleError);
	
	expect([CWTestFoo classCode1] == kClassCode2).to.beTruthy();
	
	expect([CWTestFoo classCode2] == kClassCode1).to.beTruthy();
});

SpecEnd
