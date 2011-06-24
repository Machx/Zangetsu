//
//  CWNArrayTests.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/27/10.
//  Copyright 2010. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <Zangetsu/Zangetsu.h>

@interface CWNArrayTests : SenTestCase
-(void)testFirstObject;
-(void)testFind;
-(void)testMapArray;
-(void)testCWEach;
-(void)testCWEachWithIndex;
-(void)testSelectiveMapping;
-(void)testEachConcurrently;
-(void)testIsObjectInArrayWithBlock;
-(void)testFindAllWithBlock;
@end
