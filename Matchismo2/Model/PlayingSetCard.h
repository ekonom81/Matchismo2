//
//  PlayingSetCard.h
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 11.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingSetCard : PlayingCard
@property(nonatomic,strong) NSString *color;    //value with name of color
@property(nonatomic,strong) NSString *shading;  //value with alpha number

+ (NSArray *)validColors;
+ (NSArray *)validShadings;
@end
