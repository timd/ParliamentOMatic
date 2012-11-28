//
//  CMParser.h
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWFYClient.h"

@protocol CMParserDelegateProtocol <NSObject>

-(void)handleWrittenAnswerResponseWithArray:(NSArray *)responseArray;
-(void)handleDebatesResponseWithArray:(NSArray *)responseArray;

@end

@class MP;

@interface CMParser : NSObject <TWFYClientDelegate>

@property (nonatomic, weak) id <CMParserDelegateProtocol> delegate;

-(void)parseInitialAppData;
-(void)parseMpDataWithJson:(NSString *)jsonFileName;
-(void)updateDataWithJson:(NSString *)jsonFileName;

-(void)parseWrittenAnswerDataWithJson:(NSData *)fileData;
-(void)parseDebatesDataWithJson:(NSData *)fileData;

-(void)parsePerson:(MP *)mp WithJson:(NSString *)jsonFileName;
-(void)parsePersonDataFromApi:(NSData *)data;
-(void)apiRepliedWithResponse:(id)response forCall:(NSString *)call;


@end
