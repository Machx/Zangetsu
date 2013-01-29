/*
//  NSManagedObjectContextAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/22/11.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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

static void *cwmdbg = &cwmdbg;

-(NSString *)cw_debugName {
	return [self cw_valueAssociatedWithKey:cwmdbg];
}

-(void)cw_setDebugName:(NSString *)cwdebugname {
	[self cw_associateValue:cwdebugname 
					withKey:cwmdbg];
}

-(void)cw_logObjectsInContext {
	if ([self cw_debugName]) {
		NSLog(@"MOC Name: %@",[self cw_debugName]);
	} else {
		NSLog(@"MOC: %@",[self description]);
	}
	
	NSLog(@"Has Changes: %@",CWBOOLString([self hasChanges]));
	
	if ([self hasChanges]) {
		if ([[self insertedObjects] count] > 0) NSLog(@"%lu Inserted Objects",(long)[[self insertedObjects] count]);
		if ([[self updatedObjects] count] > 0) NSLog(@"%lu Updated Objects",(long)[[self updatedObjects] count]);
		if ([[self deletedObjects] count] > 0) NSLog(@"%lu Deleted Objects",(long)[[self deletedObjects] count]);
	}
}

#endif

-(NSManagedObjectContext *)cw_newChildContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type {
	NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
	[ctx setParentContext:self];
	return ctx;
}

-(NSUInteger)cw_countForEntity:(NSString *)entityName
						 error:(NSError **)error {
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
	CWErrorSet(kNSManagedObjectContextAdditionsDomain,
			   990,
			   [NSString stringWithFormat:@"Could not find an etity of name %@",entityName],
			   error);
	return 0;
}

-(NSArray *)cw_allEntitiesOfName:(NSString *)entityName 
				   withPredicate:(NSPredicate *)predicate 
						   error:(NSError **)error {
	NSParameterAssert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
	if (predicate) [request setPredicate:predicate];
	NSArray *results = nil;
	results = [self executeFetchRequest:request
								  error:error];
	return results;
}

-(NSArray *)cw_allEntitiesOfName:(NSString *)entityName 
				   withPredicate:(NSPredicate *)predicate 
					  properties:(NSArray *)properties 
				 sortDescriptors:(NSArray *)sortDescriptors
						   error:(NSError **)error {
	NSParameterAssert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
	if(predicate) request.predicate = predicate;
	if(properties) request.propertiesToFetch = properties;
	if(sortDescriptors) request.sortDescriptors = sortDescriptors;
	
	return [self executeFetchRequest:request error:error];
}

-(NSManagedObject *)cw_newManagedObjectOfEntity:(NSString *)entityName {
	if(!entityName) return nil;
	NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName
												  inManagedObjectContext:self];
	NSManagedObject *mo = [[NSManagedObject alloc] initWithEntity:entityDesc
								   insertIntoManagedObjectContext:self];
	return mo;
}

@end
