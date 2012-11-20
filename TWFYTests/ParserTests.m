//
//  ParserTests.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "CMParser.h"

SPEC_BEGIN(ParserTests)

describe(@"The JSON Parser", ^{
    
    __block CMParser *parser = nil;
    
    beforeEach(^{
        parser = [[CMParser alloc] init];
    });
    
    it(@"should exist", ^{
        [parser shouldNotBeNil];
    });
    
    it(@"should respond to parseMpDataWithJson:", ^{
        [[parser should] respondToSelector:@selector(parseMpDataWithJson:)];
    });
    
});

SPEC_END
