//
//  CommsTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "TWFYClient.h"
#import "CMParser.h"

#import "MP.h"
#import "Party.h"
#import "Constituency.h"
#import "Office.h"

SPEC_BEGIN(CommsTests)

describe(@"The Comms object", ^{
    
    __block CMParser *parser = nil;
    __block TWFYClient *client = nil;
    __block MP *theMP = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        
        parser = [[CMParser alloc] init];
        client = [TWFYClient sharedInstance];
        
    });
    
    context(@"when created", ^{
        
        it(@"should exist", ^{
            [client shouldNotBeNil];
        });
        
        it(@"should respond to getDataForPerson:", ^{
            [[client should] respondToSelector:@selector(getDataForPerson:)];
        });
        
        it(@"should return nil if not passed a valid MP object", ^{
            NSString *theString = @"This won't work";
            id response = nil;
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];

            [client setDelegate:delegateMock];
            
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response];
            
            [client getDataForPerson:theString];

            [response shouldBeNil];
        });
        
        it(@"should receive some data if passed a valid MP object", ^{
            
            MP *theMP = [MP createEntity];
            [theMP setPerson_id:@10900];
            
            NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"getPerson" ofType:@"json"];
            NSData *response = [NSData dataWithContentsOfFile:filePath];
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];
            
            [client setDelegate:delegateMock];
            
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response];
            
            [client getDataForPerson:theMP];
            
        });
        
        
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END

