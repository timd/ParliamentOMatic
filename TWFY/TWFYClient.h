//
//  TWFYClient.h
//  TWFY
//
//  Created by Tim on 23/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "AFHTTPClient.h"

@interface TWFYClient : AFHTTPClient

+(TWFYClient *)sharedInstance;

-(NSDictionary *)getDataForPerson:(id)person;
    
@end
