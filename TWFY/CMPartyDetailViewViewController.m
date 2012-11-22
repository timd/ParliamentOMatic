//
//  CMPartyDetailViewViewController.m
//  TWFY
//
//  Created by Tim on 22/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMPartyDetailViewViewController.h"
#import "Party.h"

@interface CMPartyDetailViewViewController ()

@property (nonatomic, weak) IBOutlet UILabel *partyName;

@end

@implementation CMPartyDetailViewViewController

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
    [self.partyName setText:[self.party name]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
