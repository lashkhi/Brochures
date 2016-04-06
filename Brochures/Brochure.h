//
//  Brochure.h
//  Brochures
//
//  Created by David Lashkhi on 02/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Brochure : NSObject

@property (nonatomic, strong) NSString *brochureId;
@property (nonatomic, strong) NSString *brochureCoverURL;
@property (nonatomic, strong) NSString *brochureTitle;
@property (nonatomic, strong) NSString *brochureRetailerName;

@end
