//
//  Sector.h
//  Brochures
//
//  Created by David Lashkhi on 02/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Sector : NSObject

@property (nonatomic, strong) NSString *sectorId;
@property (nonatomic, strong) NSString *sectorURL;
@property (nonatomic, strong) NSString *sectorName;
@property (nonatomic, strong) NSArray *brochures;

@end
