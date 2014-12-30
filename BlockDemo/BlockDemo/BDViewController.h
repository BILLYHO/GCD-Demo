//
//  BDViewController.h
//  BlockDemo
//
//  Created by BILLY HO on 5/21/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDOrder;

@interface BDViewController : UIViewController {
    int currentItemIndex;
}

@property (strong, nonatomic) NSMutableArray* inventory;
@property (strong, nonatomic) BDOrder* order;

@property (strong, nonatomic) IBOutlet UIButton *removeButton;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *totalButton;
@property (strong, nonatomic) IBOutlet UILabel *chalkboardLabel;
@property (strong, nonatomic) IBOutlet UIImageView *currentItemImageView;
@property (strong, nonatomic) IBOutlet UILabel *currentItemLabel;

- (IBAction)removeItem:(id)sender;
- (IBAction)addItem:(id)sender;
- (IBAction)previousItem:(id)sender;
- (IBAction)nextItem:(id)sender;
- (IBAction)calculateTotal:(id)sender;

- (void)updateCurrentInventoryItem;
- (void)updateInventoryButtons;
- (void)updateOrderBoard;
@end
