//
//  PlayingCard.h
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 03.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property(nonatomic) NSUInteger rank;
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
