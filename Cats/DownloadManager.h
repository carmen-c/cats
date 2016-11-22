//
//  DownloadManager.h
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadManager : NSObject

-(void)getCatPhotos:(void (^)(NSArray *photos))completion;
-(void)getImage:(NSURL *)url completion:(void (^)(UIImage *image))completion;

@end
