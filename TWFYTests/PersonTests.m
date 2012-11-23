//
//  PersonTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "CMParser.h"

#import "MP.h"
#import "Party.h"
#import "Constituency.h"
#import "Office.h"

SPEC_BEGIN(PersonTests)

describe(@"The JSON Parser", ^{
    
    __block CMParser *parser = nil;
    __block MP *theMP = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        
        parser = [[CMParser alloc] init];
        NSString *filename = @"getPerson";
        
        theMP = [MP createEntity];
        [parser parsePerson:theMP WithJson:filename];
        
    });
    
    context(@"when created", ^{
        
        it(@"should exist", ^{
            [parser shouldNotBeNil];
        });
        
        it(@"should respond to parseMpDataWithJson:", ^{
            [[parser should] respondToSelector:@selector(parsePerson:WithJson:)];
        });
        
    });
    
    context(@"when handling Person data", ^{
        
        it(@"should create an entered_house value of '2010-05-06'", ^{
            [[[theMP entered_house] should] equal:@"2010-05-06"];
        });

        it(@"should create an twfy_url value of '/mp/hywel_francis/aberavon'", ^{
            [[[theMP twfy_url] should] equal:@"/mp/hywel_francis/aberavon"];
        });

        it(@"should create an image_url value of '/images/mps/10900.jpg'", ^{
            [[[theMP image_url] should] equal:@"/images/mps/10900.jpg"];
        });
        
        it(@"should create an image_height value of '59'", ^{
            [[[theMP image_height] should] equal:[NSNumber numberWithInt:59]];
        });

        it(@"should create an image_width value of '49'", ^{
            [[[theMP image_width] should] equal:[NSNumber numberWithInt:49]];
        });


    });
    
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END

