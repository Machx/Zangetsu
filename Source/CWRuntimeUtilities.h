//
//  CWRuntimeUtilities.h
//  Zangetsu
//
//  Created by Colin Wheeler on 3/11/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL CWSwizzleInstanceMethods(Class instanceClass, SEL originalSel, SEL newSel, NSError **error);
