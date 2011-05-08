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

/* NSMutableArray & CFMutableArrayRef */

NS_INLINE NSMutableArray* CWCFToNSMutableArray(CFMutableArrayRef array) {
	return (NSMutableArray *)array;
}

NS_INLINE CFMutableArrayRef CWNSToCFMutableArrayRef(NSMutableArray *array) {
	return (CFMutableArrayRef)array;
}

/* NSSet & CFSetRef */

NS_INLINE NSSet* CWCFToNSSet(CFSetRef set) {
	return (NSSet *)set;
}

NS_INLINE CFSetRef CWNSToCFSetRef(NSSet *set) {
	return (CFSetRef)set;
}

/* NSDictionary & CFDictionaryRef */

NS_INLINE NSDictionary* CWCFToNSDictionary(CFDictionaryRef cfdict) {
	return (NSDictionary *)cfdict;
}

NS_INLINE CFDictionaryRef CWNSToCFDictionaryRef(NSDictionary *nsdict) {
	return (CFDictionaryRef)nsdict;
}

/* NSData & CFDataRef */

NS_INLINE NSData* CWCFToNSDataRef(CFDataRef data) {
	return (NSData *)data;
}

NS_INLINE CFDataRef CWNSDataToCFDataRef(NSData *data) {
	return (CFDataRef)data;
}

/* NSNumber & CFNumberRef */

NS_INLINE NSNumber* CWCFToNSNumber(CFNumberRef cfnumber) {
	return (NSNumber *)cfnumber;
}

NS_INLINE CFNumberRef CWNSToCFNumberRef(NSNumber *nsnumber) {
	return (CFNumberRef)nsnumber;
}

/* NSError & CFErrorRef */

NS_INLINE NSError* CWCFToNSError(CFErrorRef cferr) {
	return (NSError *)cferr;
}

NS_INLINE CFErrorRef CWNSToCFErrorRef(NSError *nserr) {
	return (CFErrorRef)nserr;
}

/* CFRunLoopTimerRef & NSTimer */

NS_INLINE CFRunLoopTimerRef CWNSToCFRunLoopTimerRef(NSTimer *nstimer) {
	return (CFRunLoopTimerRef)nstimer;
}

NS_INLINE NSTimer* CWCFToNSTimer(CFRunLoopTimerRef cftimer) {
	return (NSTimer *)cftimer;
}

/* CFAttributedStringRef & NSAttributedString */

NS_INLINE CFAttributedStringRef CWNSToCFAttributedStringRef(NSAttributedString *nsAttrString) {
	return (CFAttributedStringRef)nsAttrString;
}

NS_INLINE NSAttributedString* CWCFToNSAttributedString(CFAttributedStringRef cfAttrString) {
	return (NSAttributedString *)cfAttrString;
}

/* NSCalendar and CFCalendarRef */

NS_INLINE NSCalendar* CWCFToNSCalendar(CFCalendarRef cfcal) {
	return (NSCalendar*)cfcal;
}

NS_INLINE CFCalendarRef CFNSToCFCalendarRef(NSCalendar *nscal) {
	return (CFCalendarRef)nscal;
}

/* NSDate & CFDateRef */

NS_INLINE NSDate* CWCFToNSDate(CFDateRef cfdate){
	return (NSDate *)cfdate;
}

NS_INLINE CFDateRef CWNSToCFDateRef(NSDate *nsdate) {
	return (CFDateRef)nsdate;
}

/* NSCharacterSet & CFCharacterSetRef */

NS_INLINE NSCharacterSet* CWCFToNSCharacterSet(CFCharacterSetRef cfcharset) {
	return (NSCharacterSet *)cfcharset;
}

NS_INLINE CFCharacterSetRef CWNSToCFCharacterSetRef(NSCharacterSet *nscharset) {
	return (CFCharacterSetRef)nscharset;
}

/* NSLocale & CFLocaleRef */

NS_INLINE NSLocale* CWCFToNSLocale(CFLocaleRef cflocale) {
	return (NSLocale *)cflocale;
}

NS_INLINE CFLocaleRef CWNSToLocaleRef(NSLocale *nsloc) {
	return (CFLocaleRef)nsloc;
}
