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
#import "Office.h"

@implementation CMParser

-(void)parseInitialAppData {

    // Load initial data
    [self parseMpDataWithJson:@"allMPs"];
    
    // Hit API to pull down data for each MP
    NSArray *allMPs = [MP findAll];
    
    for (MP *theMP in allMPs) {
        
        
        
    }
    

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
        
        // Set first and last names
        NSArray *splitNames = [name componentsSeparatedByString:@" "];
        [newMP setFirstname:[splitNames objectAtIndex:0]];
        
        NSMutableString *lastNames = [[NSMutableString alloc] init];
        for (int i = 1; i < [splitNames count]; i++) {
            [lastNames appendString:[splitNames objectAtIndex:i]];
            
            if (i < ([splitNames count] - 1)) {
                [lastNames appendString:@" "];
            }
        }
        
        [newMP setLastname:lastNames];
        
        
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
            
            // Create party shortName
            NSArray *explodedName = [partyName componentsSeparatedByString:@" "];
            NSMutableString *shortName = [[NSMutableString alloc] init];
            for (NSString *component in explodedName) {
                [shortName appendString:component];
            }
            [newParty setShortName:shortName];
        }

        //*** Handle constituency ***//
        
        // Check for existing party
        Constituency *newConstituency = [Constituency createEntity];
        [newConstituency setName:[dict objectForKey:@"constituency"]];
        [newMP setConstituency:newConstituency];
        
        //*** Handle office if it exists ***//
        if ([dict objectForKey:@"office"]) {

            NSArray *officesArray = [dict objectForKey:@"office"];
            
            for (NSDictionary *officeDictionary in officesArray) {
                
                Office *newOffice = [Office createEntity];
                [newOffice setDept:[officeDictionary objectForKey:@"dept"]];
                [newOffice setPosition:[officeDictionary objectForKey:@"position"]];
                [newOffice setFrom_date:[officeDictionary objectForKey:@"from_date"]];
                [newOffice setTo_date:[officeDictionary objectForKey:@"to_date"]];
                
                [newMP setOffice:newOffice];
            }
            
        }
        
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

-(void)parsePerson:(MP *)mp WithJson:(NSString *)jsonFileName {
    
    // Load file
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:jsonFileName ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    // Parse file into dictionary
    NSError *error = nil;
    NSArray *rawArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
    
    // Process dictionary
    
    for (NSDictionary *dict in rawArray) {
        
        // Look for dictionary with a left_house of '9999-12-31' -
        // this indicates that the member id is valid
        if ([[dict objectForKey:@"left_house"] isEqualToString:@"9999-12-31"]) {
            
            // Process dictionary
            NSString *entered_house = [dict objectForKey:@"entered_house"];
            NSString *twfy_url = [dict objectForKey:@"url"];
            NSString *image_url = [dict objectForKey:@"image"];
            NSNumber *image_height = [dict objectForKey:@"image_height"];
            NSNumber *image_width = [dict objectForKey:@"image_width"];
            
            [mp setEntered_house:entered_house];
            [mp setTwfy_url:twfy_url];
            [mp setImage_url:image_url];
            [mp setImage_height:image_height];
            [mp setImage_width:image_width];
        }
    }

    
}

@end
