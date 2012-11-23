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
            NSDictionary *returnDict = [client getDataForPerson:theString];
            [returnDict shouldBeNil];
        });
        
        it(@"should return an NSDictionary if it's passed a valid MP object", ^{
            theMP = [MP createEntity];
            id returnDict = [client getDataForPerson:theMP];
            [returnDict shouldNotBeNil];
            [[returnDict should] beKindOfClass:[NSDictionary class]];
        });
        
    });
    
    context(@"when calling the TWFY API", ^{
        
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];

        MP *mp = [MP createEntity];
        [mp setPerson_id:[NSNumber numberWithInt:10900]];
        
        NSDictionary *results = [client getDataForPerson:mp];
        
        [results shouldNotBeNil];
        
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END

