//
//  ConstituencyTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "CMParser.h"
#import "Constituency.h"

SPEC_BEGIN(ConstituencyTests)

describe(@"The Constituency object", ^{
    
    __block Constituency *ctcy = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        ctcy = [Constituency createEntity];
    });
    
    it(@"should exist", ^{
        [ctcy shouldNotBeNil];
    });
    
    it(@"should have a name", ^{
        [[ctcy should] respondToSelector:@selector(name)];
    });
    
    it(@"should have a constituency", ^{
        [[ctcy should] respondToSelector:@selector(mp)];
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
    
});

SPEC_END
