//
//  CMMPDetailViewController.m
//  TWFY
//
//  Created by Tim on 20/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMMPDetailViewController.h"
#import "MP.h"
#import "Constituency.h"
#import "Office.h"

@interface CMMPDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *mugshot;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *officeLabel;
@property (nonatomic, weak) IBOutlet UILabel *deptLabel;
@property (nonatomic, weak) IBOutlet UILabel *personIDLabel;
@property (nonatomic, weak) IBOutlet UILabel *constituencyLabel;

@end

@implementation CMMPDetailViewController

#pragma mark -
#pragma mark View lifecycle

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
    [self.nameLabel setText:[self.mp name]];
    
    [self.personIDLabel setText:[NSString stringWithFormat:@"%@", [self.mp person_id]]];
    
    if ([self.mp office]) {
        [self.officeLabel setText:[[self.mp office] position]];
        [self.deptLabel setText:[[self.mp office] dept]];
    } else {
        [self.officeLabel setText:nil];
        [self.deptLabel setText:nil];
    }

    NSURL *image_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.theyworkforyou.com%@", [self.mp image_url]]];
    [self getImage:image_url];
    
    UIColor *background = [UIColor colorWithPatternImage:[UIImage imageNamed:@"red"]];
    [self.view setBackgroundColor:background];
    
    [self.constituencyLabel setText:[[self.mp constituency] name]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Image methods

-(void)getImage:(NSURL *)image_url {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0), ^{

        NSData *data = [NSData dataWithContentsOfURL:image_url];
        UIImage *image = [UIImage imageWithData:data];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIView *superView = self.mugshot.superview;
            
            float hOffset = (superView.frame.size.width - image.size.width) / 2;
            float vOffset = (superView.frame.size.height - image.size.height) / 2;
            
            [self.mugshot setFrame:CGRectMake(hOffset, vOffset, image.size.width, image.size.height)];
            [self.mugshot setImage:image];
            [self.mugshot setNeedsDisplay];
            
        });
        
    });
    
}

@end
