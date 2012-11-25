//
//  CMParser.h
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWFYClient.h"

@class MP;

@interface CMParser : NSObject <TWFYClientDelegate>

-(void)parseInitialAppData;
-(void)parseMpDataWithJson:(NSString *)jsonFileName;
-(void)updateDataWithJson:(NSString *)jsonFileName;

-(void)parsePerson:(MP *)mp WithJson:(NSString *)jsonFileName;

-(void)apiRepliedWithResponse:(id)response forCall:(NSString *)call;

@end
