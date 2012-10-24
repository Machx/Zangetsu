/*
//  GTCoreDataCenter.m
//
//  Created by Colin Wheeler on 9/24/09.
//  Copyright 2009 Colin Wheeler. All rights reserved.
//
 
 */

#import "CWCoreDataCenter.h"
#import <dispatch/dispatch.h>

@implementation CWCoreDataCenter

+(CWCoreDataCenter *)defaultCenter {	
	static CWCoreDataCenter *center = nil;
	static dispatch_once_t pred;
	
	dispatch_once(&pred, ^{
		center = [[CWCoreDataCenter alloc] init];
#if Z_HOST_OS_IS_MAC_OS_X
		center.managedObjectModel = [[NSApp delegate] managedObjectModel];
		center.managedObjectContext = [[NSApp delegate] managedObjectContext];
		center.persistentStoreCoordinator = [[NSApp delegate] persistentStoreCoordinator];
#endif
	});
	
	return center;
}

-(id)initWithManagedObjectModel:(NSManagedObjectModel *)mom 
		   managedObjectContext:(NSManagedObjectContext *)moc 
  andPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)psc {
	self = [super init];
	if (self) {
		_managedObjectModel = mom;
		_managedObjectContext = moc;
		_persistentStoreCoordinator = psc;
	}
	return self;
}

@end
