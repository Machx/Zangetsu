/*
//  NSManagedObjectContextAdditions.h
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

#import <CoreData/CoreData.h>

static NSString * const kNSManagedObjectContextAdditionsDomain = @"com.zangetsu.nsmanagedobjectcontext_additions";

@interface NSManagedObjectContext (CWNSManagedObjectContextAdditions)

#ifdef DEBUG

/**
 Returns the debug name for a NSManagedObjectContext if it is set
 
 This is just for your debuggging purposes 
 */
-(NSString *)cw_debugName;

/**
 Sets the debug name for a NSManagedObjectContext
 */
-(void)cw_setDebugName:(NSString *)cwdebugname;

/**
 Logs the MOC's name if possible & if it has changes, & what changes it has
 
 Logs the following 
 - If the MOC has a debug name it logs that, otherwise the moc's description
 - If the MOC has Changes
 - Inserted Objects
 - Updated Objects
 - Deleted Objects
 */
-(void)cw_logObjectsInContext;

#endif

/**
 Returns a new child NSManagedObjectContext instance with the specified concurrency type
 
 Creates a new NSManagedObjectContext and sets the concurrency type to the specified type, then
 sets the parent context to the receiving NSManagedObjectContext.
 
 @param type a NSManagedObjectContextConcurrencyType type as you would pass when creating a managed object context
 @return a new child NSManagedObjectContext
 */
-(NSManagedObjectContext *)cw_newChildContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type;

/**
 Returns a NSUInteger with the count of objects of entityName
 
 @param entityName the name of the entity which you would like to know how many instances there are in the store
 @param error a NSError pointer which will be passed to core data and will return any error core data encounters
 @return a NSUInteger with the count of objects of the entity present in the managed object context
 */
-(NSUInteger)cw_countForEntity:(NSString *)entityName error:(NSError **)error;

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
						   error:(NSError **)error;

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
						   error:(NSError **)error;

-(NSManagedObject *)cw_newManagedObjectOfEntity:(NSString *)entityName;

@end
