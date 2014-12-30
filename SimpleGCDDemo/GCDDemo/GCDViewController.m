//
//  GCDViewController.m
//  GCDDemo
//
//  Created by BILLY HO on 5/4/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "GCDViewController.h"
#import "MainViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

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
	
	//  后台执行：
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
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
		NSLog(@"background");
		dispatch_async(dispatch_get_main_queue(), ^{
			_weatherLabel.text = [_data objectForKey:@"weather"];
			NSLog(@"main");
		});
		
	});
	
	NSLog(@"back");
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
