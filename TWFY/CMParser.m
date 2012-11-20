//
//  CMParser.m
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMParser.h"

#import "MP.h"
#import "Party.h"
#import "Constituency.h"

@implementation CMParser

-(void)parseMpDataWithJson:(NSString *)jsonFileName {
    
    // Load file
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:jsonFileName ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    // Parse file into dictionary
    NSError *error = nil;
    NSArray *rawArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
    
    // Process dictionary

    for (NSDictionary *dict in rawArray) {
        
        NSString *name = [dict objectForKey:@"name"];
        
        MP *newMP = [MP createEntity];
        [newMP setName:name];
        
        //*** Handle party ***//
        
        // Check for existing party
        NSString *partyName = [dict objectForKey:@"party"];
        NSArray *partiesArray = [Party findByAttribute:@"name" withValue:partyName];
        
        if ([partiesArray count] != 0) {
            Party *theParty = [partiesArray lastObject];
            [newMP setParty:theParty];
        } else {
            Party *newParty = [Party createEntity];
            [newParty setName:partyName];
            [newMP setParty:newParty];
        }

        //*** Handle constituency ***//
        
        // Check for existing party
        Constituency *newConstituency = [Constituency createEntity];
        [newConstituency setName:[dict objectForKey:@"constituency"]];
        [newMP setConstituency:newConstituency];
    }
    
    [[NSManagedObjectContext MR_defaultContext] save];
    
}

@end
