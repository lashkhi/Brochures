//
//  BrochureRequestTest.m
//  Brochures
//
//  Created by David Lashkhi on 05/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BrochuresNetworkDataManager.h"

@interface BrochureRequestTest : XCTestCase

@end

@implementation BrochureRequestTest

static NSTimeInterval const ExpectationTimeout = 60;


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoad {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load Sectors"];
    
    [[BrochuresNetworkDataManager sharedInstance] fetchSectoresWithSuccess:^(NSArray *sectors) {
        XCTAssert(sectors.count > 0, @"Must get some sectors");
    } failure:^(NSError *error) {
        XCTFail(@"Can't fetch");
        [expectation fulfill];
    }];
    
        [self waitForExpectationsWithTimeout:ExpectationTimeout handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout");
        }
    }];}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
