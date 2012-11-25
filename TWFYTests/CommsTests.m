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
            NSString *callType = @"getPerson";

            [client setDelegate:delegateMock];
            
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response forCall:callType];
            
            [client getDataForPerson:theString];

            [response shouldBeNil];
            
        });
        
        it(@"should receive some data if passed a valid MP object", ^{
            
            // Create the dummy MP object to send through to the TWFYClient
            MP *theMP = [MP createEntity];
            [theMP setPerson_id:@10900];
            
            // Create the expected response object as an NSData representation of the getPerson.json file
            NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"getPerson" ofType:@"json"];
            NSData *response = [NSData dataWithContentsOfFile:filePath];
            
            // Create a mock object to act as the TWFY delegate, and make it 'conform' to
            // the TWFYClientDelegate protocol
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];
            
            // Set the client's delegate property
            [client setDelegate:delegateMock];
            
            // Set call type
            NSString *callType = @"getPerson";
            
            // Set the assertion that eventually there should an 'apiRepliedWithResponse' message,
            // and it will have the response object as a parameter
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response forCall:callType];
            
            // Call the method under test
            [client getDataForPerson:theMP];
            
        });
        
        it(@"should update the MP's image", ^{
            
            // Create the dummy MP object to send through to the TWFYClient
            MP *theMP = [MP createEntity];
            [theMP setPerson_id:@10900];
            
            // Create the expected response object as an NSData representation of the getPerson.json file
            NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"getPerson" ofType:@"json"];
            NSData *response = [NSData dataWithContentsOfFile:filePath];
            
            // Create a mock object to act as the TWFY delegate, and make it 'conform' to
            // the TWFYClientDelegate protocol
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];
            
            // Set the client's delegate property
            [client setDelegate:delegateMock];
            
            // Set call type
            NSString *callType = @"getPerson";
            
            // Set the assertion that eventually there should an 'apiRepliedWithResponse' message,
            // and it will have the response object as a parameter
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response forCall:callType];
            
            // Call the method under test
            [client getDataForPerson:theMP];

            // Eventually, the MP's data should be updated
            [[[theMP image_url] should] equal:@"/images/mps/10900.jpg"];
            
        });
        
        
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END

