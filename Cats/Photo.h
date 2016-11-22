//
//  Photo.h
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *imageUrl;

+ (NSArray *)picturesWithArray:(NSArray *)array;
+ (instancetype)photoWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
