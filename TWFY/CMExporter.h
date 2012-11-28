//
//  CMExporter.h
//  TWFY
//
//  Created by Tim on 28/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMExporter : NSObject

-(void)exportDataToJson;
-(void)loadMPDataFromJsonFile;

@end
