//
//  CWCFConversionMacros.h
//  Zangetsu
//
//  Created by Colin Wheeler on 4/30/11.
//  Copyright 2011. All rights reserved.
//

/**
 CWCFConversionMacros serves 2 purposes 
 (1) it a reference to CoreFoundation Types that toll free bridge to Cocoa objects, as well as
 (2) a easy way to ensure that objects of the correct type are toll free bridged
 */

#import <Cocoa/Cocoa.h>

/* NSString & CFStringRef */

NS_INLINE NSString* CWCFToNSString(CFStringRef cfstr) {
	return (NSString *)cfstr;
}

NS_INLINE CFStringRef CWNSToCFStringRef(NSString *nsstr) {
	return (CFStringRef)nsstr;
}

/* NSArray & CFArrayRef */

NS_INLINE NSArray* CWCFToNSArray(CFArrayRef array) {
	return (NSArray *)array;
}

NS_INLINE CFArrayRef CWNSToCFArray(NSArray *array) {
	return (CFArrayRef)array;
}

/* NSSet & CFSetRef */

NS_INLINE NSSet* CWCFToNSSet(CFSetRef set) {
	return (NSSet *)set;
}

NS_INLINE CFSetRef CWNSToCFSetRef(NSSet *set) {
	return (CFSetRef)set;
}

/* NSData & CFDataRef */

NS_INLINE NSData* CWCFToNSDataRef(CFDataRef data) {
	return (NSData *)data;
}

NS_INLINE CFDataRef CWNSDataToCFDataRef(NSData *data) {
	return (CFDataRef)data;
}
