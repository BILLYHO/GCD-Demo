//
//  ImageDownloader.h
//  ClassicPhotos
//
//  Created by BILLY HO on 12/20/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <Foundation/Foundation.h>

// 1
#import "PhotoRecord.h"

// 2
@protocol ImageDownloaderDelegate;

@interface ImageDownloader : NSOperation

@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;

// 3
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) PhotoRecord *photoRecord;

// 4
- (id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>) theDelegate;

@end

@protocol ImageDownloaderDelegate <NSObject>

// 5
- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader;
@end
