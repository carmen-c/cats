//
//  Photo.h
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Photo : NSObject <MKAnnotation>
@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *imageUrl;
@property (nonatomic) NSString *photoId;
@property(nonatomic) CLLocationCoordinate2D coordinate;

+ (NSArray *)picturesWithArray:(NSArray *)array;
+ (instancetype)photoWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
