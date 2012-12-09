//
//  CMMPMainPageViewController.m
//  TWFY
//
//  Created by Tim on 29/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMMPMainPageViewController.h"
#import "MP.h"

#import "CMInterestsViewController.h"
#import "CMQuestionsViewController.h"
#import "CMDebatesViewController.h"
#import "CMMPDetailViewController.h"

#import "SMPageControl.h"

@interface CMMPMainPageViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *pagesArray;

@end

@implementation CMMPMainPageViewController

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
    
    CMMPDetailViewController *detailVC = [[CMMPDetailViewController alloc] initWithNibName:@"CMMPDetailView" bundle:nil];
    [detailVC setMp:self.mp];
    
    CMInterestsViewController *interestsVC = [[CMInterestsViewController alloc] initWithNibName:@"CMInterestsView" bundle:nil];
    CMQuestionsViewController *questionsVC = [[CMQuestionsViewController alloc] initWithNibName:@"CMQuestionsView" bundle:nil];
    CMDebatesViewController *debatesVC = [[CMDebatesViewController alloc] initWithNibName:@"CMDebatesView" bundle:nil];
    [debatesVC setMp:self.mp];
    
    self.pagesArray = [NSArray arrayWithObjects:detailVC, debatesVC, questionsVC, interestsVC, nil];
    
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.delegate = self;
    
    [self.pageControl setNumberOfPages:[self.pagesArray count]];
    [self.pageControl sizeToFit];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView  {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.pagesArray count], self.scrollView.frame.size.height);
    
    for (int i=0; i < [self.pagesArray count]; i++) {
     
        UIViewController *vc = [self.pagesArray objectAtIndex:i];

        vc.view.frame = CGRectMake(self.scrollView.frame.size.width * i, 0, vc.view.frame.size.width, vc.view.frame.size.height);
        NSLog(@"vc = %@", vc);
        NSLog(@"Frame = %@", NSStringFromCGRect(vc.view.frame));

        [self.scrollView addSubview:vc.view];
     
     }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
