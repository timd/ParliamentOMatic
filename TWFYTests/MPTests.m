//
//  MPTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "CMParser.h"
#import "MP.h"

SPEC_BEGIN(MPTests)

describe(@"The MP object", ^{
    
    __block MP *mp = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        mp = [MP createEntity];
    });
    
    it(@"should exist", ^{
        [mp shouldNotBeNil];
    });
    
    it(@"should have a name", ^{
        [[mp should] respondToSelector:@selector(name)];
    });
    
    it(@"should have a member_id", ^{
        [[mp should] respondToSelector:@selector(member_id)];
    });
    
    it(@"should have a person_id", ^{
        [[mp should] respondToSelector:@selector(person_id)];
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
    
});

SPEC_END
