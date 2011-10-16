/*
//  CWCFConversionMacros.h
//  Zangetsu
//
//  Created by Colin Wheeler on 4/30/11.
//  Copyright 2011. All rights reserved.
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

/**
 CWCFConversionMacros serves 2 purposes 
 (1) it a reference to CoreFoundation Types that toll free bridge to Cocoa objects, as well as
 (2) a easy way to ensure that objects of the correct type are toll free bridged
 */

#import <Cocoa/Cocoa.h>

/* NSString & CFStringRef */

NS_INLINE NSString* CWCFToNSString(CFStringRef cfstr) {
	return (__bridge NSString *)cfstr;
}

NS_INLINE CFStringRef CWNSToCFStringRef(NSString *nsstr) {
	return (__bridge CFStringRef)nsstr;
}

/* NSMutableString & CFMutableStringRef */

NS_INLINE NSMutableString* CWCFToNSMutableString(CFMutableStringRef cfmstring) {
	return (__bridge NSMutableString *)cfmstring;
}

NS_INLINE CFMutableStringRef CWNSToCFMutableStringRef(NSMutableString *nsmstring) {
	return (__bridge CFMutableStringRef)nsmstring;
}

/* NSArray & CFArrayRef */

NS_INLINE NSArray* CWCFToNSArray(CFArrayRef array) {
	return (__bridge NSArray *)array;
}

NS_INLINE CFArrayRef CWNSToCFArray(NSArray *array) {
	return (__bridge CFArrayRef)array;
}

/* NSMutableArray & CFMutableArrayRef */

NS_INLINE NSMutableArray* CWCFToNSMutableArray(CFMutableArrayRef cfMArray) {
	return (__bridge NSMutableArray *)cfMArray;
}

NS_INLINE CFMutableArrayRef CWNSToCFMutableArrayRef(NSMutableArray *nsMArray) {
	return (__bridge CFMutableArrayRef)nsMArray;
}

/* NSSet & CFSetRef */

NS_INLINE NSSet* CWCFToNSSet(CFSetRef cfSet) {
	return (__bridge NSSet *)cfSet;
}

NS_INLINE CFSetRef CWNSToCFSetRef(NSSet *nSet) {
	return (__bridge CFSetRef)nSet;
}

/* NSMutableSet & CFMutableSetRef */

NS_INLINE NSMutableSet* CWCFToNSMutableSet(CFMutableSetRef cfmSet) {
	return (__bridge NSMutableSet *)cfmSet;
}

NS_INLINE CFMutableSetRef CWNSToCFMutableSetRef(NSMutableSet *nsmSet) {
	return (__bridge CFMutableSetRef)nsmSet;
}

/* NSDictionary & CFDictionaryRef */

NS_INLINE NSDictionary* CWCFToNSDictionary(CFDictionaryRef cfdict) {
	return (__bridge NSDictionary *)cfdict;
}

NS_INLINE CFDictionaryRef CWNSToCFDictionaryRef(NSDictionary *nsdict) {
	return (__bridge CFDictionaryRef)nsdict;
}

/* NSMutableDictionary & CFMutableDictionaryRef */

NS_INLINE NSMutableDictionary* CWCFToNSMutableDictionary(CFMutableDictionaryRef cfmutabledict) {
	return (__bridge NSMutableDictionary *)cfmutabledict;
}

NS_INLINE CFMutableDictionaryRef CWNSToCFMutableDictionaryRef(NSMutableDictionary *nsmutabledict) {
	return (__bridge CFMutableDictionaryRef)nsmutabledict;
}

/* NSData & CFDataRef */

NS_INLINE NSData* CWCFToNSDataRef(CFDataRef cfData) {
	return (__bridge NSData *)cfData;
}

NS_INLINE CFDataRef CWNSDataToCFDataRef(NSData *nData) {
	return (__bridge CFDataRef)nData;
}

/* NSMutableData & CFMutableDataRef */

NS_INLINE NSMutableData* CWCFToNSMutableDataRef(CFMutableDataRef cfMutableData) {
	return (__bridge NSMutableData *)cfMutableData;
}

NS_INLINE CFMutableDataRef CWNSDataToCFMutableDataRef(NSMutableData *nsmdata) {
	return (__bridge CFMutableDataRef)nsmdata;
}

/* NSNumber & CFNumberRef */

NS_INLINE NSNumber* CWCFToNSNumber(CFNumberRef cfnumber) {
	return (__bridge NSNumber *)cfnumber;
}

NS_INLINE CFNumberRef CWNSToCFNumberRef(NSNumber *nsnumber) {
	return (__bridge CFNumberRef)nsnumber;
}

/* NSError & CFErrorRef */

NS_INLINE NSError* CWCFToNSError(CFErrorRef cferr) {
	return (__bridge NSError *)cferr;
}

NS_INLINE CFErrorRef CWNSToCFErrorRef(NSError *nserr) {
	return (__bridge CFErrorRef)nserr;
}

/* CFRunLoopTimerRef & NSTimer */

NS_INLINE CFRunLoopTimerRef CWNSToCFRunLoopTimerRef(NSTimer *nstimer) {
	return (__bridge CFRunLoopTimerRef)nstimer;
}

NS_INLINE NSTimer* CWCFToNSTimer(CFRunLoopTimerRef cftimer) {
	return (__bridge NSTimer *)cftimer;
}

/* CFAttributedStringRef & NSAttributedString */

NS_INLINE CFAttributedStringRef CWNSToCFAttributedStringRef(NSAttributedString *nsAttrString) {
	return (__bridge CFAttributedStringRef)nsAttrString;
}

NS_INLINE NSAttributedString* CWCFToNSAttributedString(CFAttributedStringRef cfAttrString) {
	return (__bridge NSAttributedString *)cfAttrString;
}

/* CFMutableAttributedStringRef & NSMutableAttributedString */

NS_INLINE CFMutableAttributedStringRef CWNSToCFMutableAttributedStringRef(NSMutableAttributedString *nsmAttrString) {
	return (__bridge CFMutableAttributedStringRef)nsmAttrString;
}

NS_INLINE NSMutableAttributedString* CWCFToNSMutableAttributedString(CFMutableAttributedStringRef cfmAttrString) {
	return (__bridge NSMutableAttributedString *)cfmAttrString;
}

/* NSCalendar and CFCalendarRef */

NS_INLINE NSCalendar* CWCFToNSCalendar(CFCalendarRef cfcal) {
	return (__bridge NSCalendar*)cfcal;
}

NS_INLINE CFCalendarRef CFNSToCFCalendarRef(NSCalendar *nscal) {
	return (__bridge CFCalendarRef)nscal;
}

/* NSDate & CFDateRef */

NS_INLINE NSDate* CWCFToNSDate(CFDateRef cfdate){
	return (__bridge NSDate *)cfdate;
}

NS_INLINE CFDateRef CWNSToCFDateRef(NSDate *nsdate) {
	return (__bridge CFDateRef)nsdate;
}

/* NSCharacterSet & CFCharacterSetRef */

NS_INLINE NSCharacterSet* CWCFToNSCharacterSet(CFCharacterSetRef cfcharset) {
	return (__bridge NSCharacterSet *)cfcharset;
}

NS_INLINE CFCharacterSetRef CWNSToCFCharacterSetRef(NSCharacterSet *nscharset) {
	return (__bridge CFCharacterSetRef)nscharset;
}

/* NSMutableCharacterSet & CFMutableCharacterSetRef */

NS_INLINE NSMutableCharacterSet* CWCFToNSMutableCharacterSet(CFMutableCharacterSetRef cfmcharset) {
	return (__bridge NSMutableCharacterSet *)cfmcharset;
}

NS_INLINE CFMutableCharacterSetRef CWNSToCFMutableCharacterSetRef(NSMutableCharacterSet *nsmcharset) {
	return (__bridge CFMutableCharacterSetRef)nsmcharset;
}

/* NSLocale & CFLocaleRef */

NS_INLINE NSLocale* CWCFToNSLocale(CFLocaleRef cflocale) {
	return (__bridge NSLocale *)cflocale;
}

NS_INLINE CFLocaleRef CWNSToCFLocaleRef(NSLocale *nsloc) {
	return (__bridge CFLocaleRef)nsloc;
}

/* NSInputStream & CFReadStreamRef */

NS_INLINE NSInputStream* CWCFToNSInputStream(CFReadStreamRef cfinstream) {
	return (__bridge NSInputStream *)cfinstream;
}

NS_INLINE CFReadStreamRef CWNSToCFReadStreamRef(NSInputStream *nsinstream) {
	return (__bridge CFReadStreamRef)nsinstream;
}

/* NSOutputStream & CFWriteStreamRef */

NS_INLINE NSOutputStream* CWCFToNSOutputStream(CFWriteStreamRef cfstream) {
	return (__bridge NSOutputStream *)cfstream;
}

NS_INLINE CFWriteStreamRef CWNSToCFWriteStreamRef(NSOutputStream *nsstream){
	return (__bridge CFWriteStreamRef)nsstream;
}

/* NSTimeZone & CFTimeZoneRef */

NS_INLINE NSTimeZone* CWCFToNSTimeZone(CFTimeZoneRef cftimezone) {
	return (__bridge NSTimeZone *)cftimezone;
}

NS_INLINE CFTimeZoneRef CWNSToCFTimeZone(NSTimeZone *nstimezone) {
	return (__bridge CFTimeZoneRef)nstimezone;
}

/* NSURL & CFURLRef */

NS_INLINE NSURL* CWCFToNSURL(CFURLRef cfurl) {
	return (__bridge NSURL *)cfurl;
}

NS_INLINE CFURLRef CWNSToCFURL(NSURL *nsurl) {
	return (__bridge CFURLRef)nsurl;
}
