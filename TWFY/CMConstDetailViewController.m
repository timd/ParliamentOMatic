//
//  CMConstDetailViewController.m
//  TWFY
//
//  Created by Tim on 20/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMConstDetailViewController.h"
#import "Constituency.h"
#import "Party.h"
#import "MP.h"

@interface CMConstDetailViewController ()

@property (nonatomic, strong) Party *party;
@property (nonatomic, strong) MP *mp;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *mpName;
@property (nonatomic, weak) IBOutlet UILabel *partyName;

@end

@implementation CMConstDetailViewController

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
    self.mp = [[MP findByAttribute:@"constituency" withValue:self.constituency] objectAtIndex:0];
    self.party = [self.mp party];
    
    [self.nameLabel setText:[self.constituency name]];
    [self.partyName setText:[self.party name]];
    [self.mpName setText:[self.mp name]];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
