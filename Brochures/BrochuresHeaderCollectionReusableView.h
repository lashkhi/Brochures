//
//  BrochuresHeaderCollectionReusableView.h
//  Brochures
//
//  Created by David Lashkhi on 03/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrochuresHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBrochuresLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sectorImage;

@end
