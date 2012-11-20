//
//  CMParser.h
//  TWFY
//
//  Created by Tim on 04/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMParser : NSObject

-(void)parseMpDataWithJson:(NSString *)jsonFileName;
-(void)updateDataWithJson:(NSString *)jsonFileName;

@end
