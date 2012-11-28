//
//  CMSettingsViewController.m
//  TWFY
//
//  Created by Tim on 22/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMSettingsViewController.h"
#import "CMParser.h"
#import "CMExporter.h"

#import "MP.h"
#import "Constituency.h"
#import "Party.h"
#import "Office.h"

@interface CMSettingsViewController ()

@end

@implementation CMSettingsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didTapActionButton:(id)sender {
    CMExporter *exporter = [[CMExporter alloc] init];
    [exporter exportDataToJson];
}

-(IBAction)loadJsonFromFile:(id)sender {
    
    [self deleteAllRecords];
    
    CMExporter *exporter = [[CMExporter alloc] init];
    [exporter loadMPDataFromJsonFile];
}

-(IBAction)didTapLoadTWFYData:(id)sender {
    
    [self deleteAllRecords];
    
    CMParser *parser = [[CMParser alloc] init];
    [parser parseInitialAppData];

}

-(void)deleteAllRecords {
    // Drop all records
    [MP MR_truncateAll];
    [Constituency MR_truncateAll];
    [Party MR_truncateAll];
    [Office MR_truncateAll];
}

@end
