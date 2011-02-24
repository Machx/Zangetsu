//
//  NSManagedObjectAdditions.m
//
//  Created by Colin Wheeler on 3/19/09.
//  Copyright 2009. All rights reserved.
//

#import "NSManagedObjectAdditions.h"


@implementation NSManagedObject(CWNSManagedObjectAdditions)

-(NSString *)cw_objectIDString
{
	return [[[self objectID] URIRepresentation] absoluteString];
}

-(BOOL)cw_isUsingTemporaryObjectID
{
	return [[self objectID] isTemporaryID];
}

/**
 Experimental method to pass a bunch of key/value pairs
 in and see if they validate for the NSManagedObject
 */
-(NSArray *)cw_validateValuesAndKeys:(NSArray *)values
{
	NSMutableArray *badValuesArray = nil;
	
	if ([values count] == 0) { return badValuesArray; }
	
	NSUInteger count = 0;
	NSUInteger arrayCount = [values count];
	
	while (count < arrayCount) {
		id value = [values objectAtIndex:count++];
		id key = [values objectAtIndex:count++];
		
		NSError *validateError;
		BOOL isValid = [self validateValue:(id *)value 
									forKey:key 
									 error:&validateError];
		
		if (isValid == NO && validateError) {
			if (badValuesArray == nil) {
				badValuesArray = [[NSMutableArray alloc] init];
			}
			
			[badValuesArray addObject:NSDICT(validateError,key)];
		}
	}
	
	return badValuesArray;
}

@end
