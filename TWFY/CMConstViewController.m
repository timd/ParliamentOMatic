//
//  CMConstViewController.m
//  TWFY
//
//  Created by Tim on 20/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMConstViewController.h"
#import "Constituency.h"
#import "Party.h"
#import "MP.h"

#import "CMConstDetailViewController.h"

@interface CMConstViewController ()

@property (nonatomic, strong) NSArray *constituencies;

@end

@implementation CMConstViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CMConstTableCell" bundle:nil] forCellReuseIdentifier:@"ConstituencyCell"];
    self.title = @"Constituencies";
    self.constituencies = [Constituency findAllSortedBy:@"name" ascending:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.constituencies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConstituencyCell"];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CMConstTableCell" owner:self options:nil];
        cell = (UITableViewCell *)[nibs objectAtIndex:0];
    }
    
    // Configure the cell...
    Constituency *constituency = [self.constituencies objectAtIndex:indexPath.row];
    MP *theMP = [constituency mp];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2000];
    [nameLabel setText:[constituency name]];
    
    UIView *partyLogoView = [cell viewWithTag:1000];
    
    for (UIView *subView in [partyLogoView subviews]) {
        [subView removeFromSuperview];
    }
    
    NSString *partyShortName = [[theMP party] shortName];
    
    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:partyShortName]];
    [partyLogoView addSubview:logoImgView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 55.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    CMConstDetailViewController *detailViewController = [[CMConstDetailViewController alloc] initWithNibName:@"CMConstDetailView" bundle:nil];

    // Pass the selected object to the new view controller.
    Constituency *selectedConstituency = [self.constituencies objectAtIndex:indexPath.row];
    [detailViewController setConstituency:selectedConstituency];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
