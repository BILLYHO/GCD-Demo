//
//  BDOrder.m
//  BlockDemo
//
//  Created by BILLY HO on 5/21/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "BDOrder.h"
#import "BDItem.h"

@implementation BDOrder
@synthesize orderItems;

- (int)findIndexForOrderItem:(BDItem*)searchItem
{
    NSIndexSet* indexes = [self.orderItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        BDItem* key = obj;
        
        return [[searchItem name] isEqualToString:[key name]]; //&& [searchItem price] == [key price];
    }];
    
    if ([indexes count] >= 1) {
        return [indexes firstIndex];
    }
    
    return -1;
}

- (NSMutableArray *)orderItems{
    if (!orderItems) {
        orderItems = [NSMutableArray new];
    }
    
    return orderItems;
}

- (NSString*)orderDescription {
    NSMutableString* orderDescription = [NSMutableString new];
    
    NSArray* keys = [self.orderItems sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        BDItem* item1 = (BDItem*)obj1;
        BDItem* item2 = (BDItem*)obj2;
        
        return [[item1 name] compare:[item2 name]];
    }];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BDItem* item = (BDItem*)obj;
        NSNumber* quantity = item.num;
        
        [orderDescription appendFormat:@"%@ x%@\n",[item name],quantity];
    }];
    
    return [orderDescription copy];
}

- (void)addItemToOrder:(BDItem*)inItem {
    int key = [self findIndexForOrderItem:inItem];
    
    if (key == -1) {
		inItem.num = [NSNumber numberWithInt:1];
        [[self orderItems] addObject:inItem];
    }
    else {
		BDItem *oldItem = [self.orderItems objectAtIndex:key];
		BDItem *newItem = [[BDItem alloc]init];
		newItem.name = oldItem.name;
		newItem.price = oldItem.price;
		newItem.num = [NSNumber numberWithInt: [oldItem.num intValue] + 1];
		
        [self.orderItems replaceObjectAtIndex:key withObject:newItem];
    }
}

- (void)removeItemFromOrder:(BDItem*)inItem {
    int key = [self findIndexForOrderItem:inItem];
    
    if (key != -1) {
        BDItem *oldItem = [self.orderItems objectAtIndex:key];
		if ([oldItem.num intValue] == 1)
		{
			[self.orderItems removeObjectAtIndex:key];
		}
		else
		{
			BDItem *newItem = [[BDItem alloc]init];
			newItem.name = oldItem.name;
			newItem.price = oldItem.price;
			newItem.num = [NSNumber numberWithInt: [oldItem.num intValue] - 1];
			
			[self.orderItems replaceObjectAtIndex:key withObject:newItem];

		}
    }
}

- (float)totalOrder {
    __block float total = 0.0;
    float (^itemTotal)(float,int) = ^float(float price, int quantity) {
        return price * quantity;
    };
	
    
    [self.orderItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
		BDItem* item = (BDItem*)obj;
        total += itemTotal(item.price,[item.num intValue]);
    }];
    
    return total;
}

@end
