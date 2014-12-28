//
//  PhotoRecord.m
//  ClassicPhotos
//
//  Created by BILLY HO on 12/20/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "PhotoRecord.h"

@implementation PhotoRecord

@synthesize name = _name;
@synthesize image = _image;
@synthesize URL = _URL;
@synthesize hasImage = _hasImage;
@synthesize filtered = _filtered;
@synthesize failed = _failed;


- (BOOL)hasImage {
	return _image != nil;
}


- (BOOL)isFailed {
	return _failed;
}


- (BOOL)isFiltered {
	return _filtered;
}

@end
