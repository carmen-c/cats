//
//  Photo.m
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "Photo.h"

@implementation Photo
- (instancetype)initWithTitle:(NSString *)title andImageUrl:(NSURL *)imageUrl
{
    self = [super init];
    if (self) {
        _title = title;
        _imageUrl = imageUrl;
    }
    return self;
}
@end
