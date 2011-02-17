//
//  CWSimpleCoreData.h
//
//  Created by Colin Wheeler on 9/20/09.
//  Copyright 2009 Colin Wheeler. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CWSimpleCoreData : NSObject {}

/* returns all entities matching the entity name and
 * (if applicable) the predicate given 
 */
+(NSArray *)allEntitiesForName:(NSString *)entityName 
		inManagedObjectContext:(NSManagedObjectContext *)moc 
				 withPredicate:(NSPredicate *)predicate 
			andSortDescriptors:(NSArray *)descriptors;

/* returns the object count for all entities matching
 * the given entity name
 */
+(NSUInteger)objectCountForEntity:(NSString *)entityName
		   inManagedObjectContext:(NSManagedObjectContext *)moc
						withError:(NSError **)error;

/* creates a new NSManagedObject with the entity given
 * and optionally a nsmanagedobjectcontext
 */
+(NSManagedObject *)newObjectWithEntityName:(NSString *)entityName 
					 inManagedObjectContext:(NSManagedObjectContext *)moc 
								  andValues:(NSDictionary *)values;

@end
