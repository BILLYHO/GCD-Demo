//
//  BDOrder.h
//  BlockDemo
//
//  Created by BILLY HO on 5/21/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDItem;

@interface BDOrder : NSObject
@property (nonatomic,strong) NSMutableArray* orderItems;


- (int)findIndexForOrderItem:(BDItem*)searchItem;
- (NSMutableArray *)orderItems;
- (NSString*)orderDescription;

- (void)addItemToOrder:(BDItem*)inItem;
- (void)removeItemFromOrder:(BDItem*)inItem;
- (float)totalOrder;
@end
