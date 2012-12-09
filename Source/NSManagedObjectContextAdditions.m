/*
//  NSManagedObjectContextAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/22/11.
//  Copyright (c) 2012. All rights reserved.
//
 	*/

#import "NSManagedObjectContextAdditions.h"

@implementation NSManagedObjectContext (CWNSManagedObjectContextAdditions)

#ifdef DEBUG

static void *cwmdbg = &cwmdbg;

-(NSString *)cw_debugName
{
	return [self cw_valueAssociatedWithKey:cwmdbg];
}

-(void)cw_setDebugName:(NSString *)cwdebugname
{
	[self cw_associateValue:cwdebugname 
					withKey:cwmdbg];
}

-(void)cw_logObjectsInContext
{
	if ([self cw_debugName]) {
		NSLog(@"MOC Name: %@",[self cw_debugName]);
	} else {
		NSLog(@"MOC: %@",[self description]);
	}
	
	NSLog(@"Has Changes: %@",CWBOOLString([self hasChanges]));
	
	if ([self hasChanges]) {
		if ([[self insertedObjects] count] > 0) {
			NSLog(@"%lu Inserted Objects",(long)[[self insertedObjects] count]);
		}
		if ([[self updatedObjects] count] > 0) {
			NSLog(@"%lu Updated Objects",(long)[[self updatedObjects] count]);
		}
		if ([[self deletedObjects] count] > 0) {
			NSLog(@"%lu Deleted Objects",(long)[[self deletedObjects] count]);
		}
	}
}

#endif

-(NSManagedObjectContext *)cw_newChildContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
{
	NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
	[ctx setParentContext:self];
	return ctx;
}

-(NSUInteger)cw_countForEntity:(NSString *)entityName error:(NSError **)error
{
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
		*error = CWCreateError(kNSManagedObjectContextAdditionsDomain, 990,
							   [NSString stringWithFormat:@"Could not find an etity of name %@",entityName]);
	}
	return 0;
}

-(NSArray *)cw_allEntitiesOfName:(NSString *)entityName 
				   withPredicate:(NSPredicate *)predicate 
						   error:(NSError **)error
{
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

-(NSArray *)cw_allEntitiesOfName:(NSString *)entityName 
				   withPredicate:(NSPredicate *)predicate 
					  properties:(NSArray *)properties 
				 sortDescriptors:(NSArray *)sortDescriptors
						   error:(NSError **)error
{
	NSParameterAssert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
	if(predicate) { request.predicate = predicate; }
	if(properties) { request.propertiesToFetch = properties; }
	if(sortDescriptors) { request.sortDescriptors = sortDescriptors; }
	
	NSArray *results = nil;
	results = [self executeFetchRequest:request error:error];
	return results;
}

-(NSManagedObject *)cw_newManagedObjectOfEntity:(NSString *)entityName
{
	if(!entityName) { return nil; }
	NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
	NSManagedObject *mo = [[NSManagedObject alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:self];
	return mo;
}

@end
