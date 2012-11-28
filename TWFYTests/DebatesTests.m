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

SPEC_BEGIN(DebatesTests)

describe(@"The JSON Parser", ^{
    
    __block CMParser *parser = nil;
    __block MP *theMP = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        
        parser = [[CMParser alloc] init];
        theMP = [MP createEntity];
        [theMP setPerson_id:@10001];
        
    });
    
    context(@"when created", ^{
        
        it(@"should exist", ^{
            [parser shouldNotBeNil];
        });
        
        it(@"should respond to parseMpDataWithJson:", ^{
            [[parser should] respondToSelector:@selector(parseDebatesDataWithJson:)];
        });
        
    });
    
    context(@"when dealing with Debates returned from the API containing one item", ^{
        
        __block NSData *fileData = nil;
        
        beforeEach(^{
            
            // Load file
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *path = [bundle pathForResource:@"getDebates" ofType:@"json"];
            
            NSError *error = nil;
            NSString *dataString = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error];
            fileData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            
        });
        
        it(@"should return an NSArray", ^{
            
            id delegateMock = [KWMock mockForProtocol:@protocol(CMParserDelegateProtocol)];
            [parser setDelegate:delegateMock];
            
            NSMutableArray *returnArray = [[NSMutableArray alloc] init];
            NSDictionary *returnDictOne = @{@"hdate" : @"2012-11-27", @"body" : @"<p pid=\"a.132.0/1\">On the question of vulnerable groups, does the Minister support the proposal of <phrase class=\"honfriend\" id=\"uk.org.publicwhip/member/40107\" name=\"Phillip Lee\">the hon. Member for Bracknell (Dr Lee)</phrase> to ration NHS drugs, either by adopting the Danish system in which people have a personal budget for drugs and have to pay to top up, or by removing the right to free prescriptions for long-term conditions such as diabetes? Does she appreciate how much harder that would make life for millions of people in vulnerable groups, or is this the real face of the coalition on the NHS&#8212;drug rationing?</p>", @"extract" : @"On the question of vulnerable groups, does the Minister support the proposal of  the hon. Member for Bracknell (Dr Lee) to ration NHS drugs, either by adopting the Danish system in which people have a personal budget for drugs and have to pay to top up, or by removing the right to free prescriptions for long-term conditions such as diabetes? Does she appreciate how much harder that would make...", @"parent" : @"Oral Answers to Questions &#8212; Health: Vulnerable Groups (Access to Health Care)", @"listurl" : @"/debates/?id=2012-11-27a.131.2&amp;s=speaker%3A10001+section%3Adebates#g132.0"};
            
            //NSDictionary *returnDictOne = @{@"hdate" : @"hdate", @"body" : @"body", @"extract" : @"extract", @"parent" : @"parent"};
            
            [returnArray addObject:returnDictOne];
            NSArray *finalArray = [NSArray arrayWithArray:returnArray];
            
            [[delegateMock should] receive:@selector(handleDebatesResponseWithArray:) withArguments:finalArray];
            
            [parser parseDebatesDataWithJson:fileData];
            
        });
    });
    
    context(@"when dealing with debates returned from the API containing multiple items", ^{
        
        __block NSData *fileData = nil;
        
        beforeEach(^{
            
            // Load file
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *path = [bundle pathForResource:@"getExtDebates" ofType:@"json"];
            
            NSError *error = nil;
            NSString *dataString = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error];
            fileData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            
        });
        
        it(@"should return an NSArray", ^{
            
            id delegateMock = [KWMock mockForProtocol:@protocol(CMParserDelegateProtocol)];
            [parser setDelegate:delegateMock];
            
            NSMutableArray *returnArray = [[NSMutableArray alloc] init];
            
            NSDictionary *returnDictOne = @{@"hdate" : @"2012-11-27", @"body" : @"<p pid=\"a.132.0/1\">On the question of vulnerable groups, does the Minister support the proposal of <phrase class=\"honfriend\" id=\"uk.org.publicwhip/member/40107\" name=\"Phillip Lee\">the hon. Member for Bracknell (Dr Lee)</phrase> to ration NHS drugs, either by adopting the Danish system in which people have a personal budget for drugs and have to pay to top up, or by removing the right to free prescriptions for long-term conditions such as diabetes? Does she appreciate how much harder that would make life for millions of people in vulnerable groups, or is this the real face of the coalition on the NHS&#8212;drug rationing?</p>", @"extract" : @"On the question of vulnerable groups, does the Minister support the proposal of  the hon. Member for Bracknell (Dr Lee) to ration NHS drugs, either by adopting the Danish system in which people have a personal budget for drugs and have to pay to top up, or by removing the right to free prescriptions for long-term conditions such as diabetes? Does she appreciate how much harder that would make...", @"parent" : @"Oral Answers to Questions &#8212; Health: Vulnerable Groups (Access to Health Care)", @"listurl" : @"/debates/?id=2012-11-27a.131.2&amp;s=speaker%3A10001+section%3Adebates#g132.0"};
            [returnArray addObject:returnDictOne];
            
            NSDictionary *returnDictTwo = @{@"hdate" : @"2012-10-30", @"body" : @"<p pid=\"a.204.5/1\">I want to raise two specific points. Opposition Members are concerned that the concept of &#8220;Any person&#8221; in clause 1 is too broad, because it appears to legalise approvals by anybody. Why does the clause not refer specifically to the north-east, Yorkshire and Humber, the west midlands and the east midlands?</p><p pid=\"a.204.5/2\">Secondly, where is the provision for the doctors who have been approved by a trust according to what we now understand was a defective process to be re-approved by the correct process? As the clause stands, it seems&#8212;I am happy to be put right on this&#8212;that doctors approved previously by the trust will be able to continue to section patients without re-approval under the correct process.</p>", @"extract" : @"I want to raise two specific points. Opposition Members are concerned that the concept of &#8220;Any person&#8221; in clause 1 is too broad, because it appears to legalise approvals by anybody. Why does the clause not refer specifically to the north-east, Yorkshire and Humber, the west midlands and the east midlands? Secondly, where is the provision for the doctors who have been approved by a...", @"parent" : @"Bill Presented &#8212; Mental Health (Approval Functions): Clause 1 &#8212; Authorisation of approvals given before this Act", @"listurl" : @"/debates/?id=2012-10-30a.204.3&amp;s=speaker%3A10001+section%3Adebates#g204.5"};
            [returnArray addObject:returnDictTwo];
            NSArray *finalArray = [NSArray arrayWithArray:returnArray];
            
            [[delegateMock should] receive:@selector(handleDebatesResponseWithArray:) withArguments:finalArray];
            
            [parser parseDebatesDataWithJson:fileData];
            
        });
    });
    
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END

