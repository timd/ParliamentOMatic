//
//  ParserTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "CMParser.h"
#import "CMMPTableViewController.h"
#import "MP.h"
#import "Party.h"
#import "Constituency.h"

SPEC_BEGIN(MPTableTests)

describe(@"The JSON Parser", ^{
    
    __block CMMPTableViewController *vc = nil;
    __block CMParser *parser = nil;
    
    beforeEach(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        
        parser = [[CMParser alloc] init];
        NSString *filename = @"test-mps";
        [parser parseMpDataWithJson:filename];
        
        vc = [[CMMPTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
    });
    
    context(@"when created", ^{
        
        it(@"should exist", ^{
            [vc shouldNotBeNil];
        });
        
    });
    
    context(@"when running viewDidLoad", ^{
        
        it(@"should respond to viewDidLoad", ^{
            [[vc should] respondToSelector:@selector(viewDidLoad)];
        });
        
        it(@"should have populated the mps array", ^{
            [vc viewDidLoad];
            [[vc mpsArray] shouldNotBeNil];
        });
        
        it(@"should have sorted it by last name", ^{
            [vc viewDidLoad];
            MP *firstMP = [[vc mpsArray] objectAtIndex:0];
            [[[firstMP lastname] should] equal:@"Double Barrelled"];
        });
        
    });
    
    
    afterEach(^{
        vc = nil;
        parser = nil;
        [MagicalRecord cleanUp];
    });
    
});

SPEC_END
