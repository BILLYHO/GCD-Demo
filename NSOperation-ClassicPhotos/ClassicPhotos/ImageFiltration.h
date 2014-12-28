//
//  ImageFiltration.h
//  ClassicPhotos
//
//  Created by BILLY HO on 12/21/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <Foundation/Foundation.h>
// 1
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "PhotoRecord.h"

// 2
@protocol ImageFiltrationDelegate;

@interface ImageFiltration : NSOperation

@property (nonatomic, weak) id <ImageFiltrationDelegate> delegate;
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) PhotoRecord *photoRecord;

- (id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageFiltrationDelegate>)theDelegate;

@end

@protocol ImageFiltrationDelegate <NSObject>
- (void)imageFiltrationDidFinish:(ImageFiltration *)filtration;
@end
