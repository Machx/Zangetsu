//
//  CWCFConversionMacros.h
//  Zangetsu
//
//  Created by Colin Wheeler on 4/30/11.
//  Copyright 2011. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/* NSString & CFStringRef */

NS_INLINE NSString* CWCFToNSString(CFStringRef cfstr) {
	return (NSString *)cfstr;
}

NS_INLINE CFStringRef CWNSToCFStringRef(NSString *nsstr) {
	return (CFStringRef)nsstr;
}
