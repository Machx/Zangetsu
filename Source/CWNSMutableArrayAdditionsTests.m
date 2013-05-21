//
//  NSMutableArrayAdditionsTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 9/8/11.
//  Copyright 2012. All rights reserved.
//

#import "CWNSMutableArrayAdditionsTests.h"
#import "NSArrayAdditions.h"
#import "NSMutableArrayAdditions.h"

SpecBegin(NSMutableArrayAdditions)

//TODO: Test array copying

describe(@"-cw_moveObject:toIndex:", ^{
	it(@"should move an object at one index to another", ^{
		NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[ @0, @1, @5, @2, @3, @4 ]];
		[array cw_moveObject:@5 toIndex:5];
		[array cw_each:^(id object, NSUInteger index, BOOL *stop) {
			expect(object).to.equal(@(index));
		}];	
	});
	
	it(@"should leave the array as is if object is not contained in the array", ^{
		NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:@[ @0, @1, @5, @2, @3, @4 ]];
		NSMutableArray *array2 = [array1 copy];
		
		expect(array1).to.equal(array2);
		
		//move a nonexistant object in the array to a new index
		[array1 cw_moveObject:@20 toIndex:2];
		
		expect(array1).to.equal(array2);
	});
});

SpecEnd
