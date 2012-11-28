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

SPEC_BEGIN(WrittenAnswerTests)

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
            [[parser should] respondToSelector:@selector(parseWrittenAnswerDataWithJson:)];
        });
        
    });
    
    context(@"when dealing with Written Answer returned from the API containing one answer", ^{
        
        __block NSData *fileData = nil;
        
        beforeEach(^{
            
            // Load file
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *path = [bundle pathForResource:@"getWrans" ofType:@"json"];
            
            NSError *error = nil;
            NSString *dataString = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error];
            fileData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            
        });
        
        it(@"should return an NSArray", ^{
            
            id delegateMock = [KWMock mockForProtocol:@protocol(CMParserDelegateProtocol)];
            [parser setDelegate:delegateMock];
            
            NSMutableArray *returnArray = [[NSMutableArray alloc] init];
            NSDictionary *returnDictOne = @{@"hdate" : @"2012-11-27", @"body" : @"<p pid=\"a.210W.4/1\">To ask the Secretary of State for Health </p><p class=\"numindent\" pid=\"a.210W.4/2\" qnum=\"129788\">(1)  if he will take steps to ensure <i>(a)</i> Public Health England and <i>(b)</i> the NHS Commissioning Board are resourced to work collaboratively with local authorities on tooth decay in young children;</p><p class=\"numindent\" pid=\"a.210W.4/3\" qnum=\"129789\">(2)  what plans he has to raise awareness of tooth decay in children from deprived backgrounds in England; and whether he plans to develop a scheme similar to Childsmile and Designed to Smile.</p>", @"extract" : @"To ask the Secretary of State for Health  (1)  if he will take steps to ensure (a) Public Health England and (b) the NHS Commissioning Board are resourced to work collaboratively with local authorities on tooth decay in young children; (2)  what plans he has to raise awareness of tooth decay in children from deprived backgrounds in England; and whether he plans to develop a scheme similar to...", @"parent" : @"Written Answers &#8212; Health: Dental Health: Children"};
            [returnArray addObject:returnDictOne];
            NSArray *finalArray = [NSArray arrayWithArray:returnArray];

            [[delegateMock should] receive:@selector(handleWrittenAnswerResponseWithArray:) withArguments:finalArray];
            
            [parser parseWrittenAnswerDataWithJson:fileData];

        });
    });
    
    context(@"when dealing with Written Answer returned from the API containing multiple answers", ^{
        
        __block NSData *fileData = nil;
        
        beforeEach(^{
            
            // Load file
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *path = [bundle pathForResource:@"getExtWrans" ofType:@"json"];
            
            NSError *error = nil;
            NSString *dataString = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error];
            fileData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            
        });
        
        it(@"should return an NSArray", ^{
            
            id delegateMock = [KWMock mockForProtocol:@protocol(CMParserDelegateProtocol)];
            [parser setDelegate:delegateMock];
            
            NSMutableArray *returnArray = [[NSMutableArray alloc] init];
            
            NSDictionary *returnDictOne = @{@"hdate" : @"2012-11-27", @"body" : @"<p pid=\"a.210W.4/1\">To ask the Secretary of State for Health </p><p class=\"numindent\" pid=\"a.210W.4/2\" qnum=\"129788\">(1)  if he will take steps to ensure <i>(a)</i> Public Health England and <i>(b)</i> the NHS Commissioning Board are resourced to work collaboratively with local authorities on tooth decay in young children;</p><p class=\"numindent\" pid=\"a.210W.4/3\" qnum=\"129789\">(2)  what plans he has to raise awareness of tooth decay in children from deprived backgrounds in England; and whether he plans to develop a scheme similar to Childsmile and Designed to Smile.</p>", @"extract" : @"To ask the Secretary of State for Health  (1)  if he will take steps to ensure (a) Public Health England and (b) the NHS Commissioning Board are resourced to work collaboratively with local authorities on tooth decay in young children; (2)  what plans he has to raise awareness of tooth decay in children from deprived backgrounds in England; and whether he plans to develop a scheme similar to...", @"parent" : @"Written Answers &#8212; Health: Dental Health: Children"};
            [returnArray addObject:returnDictOne];
            
            NSDictionary *returnDictTwo = @{@"hdate" : @"2012-11-27", @"body" : @"<p pid=\"a.211W.1/1\" qnum=\"129790\">To ask the Secretary of State for Health what steps he has taken to ensure capitation fees paid to salaried dentists participating in the second stage of the NHS dental contract pilot scheme will reflect the complexity and difficulty of providing treatment for patients of salaried dentists.</p>", @"extract" : @"To ask the Secretary of State for Health what steps he has taken to ensure capitation fees paid to salaried dentists participating in the second stage of the NHS dental contract pilot scheme will reflect the complexity and difficulty of providing treatment for patients of salaried dentists.", @"parent" : @"Written Answers &#8212; Health: Dental Services"};
            [returnArray addObject:returnDictTwo];
            NSArray *finalArray = [NSArray arrayWithArray:returnArray];
            
            [[delegateMock should] receive:@selector(handleWrittenAnswerResponseWithArray:) withArguments:finalArray];
            
            [parser parseWrittenAnswerDataWithJson:fileData];
            
        });
    });
 
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END

