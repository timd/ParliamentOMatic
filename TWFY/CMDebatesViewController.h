//
//  CMDebatesViewController.h
//  TWFY
//
//  Created by Tim on 28/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMParser.h"

@class MP;

@interface CMDebatesViewController : UIViewController <CMParserDelegateProtocol>

@property (nonatomic, strong) MP *mp;

@end
