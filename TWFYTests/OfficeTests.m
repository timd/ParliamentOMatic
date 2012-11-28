//
//  OfficeTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "CMParser.h"
#import "MP.h"
#import "Office.h"

SPEC_BEGIN(OfficeTests)

describe(@"The Office object", ^{
    
    __block Office *office = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        office = [Office createEntity];
    });
    
    it(@"should exist", ^{
        [office shouldNotBeNil];
    });
    
    it(@"should have a position", ^{
        [[office should] respondToSelector:@selector(position)];
    });
    
    it(@"should have a dept", ^{
        [[office should] respondToSelector:@selector(dept)];
    });
    
    it(@"should have a from_date", ^{
        [[office should] respondToSelector:@selector(from_date)];
    });
    
    it(@"should have a to_date", ^{
        [[office should] respondToSelector:@selector(to_date)];
    });
    
    it(@"should have an MP", ^{
        [[office should] respondToSelector:@selector(mp)];
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
    
});

SPEC_END
