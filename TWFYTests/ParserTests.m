//
//  ParserTests.m
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

SPEC_BEGIN(ParserTests)

describe(@"The JSON Parser", ^{
    
    __block CMParser *parser = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];

        parser = [[CMParser alloc] init];
        NSString *filename = @"test-mps";
        [parser parseMpDataWithJson:filename];

    });
    
    context(@"when created", ^{
    
        it(@"should exist", ^{
            [parser shouldNotBeNil];
        });
        
        it(@"should respond to parseMpDataWithJson:", ^{
            [[parser should] respondToSelector:@selector(parseMpDataWithJson:)];
        });
        
    });

    context(@"when dealing with MPs", ^{
        
        it(@"should create six MP objects after parsing", ^{
            NSArray *mpArray = [MP findAll];
            int count = [mpArray count];
            [[theValue(count) should] equal:theValue(6)];
        });
        
        it(@"should create an MP with the name 'Person One'", ^{
            NSArray *mpsArray = [MP findByAttribute:@"name" withValue:@"Person One"];
            [[theValue([mpsArray count]) should] equal:theValue(1)];
        });
        
        it(@"should create an MP with the member id 40323", ^{
            NSArray *mpsArray = [MP findByAttribute:@"member_id" withValue:[NSNumber numberWithInt:40323]];
            [[theValue([mpsArray count]) should] equal:theValue(1)];
        });

        it(@"should create an MP with the person id 11592", ^{
            NSArray *mpsArray = [MP findByAttribute:@"person_id" withValue:[NSNumber numberWithInt:11592]];
            [[theValue([mpsArray count]) should] equal:theValue(1)];
        });
        
    });
    
    context(@"when dealing with Parties", ^{
    
        it(@"should create five Party objects", ^{
            NSArray *partiesArray = [Party findAll];
            [[theValue([partiesArray count]) should] equal:theValue(5)];
        });
        
        it(@"should create two MPs belonging to the Labour Party", ^{
            Party *labour =  [Party findFirstByAttribute:@"name" withValue:@"Labour"];
            NSSet *labourMPs = [labour mps];
            [[theValue([labourMPs count]) should] equal:theValue(2)];
        });
        
    });
    
    context(@"when dealing with Constituencies", ^{

        it(@"should create six constituencies", ^{
            NSArray *constituencies = [Constituency findAll];
            [[theValue([constituencies count]) should] equal:theValue(6)];
        });
        
        it(@"should create an MP called Person One who belongs to the Labour Party", ^{
            Party *labour =  [Party findFirstByAttribute:@"name" withValue:@"Labour"];
            MP *personOne = [MP findFirstByAttribute:@"name" withValue:@"Person One"];
            [[[personOne party] should] equal:labour];
        });

        it(@"should create an MP called Person One who represents Constituency One", ^{
            Constituency *constituency =  [Constituency findFirstByAttribute:@"name" withValue:@"Constituency One"];
            MP *personOne = [MP findFirstByAttribute:@"name" withValue:@"Person One"];
            [[[personOne constituency] should] equal:constituency];
        });
        
        it(@"should create a constituency called Constituency One which is represented by Labour", ^{
            Constituency *constituency =  [Constituency findFirstByAttribute:@"name" withValue:@"Constituency One"];
            [[[[[constituency mp] party] name] should] equal:@"Labour"];
        });
        
        it(@"should create a constituency called Constituency One which is directly represented by Labour", ^{
            Constituency *constituency =  [Constituency findFirstByAttribute:@"name" withValue:@"Constituency One"];
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
