//
//  PictureCollectionViewCell.m
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "PictureCollectionViewCell.h"
#import "DownloadManager.h"

@interface PictureCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *photoTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic) DownloadManager *downloadManager;
@end

@implementation PictureCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.downloadManager = [[DownloadManager alloc]init];
}

-(void)setPhoto:(Photo *)photo{
    _photo = photo;
    [self configureCell];
}

-(void)configureCell{
    self.photoTitleLabel.text = self.photo.title;
    [self downloadImage];
}

-(void)downloadImage{
    self.photoImageView.image = nil;
    NSURL *tempPhotoUrl = self.photo.imageUrl;
    [self.downloadManager getImage:self.photo.imageUrl completion:^(UIImage *image) {
        if ([self.photo.imageUrl isEqual:tempPhotoUrl]) {
            self.photoImageView.image = image;
        }
    }];
}

@end
