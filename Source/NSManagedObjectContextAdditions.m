/*
//  NSManagedObjectContextAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/22/11.
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

#import "NSManagedObjectContextAdditions.h"

@implementation NSManagedObjectContext (CWNSManagedObjectContextAdditions)

#ifdef DEBUG

static void *cwmdbg;

-(NSString *)cw_debugName {
	return [self cw_valueAssociatedWithKey:cwmdbg];
}

-(void)cw_setDebugName:(NSString *)cwdebugname {
	[self cw_associateValue:cwdebugname withKey:cwmdbg];
}

-(void)cw_logObjectsInContext {
	if ([self cw_debugName]) {
		NSLog(@"MOC Name: %@",[self cw_debugName]);
	} else {
		NSLog(@"MOC: %@",[self description]);
	}
	
	NSLog(@"Has Changes: %@",CWBOOLString([self hasChanges]));
	
	if ([self hasChanges]) {
		if ([[self insertedObjects] count] > 0) {
			NSLog(@"%ld Inserted Objects",[[self insertedObjects] count]);
		}
		if ([[self updatedObjects] count] > 0) {
			NSLog(@"%ld Updated Objects",[[self updatedObjects] count]);
		}
		if ([[self deletedObjects] count] > 0) {
			NSLog(@"%ld Deleted Objects",[[self deletedObjects] count]);
		}
	}
}

#endif

/**
 Returns a new child NSManagedObjectContext instance with the specified concurrency type
 
 Creates a new NSManagedObjectContext and sets the concurrency type to the specified type, then
 sets the parent context to the receiving NSManagedObjectContext.
 
 @param type a NSManagedObjectContextConcurrencyType type as you would pass when creating a managed object context
 @return a new child NSManagedObjectContext
 */
-(NSManagedObjectContext *)cw_newChildContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type {
	NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
	[ctx setParentContext:self];
	return ctx;
}

/**
 Returns a NSUInteger with the count of objects of entityName
 
 @param entityName the name of the entity which you would like to know how many instances there are in the store
 @param error a NSError pointer which will be passed to core data and will return any error core data encounters
 @return a NSUInteger with the count of objects of the entity present in the managed object context
 */
-(NSUInteger)cw_countForEntity:(NSString *)entityName error:(NSError **)error {
	NSParameterAssert(entityName);
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
											  inManagedObjectContext:self];
	if (entity) {
		NSUInteger count = 0;
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entity];
		
		count = [self countForFetchRequest:request 
									 error:error];
		return count;
	}
	if (*error) {
		*error = CWCreateError(990, @"com.zangetsu.nsmanagedobjectcontext_additions", 
							   [NSString stringWithFormat:@"Could not find an etity of name %@",entityName]);
	}
	return 0;
}

/**
 Returns an NSArray containing all entities of the specified entity and matching the predicate
 
 Returns an NSArray containing all entities of the specified entityName and optionally matching the 
 predicate passed in. The error is passed onto Core Data during the fetch operation and any error
 the Core Data stack encounters will be returned to you.
 
 @param an NSString containing the specified entity you are looking to have returned to you
 @param a NSPredicate (optional) to narrow down the array of objects passed to you. If nil is passed this returns all entities of entityName
 @param a NSError pointer which is passed to Core Data and any error it encounters will be returned to you.
 @return a NSArray with all entities found matching entity name and optionally the predicate
 */
-(NSArray *)cw_allEntitiesOfName:(NSString *)entityName 
				   withPredicate:(NSPredicate *)predicate 
						   error:(NSError **)error {
	NSParameterAssert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
	if (predicate) {
		[request setPredicate:predicate];
	}
	NSArray *results = nil;
	results = [self executeFetchRequest:request
								  error:error];
	return results;
}

/**
 Returns an NSArray containing all entities of the specified entity name and patching the predicate
 
 Returns an NSArray containing all entities of the specified entity name, optionally if a predicate
 is specified this filters down the results. If the properties array is specified then this will
 only fetch the specified properties and fault on the unfetched properties. IF a sort descriptor is
 specified then this will return the results sorted.
 
 @param an NSString containing the specified entity you are looking to have returned to you
 @param a NSPredicate (optional) to narrow down the array of objects passed to you. If nil is passed this returns all entities of entityName
 @param a NSArray of properties to fetch on the specified entity (can be nil)
 @param a NSArray of sort descriptors to apply to the entity results (can be nil)
 @param a NSError pointer which is passed to Core Data and any error it encounters will be returned to you.
 @return a NSArray with all entities found matching entity name and optionally the predicate
 */
-(NSArray *)cw_allEntitiesOfName:(NSString *)entityName 
				   withPredicate:(NSPredicate *)predicate 
					  properties:(NSArray *)properties 
				 sortDescriptors:(NSArray *)sortDescriptors
						   error:(NSError **)error {
	NSParameterAssert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
	if (predicate) { [request setPredicate:predicate]; }
	if (properties) { [request setPropertiesToFetch:properties]; }
	if (sortDescriptors) { [request setSortDescriptors:sortDescriptors]; }
	
	NSArray *results = nil;
	results = [self executeFetchRequest:request error:error];
	return results;
}

@end
