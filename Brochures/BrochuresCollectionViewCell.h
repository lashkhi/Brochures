//
//  BrochuresCollectionViewCell.h
//  Brochures
//
//  Created by David Lashkhi on 03/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrochuresCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *retailerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brochureImageView;

@end
