//
//  PartyTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "CMParser.h"
#import "Party.h"

SPEC_BEGIN(PartyTests)

describe(@"The Party object", ^{
    
    __block Party *party = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        party = [Party createEntity];
    });
    
    it(@"should exist", ^{
        [party shouldNotBeNil];
    });
    
    it(@"should have a name", ^{
        [[party should] respondToSelector:@selector(name)];
    });
    
    it(@"should have an MP", ^{
        [[party should] respondToSelector:@selector(mps)];
    });
    
    it(@"should have a shortName", ^{
        [[party should] respondToSelector:@selector(shortName)];
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
    
});

SPEC_END
