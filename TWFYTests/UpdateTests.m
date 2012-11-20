//
//  UpdateTests.m
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

SPEC_BEGIN(UpdateTests)

describe(@"The JSON Parser", ^{
    
    __block CMParser *parser = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
    });
    
    context(@"when handling an update", ^{
        
        beforeEach(^{
            parser = [[CMParser alloc] init];
            NSString *filename = @"test-mps";
            [parser parseMpDataWithJson:filename];
        });
        
        it(@"should exist", ^{
            [parser shouldNotBeNil];
        });
        
        it(@"should respond to updateDataWithJson:", ^{
            [[parser should] respondToSelector:@selector(updateDataWithJson:)];
        });
        
        afterEach(^{
            [MagicalRecord cleanUp];
        });
        
    });
    
    context(@"when dealing with an updated MP", ^{
        
        beforeEach(^{
            parser = [[CMParser alloc] init];
            NSString *filename = @"test-mps";
            [parser parseMpDataWithJson:filename];
        });
        
        it(@"should change the party of person id 24709 from Labour to Conservative", ^{
            
            // Existing party should be Labour
            MP *member = [MP findFirstByAttribute:@"person_id" withValue:[NSNumber numberWithInteger:24709]];
            [[[[member party] name] should] equal:@"Labour"];
            member = nil;
            
            // Now run update
            [parser updateDataWithJson:@"test-update"];
            
            // New party should be Conservative
            member = [MP findFirstByAttribute:@"person_id" withValue:[NSNumber numberWithInteger:24709]];
            [[[[member party] name] should] equal:@"Monster Raving Loony Party"];
            
        });
        
        it(@"should change the name of person id 11592 from 'Person Two' to 'Person Ninety Nine'", ^{
            
            // Existing party should be Labour
            MP *member = [MP findFirstByAttribute:@"person_id" withValue:[NSNumber numberWithInteger:11592]];
            [[[member name] should] equal:@"Person Two"];
            member = nil;
            
            // Now run update
            [parser updateDataWithJson:@"test-update"];
            
            // New party should be Conservative
            member = [MP findFirstByAttribute:@"person_id" withValue:[NSNumber numberWithInteger:11592]];
            [[[member name] should] equal:@"Person Ninety Nine"];
            
        });
        
        it(@"should change the member id of person id 24710 from '40592' to '99999'", ^{
            
            // Existing party should be Labour
            MP *member = [MP findFirstByAttribute:@"person_id" withValue:[NSNumber numberWithInteger:24710]];
            [[[member member_id] should] equal:[NSNumber numberWithInteger:40592]];
            member = nil;
            
            // Now run update
            [parser updateDataWithJson:@"test-update"];
            
            // New party should be Conservative
            member = [MP findFirstByAttribute:@"person_id" withValue:[NSNumber numberWithInteger:24710]];
            [[[member member_id] should] equal:[NSNumber numberWithInteger:99999]];
            
        });
        
        afterEach(^{
            [MagicalRecord cleanUp];
        });
        
    });

    context(@"when dealing with an updated Constituency", ^{
        
    });
    
    context(@"when dealing with an updated Party", ^{
        
    });
    
});

SPEC_END
