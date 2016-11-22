//
//  PictureCollectionViewCell.h
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PictureCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *pictureTitleLabel;

@end
