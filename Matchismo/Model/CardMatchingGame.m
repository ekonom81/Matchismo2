//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 03.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic,readwrite) int score;
@property (nonatomic,readwrite) int lastScore;
@property (nonatomic,readwrite) int cycleCount;
@property (nonatomic,readwrite) NSMutableArray *lastFlippedCards;

@property (nonatomic) int gameMode; //2-card-match-mode ;3-card-match-mode
@end

@implementation CardMatchingGame


#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

-(NSMutableArray *)cards
{
    if(!_cards)_cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(NSMutableArray *)lastFlippedCards
{
    if(!_lastFlippedCards)_lastFlippedCards = [[NSMutableArray alloc]init];
    return _lastFlippedCards;
}


-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
              gameMode:(NSUInteger)gameMode
{
    self = [super init];
    self.gameMode=gameMode;
    self.cycleCount=2;
    if(self){
        for (int i=0;i<cardCount;i++){
            Card *card=[deck drawRandomCard];
            if(!card){
                self=nil;
            }else{
                self.cards[i]=card;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<self.cards.count)?self.cards[index] :nil;
}



-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card=[self cardAtIndex:index];
    if(!card.isUnplayable){
        if(!card.isFaceUp){
            [self.lastFlippedCards removeAllObjects];
            self.lastScore=0;
            NSMutableArray *flippedCards= [[NSMutableArray alloc]init];
            
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    [flippedCards addObject:otherCard];
                    
                    if(flippedCards.count==self.gameMode-1){
                        int matchScore = [card match:flippedCards];
                        
                        if(matchScore){
                            card.unplayable=YES;
                            for(Card *otherCardMatch in flippedCards){
                                otherCardMatch.unplayable=YES;
                            }
                            self.score+=matchScore*MATCH_BONUS;
                            self.lastScore=MATCH_BONUS*matchScore;
                            
                        }else{
                            for(Card *otherCardMatch in flippedCards) {
                                otherCardMatch.faceUp=NO;
                                self.score-=MISMATCH_PENALTY;
                                self.lastScore-=MISMATCH_PENALTY;
                            }
                        }
                        for(Card *otherCardMatch in flippedCards){
                            [self.lastFlippedCards addObject:otherCardMatch];
                        }
                    break;
                    }
                }
            }
            self.score-=FLIP_COST;
            self.lastScore-=FLIP_COST;
        }
        card.faceUp=!card.isFaceUp;
        [self.lastFlippedCards addObject:card];
    }
}
@end
