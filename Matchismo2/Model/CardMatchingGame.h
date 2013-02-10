//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 03.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

#define FLIP_COST 1

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
              gameMode:(NSUInteger)gameMode;
-(void)flipCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;


@property (nonatomic,readonly) NSMutableArray *lastFlippedCards;
@property (nonatomic,readonly) int score;
@property (nonatomic,readonly) int lastScore;

@end
