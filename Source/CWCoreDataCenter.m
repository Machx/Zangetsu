/*
//  GTCoreDataCenter.m
//
//  Created by Colin Wheeler on 9/24/09.
//  Copyright 2009 Colin Wheeler. All rights reserved.
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
