//
//  CWBlockFoundation.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/11/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void (^VoidBlock)(void);

void inAutoreleasePool(VoidBlock block);

@interface CWBlockFoundation : NSObject {

}

@end
