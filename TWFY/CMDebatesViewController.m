//
//  CMDebatesViewController.m
//  TWFY
//
//  Created by Tim on 28/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMDebatesViewController.h"

#import "TWFYClient.h"
#import "CMParser.h"

@interface CMDebatesViewController ()

@property (nonatomic, strong) CMParser *parser;
@property (nonatomic, strong) TWFYClient *client;

@end

@implementation CMDebatesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.client = [TWFYClient sharedInstance];
    self.parser = [[CMParser alloc] init];
    [self.parser setDelegate:self];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    NSLog(@"viewDidAppear");

    // Call debate
    [self.client getDebatesForPerson:self.mp];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CMParserDelegate protocol methods

-(void)handleDebatesResponseWithArray:(NSArray *)responseArray {
    
    NSLog(@"Debates response: %@", responseArray);
    
}

@end
