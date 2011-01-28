//
//  GTCoreDataCenter.m
//
//  Created by Colin Wheeler on 9/24/09.
//  Copyright 2009 Colin Wheeler. All rights reserved.
//

#import "CWCoreDataCenter.h"
#import <dispatch/dispatch.h>

@implementation CWCoreDataCenter

@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;

+(CWCoreDataCenter *)defaultCenter
{	
	static CWCoreDataCenter *center = nil;
	static dispatch_once_t pred;
	
	dispatch_once(&pred, ^{
		center = [[CWCoreDataCenter alloc] init];
		[center setManagedObjectModel:[[NSApp delegate] managedObjectModel]];
		[center setManagedObjectContext:[[NSApp delegate] managedObjectContext]];
		[center setPersistentStoreCoordinator:[[NSApp delegate] persistentStoreCoordinator]];
	});
	
	return center;
}

-(id)initWithManagedObjectModel:(NSManagedObjectModel *)mom 
		   managedObjectContext:(NSManagedObjectContext *)moc 
  andPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)psc
{
	self = [super init];
	if (self) {
		managedObjectModel = mom;
		managedObjectContext = moc;
		persistentStoreCoordinator = psc;
	}
	return self;
}

@end
