//
//  Place.h
//  Places
//
//  Created by John Schindler on 3/3/15.
//  Copyright (c) 2015 John Schindler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (strong, nonatomic) NSString *City;
@property (strong, nonatomic) NSString *State;
@property (strong, nonatomic) NSString *Country;
@property (strong, nonatomic) NSString *placeId;

@end
