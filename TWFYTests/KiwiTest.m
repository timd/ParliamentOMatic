//
//  KiwiTest.m
//  TWFY
//
//  Created by Tim on 20/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(MathSpec)

beforeEach(^{
    [MagicalRecord setDefaultModelFromClass:[self class]];
	[MagicalRecord setupCoreDataStackWithInMemoryStore];
});

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END
