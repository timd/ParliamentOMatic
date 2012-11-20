//
//  InitialDataTests.m
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

SPEC_BEGIN(InitialDataTests)

describe(@"The JSON Parser", ^{
    
    __block CMParser *parser = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        
        parser = [[CMParser alloc] init];
        NSString *filename = @"allMPs";
        [parser parseMpDataWithJson:filename];
        
    });
    
    context(@"when created", ^{
        
        it(@"should exist", ^{
            [parser shouldNotBeNil];
        });
        
        it(@"should respond to parseInitialAppData:", ^{
            [[parser should] respondToSelector:@selector(parseInitialAppData)];
        });
        
    });
    
    context(@"when dealing with MPs", ^{
        
        it(@"should create 647 MP objects after parsing", ^{
            NSArray *mpArray = [MP findAll];
            int count = [mpArray count];
            [[theValue(count) should] equal:theValue(647)];
        });
        
        it(@"should create an MP with the name 'Bridget Phillipson'", ^{
            NSArray *mpsArray = [MP findByAttribute:@"name" withValue:@"Bridget Phillipson"];
            [[theValue([mpsArray count]) should] equal:theValue(1)];
        });
        
        it(@"should create an MP with the member id 40636", ^{
            NSArray *mpsArray = [MP findByAttribute:@"member_id" withValue:[NSNumber numberWithInt:40636]];
            [[theValue([mpsArray count]) should] equal:theValue(1)];
        });
        
        it(@"should create an MP with the person id 24710", ^{
            NSArray *mpsArray = [MP findByAttribute:@"person_id" withValue:[NSNumber numberWithInt:24710]];
            [[theValue([mpsArray count]) should] equal:theValue(1)];
        });
        
    });
    
    context(@"when dealing with Parties", ^{
        
        it(@"should create 13 Party objects", ^{
            NSArray *partiesArray = [Party findAll];
            [[theValue([partiesArray count]) should] equal:theValue(13)];
        });
        
        it(@"should create 255 MPs belonging to the Labour Party", ^{
            Party *labour =  [Party findFirstByAttribute:@"name" withValue:@"Labour"];
            NSSet *labourMPs = [labour mps];
            [[theValue([labourMPs count]) should] equal:theValue(255)];
        });
        
    });
    
    context(@"when dealing with Constituencies", ^{
        
        it(@"should create 647 constituencies", ^{
            NSArray *constituencies = [Constituency findAll];
            [[theValue([constituencies count]) should] equal:theValue(647)];
        });
        
        it(@"should create an MP called 'Bridget Phillipson' who belongs to the Labour Party", ^{
            Party *labour =  [Party findFirstByAttribute:@"name" withValue:@"Labour"];
            MP *personOne = [MP findFirstByAttribute:@"name" withValue:@"Bridget Phillipson"];
            [[[personOne party] should] equal:labour];
        });
        
        it(@"should create an MP called 'Sharon Hodgson' who represents 'Washington and Sunderland West'", ^{
            Constituency *constituency =  [Constituency findFirstByAttribute:@"name" withValue:@"Washington and Sunderland West"];
            MP *personOne = [MP findFirstByAttribute:@"name" withValue:@"Sharon Hodgson"];
            [[[personOne constituency] should] equal:constituency];
        });
        
        it(@"should create a constituency called 'Sunderland Central' which is represented by Labour", ^{
            Constituency *constituency =  [Constituency findFirstByAttribute:@"name" withValue:@"Sunderland Central"];
            [[[[[constituency mp] party] name] should] equal:@"Labour"];
        });
        
        it(@"should create a constituency called 'Sunderland Central' which is directly represented by Labour", ^{
            Constituency *constituency =  [Constituency findFirstByAttribute:@"name" withValue:@"Sunderland Central"];
            Party *labour =  [Party findFirstByAttribute:@"name" withValue:@"Labour"];
            MP *personOne = [constituency mp];
            [[[personOne party] should] equal:labour];
        });
        
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END
