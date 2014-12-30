//
//  MainViewController.m
//  GCDDemo
//
//  Created by BILLY HO on 5/4/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "MainViewController.h"
#import "NoGCDViewController.h"
#import "GCDViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
- (IBAction)gcdClicked:(id)sender {
	GCDViewController *gcd = [[GCDViewController alloc] initWithNibName:@"GCDViewController" bundle:nil];
	[self presentViewController:gcd animated:YES completion:nil];
}

- (IBAction)nogcdClicked:(id)sender {
	NoGCDViewController *nog = [[NoGCDViewController alloc]initWithNibName:@"NoGCDViewController" bundle:nil];
	[self presentViewController:nog animated:YES completion:nil];
}

@end
