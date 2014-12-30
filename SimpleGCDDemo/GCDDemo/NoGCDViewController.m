//
//  NoGCDViewController.m
//  GCDDemo
//
//  Created by BILLY HO on 5/4/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "NoGCDViewController.h"
#import "MainViewController.h"

@interface NoGCDViewController ()

@end

@implementation NoGCDViewController

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
	sleep(1);
	NSError *error;
	NSString *urlString = @"http://www.weather.com.cn/data/cityinfo/101010100.html";
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	if (response)
	{
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
		_data = [dic objectForKey:@"weatherinfo"];
	}
	_weatherLabel.text = [_data objectForKey:@"weather"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
	MainViewController *main = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
	[self presentViewController:main animated:YES completion:nil];

}

@end
