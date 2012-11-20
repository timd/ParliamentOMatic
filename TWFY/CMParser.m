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

-(void)parseInitialAppData {

    [self parseMpDataWithJson:@"allMPs"];

}

-(void)parseMpDataWithJson:(NSString *)jsonFileName {
    
    // Load file
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:jsonFileName ofType:@"json"];

    NSError *error = nil;
    NSString *dataString = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error];
    NSData *fileData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Parse file into dictionary
    NSArray *rawArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    // Process dictionary

    for (NSDictionary *dict in rawArray) {
        
        NSString *name = [dict objectForKey:@"name"];
        
        MP *newMP = [MP createEntity];
        [newMP setName:name];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterNoStyle];
        
        NSNumber *personNum = [formatter numberFromString:[dict objectForKey:@"person_id"]];
        NSNumber *memberNum = [formatter numberFromString:[dict objectForKey:@"member_id"]];
        
        [newMP setPerson_id:personNum];
        [newMP setMember_id:memberNum];
        
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

-(void)updateDataWithJson:(NSString *)jsonFileName {
    
    // Load file
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:jsonFileName ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    // Parse file into dictionary
    NSError *error = nil;
    NSArray *rawArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
    
    // Process dictionary
    
    for (NSDictionary *dict in rawArray) {
        
        // Find person that's being updated
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterNoStyle];
        
        NSNumber *personNum = [formatter numberFromString:[dict objectForKey:@"person_id"]];

        MP *theMP = [MP findFirstByAttribute:@"person_id" withValue:personNum];
        
        if (theMP) {

            // MP has been found
            NSString *name = [dict objectForKey:@"name"];
            NSNumber *memberNum = [formatter numberFromString:[dict objectForKey:@"member_id"]];

            [theMP setName:name];
            [theMP setMember_id:memberNum];
            
            // Check for existing party
            NSString *partyName = [dict objectForKey:@"party"];
            NSArray *partiesArray = [Party findByAttribute:@"name" withValue:partyName];
            
            if ([partiesArray count] != 0) {
                Party *theParty = [partiesArray lastObject];
                [theMP setParty:theParty];
            } else {
                Party *newParty = [Party createEntity];
                [newParty setName:partyName];
                [theMP setParty:newParty];
            }
            
            // Check for existing party
            Constituency *newConstituency = [Constituency createEntity];
            [newConstituency setName:[dict objectForKey:@"constituency"]];
            [theMP setConstituency:newConstituency];
            
        } else {
            
            // Handle new MP
            NSString *name = [dict objectForKey:@"name"];
            
            MP *newMP = [MP createEntity];
            [newMP setName:name];
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterNoStyle];
            
            NSNumber *personNum = [formatter numberFromString:[dict objectForKey:@"person_id"]];
            NSNumber *memberNum = [formatter numberFromString:[dict objectForKey:@"member_id"]];
            
            [newMP setPerson_id:personNum];
            [newMP setMember_id:memberNum];
            
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
        
    }
    
    [[NSManagedObjectContext MR_defaultContext] save];

}

@end
