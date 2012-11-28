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

#define kGetPersonCall @"getPerson"
#define kGetWritteAnswerCall @"getWrans"
#define kGetDebatesCall @"getDebates"

@interface CMParser()

@property (nonatomic, strong) CMParser *parser;
@property (nonatomic, strong) TWFYClient *client;

@end

@implementation CMParser


-(void)parsePersonDataFromApi:(NSData *)data {
    
    NSError *error = nil;
    NSArray *rawArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

    for (NSDictionary *dict in rawArray) {
        
        NSString *person_id = [dict objectForKey:@"person_id"];
        
        if ([person_id isEqualToString:@"11148"]) {
            NSLog(@"11148");
        }
        
        NSArray *mps = [MP findByAttribute:@"person_id" withValue:[NSNumber numberWithInt:[person_id integerValue]]];
        
        MP *mp = [mps objectAtIndex:0];
        
        if (mp) {

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

}

-(void)parseInitialAppData {

    // Load initial data
    [self parseMpDataWithJson:@"allMPs"];
    
    [self updateFromTWFY];
    
}

-(void)updateFromTWFY {

    // Hit API to pull down data for each MP
    self.client = [TWFYClient sharedInstance];
    [self.client setDelegate:self];

    NSArray *allMPs = [MP findAll];
    
    for (MP *theMP in allMPs) {
        NSLog(@"Getting MP: %@", [theMP name]);
        [self.client getDataForPerson:theMP];
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

#pragma mark -
#pragma mark TWFYClient delegate methods

-(void)apiRepliedWithResponse:(id)response forCall:(NSString *)call {
    
    NSLog(@"got response...");

    // Handle data arriving from TWFY client
    if ([call isEqualToString:kGetPersonCall]) {
        
        // Handle getPerson data
        NSData *responseData = (NSData *)response;
        NSLog(@"got data...");
        [self parsePersonDataFromApi:responseData];
        
    }
    
    if ([call isEqualToString:kGetWritteAnswerCall]) {
        NSData *responseData = (NSData *)response;
        NSLog(@"got data...");
        [self parseWrittenAnswerDataWithJson:responseData];
    }

    if ([call isEqualToString:kGetWritteAnswerCall]) {
        NSData *responseData = (NSData *)response;
        NSLog(@"got data...");
        [self parseWrittenAnswerDataWithJson:responseData];
    }

    if ([call isEqualToString:kGetDebatesCall]) {
        NSData *responseData = (NSData *)response;
        NSLog(@"got data...");
        [self parseDebatesDataWithJson:responseData];
    }
}

#pragma mark -
#pragma mark Written Answers

-(void)parseWrittenAnswerDataWithJson:(NSData *)fileData {
    
    // Parse file into dictionary
    NSError *error = nil;
    NSDictionary *inputDict = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
 
    // Extract payload
    NSArray *rows = [inputDict objectForKey:@"rows"];

    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *rawDict in rows) {
    
        // Process hdate
        NSString *hdate = [rawDict objectForKey:@"hdate"];
        
        // process body
        NSString *body = [rawDict objectForKey:@"body"];
        
        // process extract
        NSString *extract = [rawDict objectForKey:@"extract"];
        
        // process parent
        NSDictionary *parentDict = [rawDict objectForKey:@"parent"];
        NSString *parent = [parentDict objectForKey:@"body"];
        
        NSDictionary *returnDict = @{@"hdate" : hdate, @"body" : body, @"extract" : extract, @"parent" : parent};
        [returnArray addObject:returnDict];
        
    }
    
    NSArray *finalArray = [NSArray arrayWithArray:returnArray];

    [self.delegate handleWrittenAnswerResponseWithArray:finalArray];
    
}

#pragma mark -
#pragma mark Debates

-(void)parseDebatesDataWithJson:(NSData *)fileData {
    
    // Parse file into dictionary
    NSError *error = nil;
    NSDictionary *inputDict = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
    
    // DO STUFF
    NSArray *rowsArray = [inputDict objectForKey:@"rows"];
    
    NSMutableArray *workingArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *rowDictionary in rowsArray) {
        
        NSString *hdate = [rowDictionary objectForKey:@"hdate"];
        NSString *body = [rowDictionary objectForKey:@"body"];
        NSString *extract = [rowDictionary objectForKey:@"extract"];
        NSString *listurl = [rowDictionary objectForKey:@"listurl"];
        
        NSDictionary *parentDictionary = [rowDictionary objectForKey:@"parent"];
        NSString *parent = [parentDictionary objectForKey:@"body"];
        NSDictionary *workingDictionary = @{@"hdate" : hdate, @"body" : body, @"extract" : extract, @"parent" : parent, @"listurl" : listurl};
        [workingArray addObject:workingDictionary];
    }
    
    NSArray *finalArray = [NSArray arrayWithArray:workingArray];
    [self.delegate handleDebatesResponseWithArray:finalArray];
    
}

-(void)dealloc {
    [self.client setDelegate:nil];
}

@end
