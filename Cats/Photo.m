//
//  Photo.m
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
       NSString *string =
        [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
         dictionary[@"farm"],
         dictionary[@"server"],
         dictionary[@"id"],
         dictionary[@"secret"]];
         self.imageUrl = [NSURL URLWithString:string];
    }
    return self;
}

+(instancetype)photoWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

+(NSArray *)picturesWithArray:(NSArray *)array{
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *photoInfo in array) {
        Photo *photo = [[Photo alloc]initWithDictionary:photoInfo];
        [result addObject:photo];
    }
    return result;
}
@end
