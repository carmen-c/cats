//
//  LocationManager.h
//  Cats
//
//  Created by carmen cheng on 2016-11-23.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface LocationManager : NSObject
-(void)getLocation:(Photo *)photo completion:(void (^)(CLLocationCoordinate2D))completion;
@end
