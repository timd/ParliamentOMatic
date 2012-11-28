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
    
    it(@"should have a party", ^{
        [[mp should] respondToSelector:@selector(party)];
    });
    
    it(@"should have a constituency", ^{
        [[mp should] respondToSelector:@selector(constituency)];
    });
    
    it(@"should have an office", ^{
        [[mp should] respondToSelector:@selector(office)];
    });
    
    it(@"should respond to 'entered_house'", ^{
        [[mp should] respondToSelector:@selector(entered_house)];
    });
    
    it(@"should respond to 'twfy_url'", ^{
        [[mp should] respondToSelector:@selector(twfy_url)];
    });
    
    it(@"should respond to 'image_url'", ^{
        [[mp should] respondToSelector:@selector(image_url)];
    });

    it(@"should respond to 'image_height'", ^{
        [[mp should] respondToSelector:@selector(image_height)];
    });

    it(@"should respond to 'image_width'", ^{
        [[mp should] respondToSelector:@selector(image_width)];
    });

    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
    
});

SPEC_END
