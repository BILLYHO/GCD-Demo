//
//  BDViewController.m
//  BlockDemo
//
//  Created by BILLY HO on 5/21/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "BDViewController.h"
#import "BDItem.h"
#import "BDOrder.h"

@interface BDViewController ()

@end

@implementation BDViewController

@synthesize inventory;
@synthesize order;

dispatch_queue_t queue;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
    currentItemIndex = 0;
    self.order = [BDOrder new];
	
	queue = dispatch_queue_create("com.adamburkepile.queue",nil);
}

- (void)viewDidAppear:(BOOL)animated
{
	[self updateInventoryButtons];
	
	_chalkboardLabel.text = @"Loading Inventory...";
	
	dispatch_async(queue, ^{
		self.inventory = [[BDItem retrieveInventoryItems] mutableCopy];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self updateOrderBoard];
			[self updateInventoryButtons];
			[self updateCurrentInventoryItem];
			_chalkboardLabel.text = @"Inventory Loaded\n\nHow can I help you?";
		});
	});
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeItem:(id)sender
{
	BDItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
    [order removeItemFromOrder:currentItem];
    [self updateOrderBoard];
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
	
	UILabel* removeItemDisplay = [[UILabel alloc] initWithFrame:_currentItemImageView.frame];
    [removeItemDisplay setCenter:_chalkboardLabel.center];
    [removeItemDisplay setText:@"-1"];
    [removeItemDisplay setTextAlignment:NSTextAlignmentCenter];
    [removeItemDisplay setTextColor:[UIColor redColor]];
    [removeItemDisplay setBackgroundColor:[UIColor clearColor]];
    [removeItemDisplay setFont:[UIFont boldSystemFontOfSize:32.0]];
    [[self view] addSubview:removeItemDisplay];
	
    [UIView animateWithDuration:1.0
                     animations:^{
                         [removeItemDisplay setCenter:[_currentItemImageView center]];
                         [removeItemDisplay setAlpha:0.0];
                     } completion:^(BOOL finished) {
                         [removeItemDisplay removeFromSuperview];
                     }];
}

- (IBAction)addItem:(id)sender
{
	BDItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
    [order addItemToOrder:currentItem];
    [self updateOrderBoard];
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
	
	UILabel* addItemDisplay = [[UILabel alloc] initWithFrame:_currentItemImageView.frame];
    [addItemDisplay setText:@"+1"];
    [addItemDisplay setTextColor:[UIColor whiteColor]];
    [addItemDisplay setBackgroundColor:[UIColor clearColor]];
    [addItemDisplay setTextAlignment:NSTextAlignmentCenter];
    [addItemDisplay setFont:[UIFont boldSystemFontOfSize:32.0]];
    [[self view] addSubview:addItemDisplay];
	
    [UIView animateWithDuration:1.0
                     animations:^{
                         [addItemDisplay setCenter:_currentItemImageView.center];
                         [addItemDisplay setAlpha:0.0];
                     } completion:^(BOOL finished) {
                         [addItemDisplay removeFromSuperview];
                     }];
}

- (IBAction)previousItem:(id)sender
{
	currentItemIndex--;
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
}

- (IBAction)nextItem:(id)sender
{
	currentItemIndex++;
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
}

- (IBAction)calculateTotal:(id)sender
{
	float total = [order totalOrder];
    UIAlertView* totalAlert = [[UIAlertView alloc] initWithTitle:@"Total"
                                                         message:[NSString stringWithFormat:@"$%0.2f",total]
                                                        delegate:nil
                                               cancelButtonTitle:@"Close"
                                               otherButtonTitles:nil];
    [totalAlert show];
}

- (void)updateCurrentInventoryItem
{
    if (currentItemIndex >= 0 && currentItemIndex < [self.inventory count])
	{
        BDItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
        _currentItemLabel.text = currentItem.name;
        _currentItemImageView.image = [UIImage imageNamed:[currentItem pictureFile]];
    }
}

- (void)updateInventoryButtons
{
    if (!self.inventory || [self.inventory count] == 0)
	{
        _addButton.enabled = NO;
        _removeButton.enabled = NO;
        _nextButton.enabled = NO;
        _previousButton.enabled = NO;
        _totalButton.enabled = NO;
    }
	else
	{
        if (currentItemIndex <= 0) {
            _previousButton.enabled = NO;
        } else {
            _previousButton.enabled = YES;
        }
        if (currentItemIndex >= [self.inventory count]-1) {
            _nextButton.enabled = NO;
        } else {
            _nextButton.enabled = YES;
        }
        BDItem* currentItem = [self.inventory objectAtIndex:currentItemIndex];
        if (currentItem) {
            _addButton.enabled = YES;
        } else {
            _addButton.enabled = NO;
        }
        if ([self.order findIndexForOrderItem:currentItem] == -1) {
            _removeButton.enabled = NO;
        } else {
            _removeButton.enabled = YES;
        }
        if ([order.orderItems count] == 0) {
            _totalButton.enabled = NO;
        } else {
            _totalButton.enabled = YES;
        }
    }
}

- (void)updateOrderBoard
{
    if ([order.orderItems count] == 0){
        _chalkboardLabel.text = @"No Items. Please order something!";
    } else {
        _chalkboardLabel.text = [order orderDescription];
    }
}

@end
