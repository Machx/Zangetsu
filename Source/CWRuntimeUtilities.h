//
//  CWRuntimeUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger kCWErrorNoOriginalInstanceMethod = 201;
static const NSInteger kCWErrorNoNewInstanceMethod = 202;
static const NSInteger kCWErrorNoOriginalClassMethod = 203;
static const NSInteger kCWErrorNoNewClassMethod = 204;

//so we don't have to include <objc/runtime.h> here in this header
typedef struct objc_method *Method;

Method CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error);

Method CWSwizzleClassMethods(Class methodClass, SEL originalSel, SEL newSel, NSError **error);
