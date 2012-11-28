//
//  CMExporter.m
//  TWFY
//
//  Created by Tim on 28/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMExporter.h"

#import "Party.h"
#import "MP.h"
#import "Constituency.h"
#import "Office.h"

@implementation CMExporter

-(id)init {
    
    self = [super init];
    if (self) {
        // Configure
    }
    return self;
}

-(void)exportDataToJson {
    
    NSArray *parties = [Party findAll];
    
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *partiesArray = [[NSMutableArray alloc] init];
    
    // Iterate across parties
    for (Party *theParty in parties) {

        NSMutableDictionary *partyDict = [[NSMutableDictionary alloc] init];
        [partyDict setObject:[theParty name] forKey:@"name"];
        [partyDict setObject:[theParty shortName] forKey:@"shortName"];

        // Get MPs
        NSSet *partyMPs = [theParty mps];
        NSMutableArray *mpsArray = [[NSMutableArray alloc] init];
        
        // Iterate across MPs
        for (MP *theMP in partyMPs) {
            
            NSMutableDictionary *mpDict = [[NSMutableDictionary alloc] init];
            [mpDict setObject:[theMP name] forKey:@"name"];
            [mpDict setObject:[theMP firstname] forKey:@"firstname"];
            [mpDict setObject:[theMP lastname] forKey:@"lastname"];
            [mpDict setObject:[theMP member_id] forKey:@"member_id"];
            [mpDict setObject:[theMP person_id] forKey:@"person_id"];

            if ([theMP entered_house]) {
                [mpDict setObject:[theMP entered_house] forKey:@"entered_house"];
            }
            
            if ([theMP twfy_url]) {
                [mpDict setObject:[theMP twfy_url] forKey:@"tyfw_url"];
            }
            
            if ([theMP image_url]) {
                [mpDict setObject:[theMP image_height] forKey:@"image_height"];
                [mpDict setObject:[theMP image_width] forKey:@"image_width"];
                [mpDict setObject:[theMP image_url] forKey:@"image_url"];
            }
            
            // Get constituency
            Constituency *theConst = [theMP constituency];
            NSMutableDictionary *theConstDict = [[NSMutableDictionary alloc] init];
            [theConstDict setObject:[theConst name] forKey:@"name"];
            [mpDict setObject:theConstDict forKey:@"constituency"];
            
            // Get office
            Office *theOffice = [theMP office];
            if (theOffice) {
                NSMutableDictionary *theOfficeDict = [[NSMutableDictionary alloc] init];
                [theOfficeDict setObject:[theOffice position] forKey:@"position"];
                [theOfficeDict setObject:[theOffice dept] forKey:@"dept"];
                [theOfficeDict setObject:[theOffice from_date] forKey:@"from_date"];
                [theOfficeDict setObject:[theOffice to_date] forKey:@"to_date"];
                [mpDict setObject:theOfficeDict forKey:@"office"];
            }
            
            // Add MP to mpsArray
            [mpsArray addObject:mpDict];
            
        }
        
        // Add mpsArray to party
        [partyDict setObject:mpsArray forKey:@"mps"];
        
        // Add Party to partiesArray
        [partiesArray addObject:partyDict];
        
    }
    
    [jsonDictionary setObject:partiesArray forKey:@"parties"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!error) {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
        
        NSError *error;
        BOOL succeed = [jsonString writeToFile:[documentsDirectory stringByAppendingPathComponent:@"data.json"]
                                  atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (!succeed){
            // Handle error here
            NSLog(@"error writing file");
        }
    }
    
}

-(void)loadMPDataFromJsonFile {
    
    // Load file
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"data" ofType:@"json"];
    
    NSError *error = nil;
    NSString *dataString = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&error];
    NSData *fileData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Parse file into dictionary
    NSDictionary *rawDictionary = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    // Process dictionary
    NSArray *partiesArray = [rawDictionary objectForKey:@"parties"];
    
    for (NSDictionary *partyDictionary in partiesArray) {

        Party *newParty = [Party createEntity];
        
        [newParty setName:[partyDictionary objectForKey:@"name"]];
        [newParty setShortName:[partyDictionary objectForKey:@"shortName"]];
        
        NSLog(@"Party = %@", [newParty name]);
        
        // Iterate across MPs
        NSArray *mpsArray = [partyDictionary objectForKey:@"mps"];
        
        for (NSDictionary *mpDictionary in mpsArray) {

            // Process each MP
            MP *newMP = [MP createEntity];

            // Set name
            [newMP setName:[mpDictionary objectForKey:@"name"]];
            
            // Set first and last names
            [newMP setFirstname:[mpDictionary objectForKey:@"firstname"]];
            [newMP setLastname:[mpDictionary objectForKey:@"lastname"]];
            
            // Set person and member numbers
            [newMP setPerson_id:[mpDictionary objectForKey:@"person_id"]];
            [newMP setMember_id:[mpDictionary objectForKey:@"member_id"]];
            
            // Handle TWFY data points
            NSString *entered_house = [mpDictionary objectForKey:@"entered_house"];
            NSString *twfy_url = [mpDictionary objectForKey:@"twfy_url"];
            NSString *image_url = [mpDictionary objectForKey:@"image_url"];
            NSNumber *image_height = [mpDictionary objectForKey:@"image_height"];
            NSNumber *image_width = [mpDictionary objectForKey:@"image_width"];
            
            [newMP setEntered_house:entered_house];
            [newMP setTwfy_url:twfy_url];
            [newMP setImage_url:image_url];
            [newMP setImage_height:image_height];
            [newMP setImage_width:image_width];
            
            // Handle constituency
            NSDictionary *constituencyDictionary = [mpDictionary objectForKey:@"constituency"];
            Constituency *newConstituency = [Constituency createEntity];
            [newConstituency setName:[constituencyDictionary objectForKey:@"name"]];
            [newMP setConstituency:newConstituency];
            
            // Handle office
            if ([mpDictionary objectForKey:@"office"]) {
                
                NSDictionary *officeDictionary = [mpDictionary objectForKey:@"office"];
                
                    Office *newOffice = [Office createEntity];
                    
                    if ([officeDictionary objectForKey:@"dept"]) {
                        [newOffice setDept:[officeDictionary objectForKey:@"dept"]];
                    }
                    
                    [newOffice setPosition:[officeDictionary objectForKey:@"position"]];
                    [newOffice setFrom_date:[officeDictionary objectForKey:@"from_date"]];
                    [newOffice setTo_date:[officeDictionary objectForKey:@"to_date"]];
                    [newMP setOffice:newOffice];
                
            }

            // Add MP to party
            [newParty addMpsObject:newMP];
            
            NSLog(@"Name = %@", [newMP name]);
            NSLog(@"Consitutency = %@", [[newMP constituency] name]);
            NSLog(@"Office = %@", [[newMP office] position]);
            
        }
        
    }
    
    [[NSManagedObjectContext MR_defaultContext] save];
    
}

@end
