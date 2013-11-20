/*
//  ZangetsuTouch.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/15/12.
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

#if ! __has_feature(objc_arc)
#error This project requires ARC
#endif

#import "CWAssertionMacros.h"
#import "CWLogging.h"

//Foundation
#import "NSObject+Nil.h"
#import "NSObject+AssociatedObjects.h"
#import "NSObject+PerformOperation.h"
#import "NSString+Empty.h"
#import "NSString+URL.h"
#import "NSString+Enumeration.h"
#import "NSArray+Search.h"
#import "NSArray+Enumeration.h"
#import "NSArray+Transform.h"
#import "NSDictionary+Search.h"
#import "NSDictionary+Enumeration.h"
#import "NSDictionary+Transform.h"
#import "NSSet+Search.h"
#import "NSSet+Transform.h"
#import "NSSet+Enumeration.h"
#import "NSURLConnection+Asynchronous.h"
#import "NSMutableArray+Copying.h"
#import "NSMutableArray+Shuffle.h"
#import "NSRecursiveLock+UnlockWithBlock.h"
#import "NSData+HexRepresentation.h"
#import "NSMutableURLRequest+Authorization.h"
#import "NSURL+DebugDescription.h"
#import "NSNumber+RepeatingActions.h"

//Data Structures
#import "CWStack.h"
#import "CWTree.h"
#import "CWQueue.h"
#import "CWBlockQueue.h"
#import "CWTrie.h"
#import "CWBlockTimer.h"
#import "CWFixedQueue.h"
#import "CWPriorityQueue.h"

//UIKit
#import "UIImage+Resizing.h"

#import "CWMacros.h"
#import "CWSHA1Utilities.h"
#import "CWDateUtilities.h"
#import "CWDebugUtilities.h"
#import "CWFoundation.h"
#import "CWPathUtilities.h"
#import "CWErrorUtilities.h"
#import "CWGraphicsFoundation.h"
#import "CWMD5Utilities.h"
#import "CWExceptionUtilities.h"
#import "CWURLUtilities.h"
#import "CWRuntimeUtilities.h"
#import "CWCFConversionMacros.h"
#import "CWSystemInfoIOS.h"
#import "CWBase64IOS.h"
#import "CWURLRequest.h"

/**
 What will never work on iOS
 CWTask - Wraps around NSTask & isn't availble on iOS
 
 What needs work to get working on iOS
 CWZlib - SecTransform needs to be implemented on iOS
 */
