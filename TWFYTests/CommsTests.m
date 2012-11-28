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
#import "OHHTTPStubs.h"

#import "MP.h"
#import "Party.h"
#import "Constituency.h"
#import "Office.h"

SPEC_BEGIN(CommsTests)

describe(@"The Comms object", ^{

    beforeAll(^{
        
        [OHHTTPStubs addRequestHandler:^OHHTTPStubsResponse*(NSURLRequest *request, BOOL onlyCheck) {
            
            //NSString *basename = [request.URL.absoluteString lastPathComponent];
            
            NSURL *requestURL = [request URL];
            NSString *urlString = [requestURL absoluteString];
            
            if ([urlString rangeOfString:@"getPerson"].location != NSNotFound) {
                // Handle getPerson
                return [OHHTTPStubsResponse responseWithFile:@"getPerson.json"
                                                 contentType:@"text/json"
                                                responseTime:OHHTTPStubsDownloadSpeedEDGE];
            }
            
            if ([urlString rangeOfString:@"getWrans"].location != NSNotFound) {
                // Handle getPerson
                return [OHHTTPStubsResponse responseWithFile:@"getWrans.json"
                                                 contentType:@"text/json"
                                                responseTime:OHHTTPStubsDownloadSpeedEDGE];
            }

            if ([urlString rangeOfString:@"getDebates"].location != NSNotFound) {
                // Handle getPerson
                return [OHHTTPStubsResponse responseWithFile:@"getDebates.json"
                                                 contentType:@"text/json"
                                                responseTime:OHHTTPStubsDownloadSpeedEDGE];
            }

            return nil;
            
        }];

    });
        
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
        
    });
    
    context(@"when calling getDataForPerson", ^{
        
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
        
    });
    
    context(@"when calling getWransForPerson", ^{

        it(@"should respond to getWransForPerson:", ^{
            [[client should] respondToSelector:@selector(getWransForPerson:)];
        });

        it(@"should return nil if not passed a valid MP object", ^{
            
            NSString *theString = @"This won't work";
            id response = nil;
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];
            NSString *callType = @"getWrans";
            
            [client setDelegate:delegateMock];
            
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response forCall:callType];
            
            [client getWransForPerson:theString];
            
            [response shouldBeNil];
            
        });
        
        it(@"should receive some data if passed a valid MP object", ^{
            
            // Create the dummy MP object to send through to the TWFYClient
            MP *theMP = [MP createEntity];
            [theMP setPerson_id:@10001];
            
            // Create the expected response object as an NSData representation of the getWrans file
            NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"getWrans" ofType:@"json"];
            NSData *response = [NSData dataWithContentsOfFile:filePath];
            
            // Create a mock object to act as the TWFY delegate, and make it 'conform' to
            // the TWFYClientDelegate protocol
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];
            
            // Set the client's delegate property
            [client setDelegate:delegateMock];
            
            // Set call type
            NSString *callType = @"getWrans";
            
            // Call the method under test
            [client getWransForPerson:theMP];
            
            // Set the assertion that eventually there should an 'apiRepliedWithResponse' message,
            // and it will have the response object as a parameter
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response forCall:callType];
            
        });

    });
    
    context(@"when calling getDebatesForPerson", ^{
        
        it(@"should respond to getDebatesForPerson:", ^{
            [[client should] respondToSelector:@selector(getDebatesForPerson:)];
        });
        
        it(@"should return nil if not passed a valid MP object", ^{
            
            NSString *theString = @"This won't work";
            id response = nil;
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];
            NSString *callType = @"getDebates";
            
            [client setDelegate:delegateMock];
            
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response forCall:callType];
            
            [client getDebatesForPerson:theString];
            
            [response shouldBeNil];
            
        });
        
        it(@"should receive some data if passed a valid MP object", ^{
            
            // Create the dummy MP object to send through to the TWFYClient
            MP *theMP = [MP createEntity];
            [theMP setPerson_id:@10001];
            
            // Create the expected response object as an NSData representation of the getWrans file
            NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"getDebates" ofType:@"json"];
            NSData *response = [NSData dataWithContentsOfFile:filePath];
            
            // Create a mock object to act as the TWFY delegate, and make it 'conform' to
            // the TWFYClientDelegate protocol
            id delegateMock = [KWMock mockForProtocol:@protocol(TWFYClientDelegate)];
            
            // Set the client's delegate property
            [client setDelegate:delegateMock];
            
            // Set call type
            NSString *callType = @"getDebates";
            
            // Set the assertion that eventually there should an 'apiRepliedWithResponse' message,
            // and it will have the response object as a parameter
            [[[delegateMock shouldEventually] receive] apiRepliedWithResponse:response forCall:callType];

            // Call the method under test
            [client getDebatesForPerson:theMP];
            
        });

        
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END

