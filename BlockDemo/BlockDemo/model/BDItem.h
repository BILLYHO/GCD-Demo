//
//  BDItem.h
//  BlockDemo
//
//  Created by BILLY HO on 5/21/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDItem : NSObject <NSCopying>

@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) float price;
@property (nonatomic,strong) NSString* pictureFile;
@property (nonatomic,assign) NSNumber* num;

- (id)initWithName:(NSString*)inName andPrice:(float)inPrice andPictureFile:(NSString*)inPictureFile;
+ (NSArray*)retrieveInventoryItems;

@end
