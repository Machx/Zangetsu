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

#import "CWMacros.h"
#import "CWSHA1Utilities.h"
#import "CWDateUtilities.h"
#import "NSStringAdditions.h"
#import "NSArrayAdditions.h"
#import "NSDictionaryAdditions.h"
#import "NSSetAdditions.h"
#import "NSURLConnectionAdditions.h"
#import "CWDebugUtilities.h"
#import "NSObjectAdditions.h"
#import "CWFoundation.h"
#import "CWPathUtilities.h"
#import "CWErrorUtilities.h"
#import "CWGraphicsFoundation.h"
#import "CWMD5Utilities.h"
#import "NSDataAdditions.h"
#import "CWCoreDataCenter.h"
#import "NSManagedObjectAdditions.h"
#import "CWExceptionUtilities.h"
#import "CWURLUtilities.h"
#import "CWRuntimeUtilities.h"
#import "NSDateAddtions.h"
#import "CWCFConversionMacros.h"
#import "CWStack.h"
#import "CWTree.h"
#import "NSMutableArrayAdditions.h"
#import "NSOperationQueueAdditions.h"
#import "CWQueue.h"
#import "CWURLRequest.h"
#import "NSRecursiveLockAdditions.h"
#import "NSManagedObjectContextAdditions.h"
#import "CWSystemInfoIOS.h"
#import "CWBase64IOS.h"
#import "NSMutableURLRequestAdditions.h"
#import "CWSerialBlockQueue.h"
#import "CWBlockQueue.h"
#import "CWTrie.h"
#import "UIImageAdditions.h"
#import "NSURLAdditions.h"
#import "CWBlockTimer.h"
#import "CWFixedQueue.h"

/**
 What will never work on iOS
 CWTask - Wraps around NSTask & isn't availble on iOS
 
 What needs work to get working on iOS
 CWZlib - SecTransform needs to be implemented on iOS
 */
