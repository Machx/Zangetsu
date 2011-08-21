//
//  CWGraphicsFoundation.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NSRect CWCenteredRect(NSRect smallRect, NSRect largeRect);

extern CGContextRef CWCurrentCGContext();

void CWExecuteAndRestoreCGContext(CGContextRef context,void (^block)(void));

extern void CWAddRoundedRectToPath(CGContextRef context,
								   CGRect rect,
								   float ovalWidth,
								   float ovalHeight);
