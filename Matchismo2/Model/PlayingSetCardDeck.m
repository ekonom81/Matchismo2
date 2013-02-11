//
//  PlayingSetCardDeck.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 11.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingSetCardDeck.h"
#import "PlayingSetCard.h"

@implementation PlayingSetCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingSetCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingSetCard maxRank]; rank++) {
                for(NSString *color in [PlayingSetCard validColors]){
                    for(NSString *shading in [PlayingSetCard validShadings]){
                    
                    PlayingSetCard *card = [[PlayingSetCard alloc] init];
                    card.rank = rank;
                    card.suit = suit;
                    card.color=color;
                    card.shading=shading;
                    [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
