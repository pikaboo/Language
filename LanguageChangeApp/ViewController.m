//
//  ViewController.m
//  LanguageChangeApp
//
//  Created by  Lena Brusilovski on 5/28/14.
//  Copyright (c) 2014  Lena Brusilovski. All rights reserved.
//

#import "ViewController.h"
#import "Language.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIView *stamView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *currentLanguage = [NSString stringWithFormat:@"Current language is :%@, isRTL?: %@ ,bundlePath:%@"
                                 ,[Language currentLanguage].locale,@([[Language currentLanguage]isRTL]),[[Language currentLanguage].bundle bundlePath]];
    
    [self.label3 setText:currentLanguage];
    NSArray *topViews = [[Language currentLanguage]loadNibNamed:@"testNib" owner:nil options:nil];
    UIView *v = topViews[0];
    v.frame = self.stamView.bounds;
    [self.stamView addSubview:v];
    [self.segmentedControl setTitle:@"base" forSegmentAtIndex:0];
    [self.segmentedControl setTitle:@"he" forSegmentAtIndex:1];
    [self.segmentedControl setTitle:@"ar" forSegmentAtIndex:2];
    [self.segmentedControl setTitle:@"ru" forSegmentAtIndex:3];
    
    NSString *locale  =[Language currentLanguage].locale;
    [self.segmentedControl setSelectedSegmentIndex:[@[@"base",@"he",@"ar",@"ru"] indexOfObject:locale]];
    
    [self.label1 setText:@"loading string for key:clearLocation"];
    NSString *clearLocation =[[Language currentLanguage] getString:@"clearLocation"];
    [self.label2 setText:clearLocation];
    
    
}

-(IBAction)changeLanguage:(id)sender{
    
    NSInteger index = self.segmentedControl.selectedSegmentIndex;
    NSString *newLocale = [@[@"base",@"he",@"ar",@"ru"] objectAtIndex:index];
    [Language setLanguage:newLocale];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
